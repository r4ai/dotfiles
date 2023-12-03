import * as path from "https://deno.land/std@0.208.0/path/mod.ts";
import * as TOML from "https://deno.land/std@0.109.0/encoding/toml.ts";
import { walkSync } from "https://deno.land/std@0.208.0/fs/mod.ts";

const TYPST_TOML_PATH = "typst.toml";
const NAMESPACE = "local";

/**
 * Get the data directory for the current platform.
 * @see https://github.com/typst/packages#local-packages
 */
const getDataDir = () => {
  switch (Deno.build.os) {
    case "darwin":
      return path.join(Deno.env.get("HOME")!, "Library", "Application Support");
    case "windows":
      return path.join(Deno.env.get("APPDATA")!);
    default:
      return path.join(Deno.env.get("HOME")!, ".local", "share");
  }
};

/**
 * The package metadata format.
 * @see https://github.com/typst/packages#package-format
 */
type Package = {
  name: string;
  version: `${string}.${string}.${string}`;
  entrypoint: string;
  description: string;
  authors: string[];
  license: string;
  homepage?: string;
  repository?: string;
  keywords?: string[];
  compiler?: `${string}.${string}.${string}`;
  exclude?: string[];
};

/**
 * Get the package metadata from typst.toml.
 */
const getPackageMeta = (packageTomlPath: string) => {
  const packageToml = Deno.readTextFileSync(packageTomlPath);
  const packageMeta = TOML.parse(packageToml).package as Package;
  return packageMeta;
};

// Get the data directory
const dataDir = getDataDir();

// Read the package metadata from typst.toml
const packageMeta = getPackageMeta(TYPST_TOML_PATH);

// Create the package directory
const packageDir = path.join(
  dataDir,
  "typst",
  "packages",
  NAMESPACE,
  packageMeta.name,
  packageMeta.version
);
Deno.mkdirSync(packageDir, { recursive: true });

// Copy the package files
const packageFiles = walkSync(".", { includeDirs: false });
const excludeFiles =
  packageMeta.exclude?.map((file) => Deno.realPathSync(file)) ?? [];
for (const packageFile of packageFiles) {
  const fromPath = packageFile.path;
  const toPath = path.join(packageDir, packageFile.name);
  if (excludeFiles.includes(fromPath)) continue;
  Deno.mkdirSync(path.dirname(toPath), { recursive: true });
  Deno.copyFileSync(fromPath, toPath);
}

// Log the success message
console.log(
  `Installed ${packageMeta.name} v${packageMeta.version} successfully!`
);
console.log(`The package is stored in \`${packageDir}\``);
console.log("");
console.log(
  `You can import the package with \`#import "@local/${packageMeta.name}:${packageMeta.version}": *\``
);
