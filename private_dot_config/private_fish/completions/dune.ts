/**
 * @fileoverview Generate completions for `dune` from `man dune` output.
 * @example
 * ```sh
 * deno run -A ./dune.ts > dune.fish
 * ```
 */

import $ from "jsr:@david/dax@0.40.1";

const genCompletion = async (
  commandNames: string[],
  shouldCompletePath: boolean,
  description: string
) => {
  const script: (string | undefined | null | boolean)[][] = [];
  const commands = await parseCommand(commandNames, shouldCompletePath, description);

  // Generate completion for top-level commands
  const topLevelCommands = commands?.filter((cmd) => cmd.commands.length === 2);
  script.push([
    "set",
    "-l",
    "commands",
    ...topLevelCommands?.map((cmd) => cmd.commands[1]),
  ]);
  script.push([
    "complete",
    "-c",
    commandNames[0],
    "-f",
    "-d",
    `"${escape(description)}"`,
  ]);
  for (const cmd of topLevelCommands ?? []) {
    script.push([]);
    script.push([
      "complete",
      "-c",
      commandNames[0],
      "-n",
      `"not __fish_seen_subcommand_from $commands"`,
      "-x",
      "-a",
      `"${cmd.commands[1]}"`,
      "-d",
      `"${escape(cmd.description)}"`,
    ]);
    if (cmd.shouldCompletePath) {
      script.push([
        "complete",
        "-c",
        commandNames[0],
        "-n",
        `"__fish_seen_subcommand_from ${cmd.commands[1]}"`,
        "-rF",
      ]);
    }
    for (const opt of cmd.options) {
      script.push([
        "complete",
        "-c",
        commandNames[0],
        "-n",
        `"__fish_seen_subcommand_from ${cmd.commands[1]}"`,
        opt.short && `-s "${opt.short.replace(/^-/, "")}"`,
        opt.long && `-l "${opt.long.replace(/^--/, "")}"`,
        opt.description && `-d "${escape(opt.description)}"`,
        opt.type !== "BOOL" && "-rF",
      ]);
    }
  }

  // Generate completion for subcommands
  const subCommands = commands?.filter((cmd) => cmd.commands.length > 2);
  let tmp = "";
  for (const cmd of subCommands ?? []) {
    const subCommandName = cmd.commands[1];
    if (tmp !== subCommandName) {
      const subSubCommands = subCommands?.filter(
        (subCmd) => subCmd.commands[1] === cmd.commands[1]
      );
      script.push([]);
      script.push([
        "set",
        "-l",
        `${subCommandName}_commands`,
        ...subSubCommands?.map((cmd) => cmd.commands[2]),
      ]);
      if (cmd.shouldCompletePath) {
        script.push([
          "complete",
          "-c",
          commandNames[0],
          "-n",
          `"__fish_seen_subcommand_from ${cmd.commands
            .slice(1, -1)
            .join(
              " "
            )}; and __fish_seen_subcommand_from $${subCommandName}_commands"`,
          "-rF",
        ]);
      }
      tmp = subCommandName;
    }
    script.push([
      "complete",
      "-c",
      commandNames[0],
      "-n",
      `"__fish_seen_subcommand_from ${cmd.commands
        .slice(1, -1)
        .join(
          " "
        )}; and not __fish_seen_subcommand_from $${subCommandName}_commands"`,
      "-a",
      cmd.commands[cmd.commands.length - 1],
      "-d",
      `"${escape(cmd.description)}"`,
    ]);
    for (const opt of cmd.options) {
      script.push([
        "complete",
        "-c",
        commandNames[0],
        "-n",
        `"__fish_seen_subcommand_from ${cmd.commands.slice(1, -1).join(" ")}"`,
        opt.short && `-s "${opt.short.replace(/^-/, "")}"`,
        opt.long && `-l "${opt.long.replace(/^--/, "")}"`,
        opt.description && `-d "${escape(opt.description)}"`,
        opt.type !== "BOOL" && "-rF",
      ]);
    }
  }

  return script.map((line) => line.filter((arg) => arg).join(" ")).join("\n");
};

