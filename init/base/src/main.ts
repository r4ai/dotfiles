import { $, path } from "./dependencies.ts";
import { packages } from "./packages.ts";
import { isWsl, reload } from "./utils.ts";
import { fishConfigDir } from "./env.ts";

const initChezmoi = async () => {
  await $`chezmoi init https://github.com/r4ai/dotfiles.git`;
  await $`chezmoi apply`;

  // Create `~/.config/fish/vars.fish`
  const varsFish = path.join(fishConfigDir, "vars.fish");
  Deno.create(varsFish);

  // Set `WINDOWS_HOME` variable
  const doesWindowsHomeExist = !!Deno.env.get("WINDOWS_HOME");
  if (!doesWindowsHomeExist && isWsl()) {
    const windowsHomeDir = prompt(
      "Windows home directory:",
      "/mnt/c/Users/r4ai",
    );
    await Deno.writeTextFile(
      varsFish,
      `set -x WINDOWS_HOME ${windowsHomeDir}`,
      {
        append: true,
      },
    );
  }

  // Set active shell to fish
  await $`chsh -s (which fish)`;

  // Reload shell
  await reload();
};

const initFisher = async () => {
  await $`curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher`;

  await $`fisher install r4ai/my_fish_functions`;
};

const main = async () => {
  await $`brew install ${packages.join(" ")}`;
  await initChezmoi();
  await initFisher();
};
await main();
