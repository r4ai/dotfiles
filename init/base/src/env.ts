import { path } from "./dependencies.ts"

const hasChezmoiInstalled = !!Deno.env.get("CHEZMOI")
if (!hasChezmoiInstalled) {
  throw new Error("Chezmoi is not installed. Please install it first.")
}

export const homeDir = Deno.env.get("CHEZMOI_HOME_DIR")!
export const configDir = path.join(homeDir, ".config")
export const fishConfigDir = path.join(configDir, "fish")
export const sourceDir = Deno.env.get("CHEZMOI_SOURCE_DIR")!