const escape = (str: string) =>
  str
    .replaceAll(/\n/g, "\\n")
    .replaceAll(/\t/g, "\\t")
    .replaceAll("$", "\\$")
    .replaceAll("`", "\\`")
    .replaceAll(/"/g, '\\"')
    .replaceAll(/'/g, "\\'");

/**
 * @example
 * const command = parseCommand(["dune", "build"], false, "Targets starting with a @ are interpreted as aliases.")
 */
const parseCommand = async (
  commandNames: string[],
  shouldCompletePath: boolean,
  description: string
) => {
  if (commandNames.length > 2) {
    return [
      {
        commands: commandNames,
        shouldCompletePath,
        description,
        options: [],
      },
    ];
  }
  const man = parseMan(await getManString(commandNames));

  type Command = {
    commands: string[];
    shouldCompletePath: boolean;
    description: string;
    options: ManOption[];
  };
  let commands: Command[] = [
    {
      commands: commandNames,
      shouldCompletePath,
      description,
      options: man.options,
    },
  ];
  for (const [commandName, commandInfo] of Object.entries(man.commands)) {
    const children = await parseCommand(
      [...commandNames, commandName],
      commandInfo.shouldCompletePath,
      commandInfo.description
    );
    commands = [...commands, ...(children ?? [])];
  }
  return commands;
};

type Man = {
  commands: Record<string, ManCommand>;
  options: ManOption[];
};

const getManString = (commands: string[]) =>
  $`man ${commands.join("-")}`.text();

const parseMan = (manString: string) => {
  const sections: Record<string, string[]> = {};
  let section: string | undefined = undefined;
  for (const line of manString.split("\n")) {
    const curSection = getSectionHeading(line);
    if (curSection && curSection !== section) {
      section = curSection;
      sections[section] = [];
      continue;
    }
    if (section) {
      sections[section].push(line);
      continue;
    }
  }

  const man: Man = {
    commands: {},
    options: [],
  };
  for (const [section, body] of Object.entries(sections)) {
    switch (section) {
      case "COMMAND ALIASES":
      case "COMMANDS":
        man.commands = {
          ...man.commands,
          ...parseCommandsSection(body),
        };
        break;
      case "COMMON OPTIONS":
      case "OPTIONS":
        man.options = [...man.options, ...parseOptionsSection(body)];
        break;
    }
  }

  return man;
};

const getSectionHeading = (line: string) => {
  const isSectionLine = line.match(/^([A-Z]+[A-Z\s]*)\s*$/);
  if (isSectionLine) return isSectionLine[1];
  return undefined;
};

type ManCommand = {
  shouldCompletePath: boolean;
  description: string;
};

const parseCommandsSection = (body: string[]) => {
  const commands: Record<string, ManCommand> = {};
  let commandName: string | undefined = undefined;
  for (const line of body) {
    commandName = line.match(/^\s{7}([\w-]+)/)?.[1] ?? commandName;
    if (!commandName) continue;
    if (!(commandName in commands)) {
      commands[commandName] = {
        shouldCompletePath: false,
        description: "",
      };
    }

    const shouldCompletePath = line.match(/^\s{7}[\w-]+.*(PATH|FILE|DIR).*$/)?.[1];
    if (shouldCompletePath) {
      commands[commandName].shouldCompletePath = true;
    }

    const description = line.match(/^\s{11}(.+)$/)?.[1];
    if (description) {
      commands[commandName].description += commands[commandName].description
        ? `\n${description}`
        : description;
    }
  }
  return commands;
};

type ManOption = {
  short?: string;
  long: string;
  type: string;
  description: string;
};

const parseOptionsSection = (body: string[]) => {
  const options: ManOption[] = [];
  const bodyStr = [...body, ""].join("\n");
  const optionMatches = bodyStr.matchAll(
    /\s{7}((?<short>\-\w),\s)?(?<long>--[\w-]+)(=(?<type>\w+))?.*\n\s{11}(?<description>[\s\S]+?)\n\n/g
  );
  for (const optionMatch of optionMatches) {
    const groups = optionMatch.groups;
    options.push({
      long: groups?.long ?? "",
      short: groups?.short ?? "",
      type: groups?.type ?? "BOOL",
      description: groups?.description.replaceAll(/^\s+(.+)$/gm, "$1") ?? "",
    });
  }
  return options;
};

if (import.meta.main) {
  const script = await genCompletion(
    ["dune"],
    false,
    "composable build system for OCaml"
  );
  console.log(script);
}
