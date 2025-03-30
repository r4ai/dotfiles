import { $, path } from "./dependencies.ts"
import { packages } from "./packages.ts"
import { isWsl } from "./utils.ts"
import { fishConfigDir } from "./env.ts"
import { which } from "./utils.ts"

const installBrewPackages = async () => {
  await $`brew update`
  const installedPackages = await $`brew list`.lines()
  for (const pkg of packages) {
    if (installedPackages.includes(pkg)) {
      continue
    }
    await $`brew install ${pkg}`
  }
  await $`brew cleanup`
}

const initChezmoi = async () => {
  await $`chezmoi init https://github.com/r4ai/dotfiles.git`
  await $`chezmoi apply`

  // Create `~/.config/fish/vars.fish`
  const varsFish = path.join(fishConfigDir(), "vars.fish")
  Deno.create(varsFish)

  // Set `WINDOWS_HOME` variable
  const doesWindowsHomeExist = !!Deno.env.get("WINDOWS_HOME")
  if (!doesWindowsHomeExist && isWsl()) {
    const windowsHomeDir = prompt(
      "Windows home directory:",
      "/mnt/c/Users/r4ai",
    )
    await Deno.writeTextFile(
      varsFish,
      `set -x WINDOWS_HOME ${windowsHomeDir}`,
      {
        append: true,
      },
    )
  }

  // Register fish in /etc/shells
  const currentShellsPath = "/etc/shells"
  const currentShells = (await Deno.readTextFile(currentShellsPath)).split("\n")
  const fishShell = await which("fish")
  if (!currentShells.includes(fishShell)) {
    await $.raw`echo "${fishShell}" | sudo tee -a "${currentShellsPath}"`
      .printCommand()
  }

  // Set active shell to fish
  const currentShell = Deno.env.get("SHELL")
  if (currentShell !== fishShell) {
    await $`chsh -s ${fishShell}`.printCommand()
  }
}

const initFisher = async () => {
  await $`fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"`
  await $`fish -c "fisher install r4ai/my_fish_functions"`
  await $`fish -c "fisher install decors/fish-ghq"`
}

const main = async () => {
  await installBrewPackages()
  await initChezmoi()
  await initFisher()
}
await main()
