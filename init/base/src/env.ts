import { path } from "./dependencies.ts";

const hasChezmoiInstalled = !!Deno.env.get("CHEZMOI");
if (!hasChezmoiInstalled) {
  throw new Error("Chezmoi is not installed. Please install it first.");
}

const hasFishInstalled = !!Deno.env.get("FISH_VERSION");
if (!hasFishInstalled) {
  throw new Error("Fish is not installed. Please install it first.");
}

export const homeDir = Deno.env.get("CHEZMOI_HOME_DIR")!;
export const configDir = path.join(homeDir, ".config");
export const fishConfigDir = Deno.env.get("__fish_config_dir")!;
export const sourceDir = Deno.env.get("CHEZMOI_SOURCE_DIR")!;
