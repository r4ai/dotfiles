# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_wasm_tools_global_optspecs
	string join \n h/help V/version
end

function __fish_wasm_tools_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_wasm_tools_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_wasm_tools_using_subcommand
	set -l cmd (__fish_wasm_tools_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -s h -l help -d 'Print help'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -s V -l version -d 'Print version'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "parse" -d 'Parse the WebAssembly text format'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "validate" -d 'Validate a WebAssembly binary'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "print" -d 'Print the textual form of a WebAssembly binary'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "smith" -d 'A WebAssembly test case generator'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "shrink" -d 'Shrink a Wasm file while maintaining a property of interest (such as triggering a compiler bug)'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "mutate" -d 'A WebAssembly test case mutator'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "dump" -d 'Debugging utility to dump information about a wasm binary'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "objdump" -d 'Dumps information about sections in a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "strip" -d 'Removes custom sections from an input WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "compose" -d 'WebAssembly component composer'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "demangle" -d 'Demangle Rust and C++ symbol names in the `name` section'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "component" -d 'WebAssembly wit-based component tooling'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "metadata" -d 'Manipulate metadata (module name, producers) to a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "wit-smith" -d 'A WIT test case generator'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "addr2line" -d 'Translate a WebAssembly address to a filename and line number using DWARF debugging information'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "completion" -d 'Generate shell completion scripts for this CLI'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "json-from-wast" -d 'Convert a `*.wast` WebAssembly spec test into a `*.json` file and `*.wasm` files'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "wast" -d 'A subcommand to test `*.wast` files short of executing WebAssembly code'
complete -c wasm-tools -n "__fish_wasm_tools_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand parse" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -s f -l features -d 'Comma-separated list of WebAssembly features to enable during validation' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand validate" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -l indent-text -d 'The string to use when indenting' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -l indent -d 'Number of spaces used for indentation, has lower priority than `--indent-text`' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -s p -l print-offsets -d 'Whether or not to print binary offsets intermingled in the text format as comments for debugging'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -l skeleton -d 'Indicates that the "skeleton" of a module should be printed'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -l name-unnamed -d 'Ensure all wasm items have `$`-based names, even if they don\'t have an entry in the `name` section'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -s f -l fold-instructions -d 'Print instructions in the folded format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand print" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -s f -l fuel -d 'The default amount of fuel used with `--ensure-termination`' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -s c -l config -d 'JSON configuration file with settings to control the wasm output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l available-imports -d 'The imports that may be used when generating the module' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l exports -d 'If provided, the generated module will have exports with exactly the same names and types as those in the provided WebAssembly module. The implementation (e.g. function bodies, global initializers) of each export in the generated module will be random and unrelated to the implementation in the provided module' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l allow-start-export -d 'Determines whether a `start` export may be included. Defaults to `true`' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l allowed-instructions -d 'The kinds of instructions allowed in the generated wasm programs. Defaults to all' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l allow-floats -d 'Determines whether we generate floating point instructions and types' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l bulk-memory-enabled -d 'Determines whether the bulk memory proposal is enabled for generating instructions' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l canonicalize-nans -d 'Returns whether NaN values are canonicalized after all f32/f64 operation. Defaults to false' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l disallow-traps -d 'Returns whether we should avoid generating code that will possibly trap' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l exceptions-enabled -d 'Determines whether the exception-handling proposal is enabled for generating instructions' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l export-everything -d 'Export all WebAssembly objects in the module. Defaults to false' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l gc-enabled -d 'Determines whether the GC proposal is enabled when generating a Wasm module' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l custom-page-sizes-enabled -d 'Determines whether the custom-page-sizes proposal is enabled when generating a Wasm module' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l generate-custom-sections -d 'Returns whether we should generate custom sections or not. Defaults to false' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-aliases -d 'Returns the maximal size of the `alias` section. Defaults to 1000' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-components -d 'The maximum number of components to use. Defaults to 10' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-data-segments -d 'The maximum number of data segments to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-element-segments -d 'The maximum number of element segments to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-elements -d 'The maximum number of elements within a segment to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-exports -d 'The maximum number of exports to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-funcs -d 'The maximum number of functions to generate. Defaults to 100.  This includes imported functions' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-globals -d 'The maximum number of globals to generate. Defaults to 100.  This includes imported globals' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-imports -d 'The maximum number of imports to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-instances -d 'The maximum number of instances to use. Defaults to 10' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-instructions -d 'The maximum number of instructions to generate in a function body. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-memories -d 'The maximum number of memories to use. Defaults to 1' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-memory32-bytes -d 'The maximum, in bytes, of any 32-bit memory\'s initial or maximum size' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-memory64-bytes -d 'The maximum, in bytes, of any 64-bit memory\'s initial or maximum size' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-modules -d 'The maximum number of modules to use. Defaults to 10' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-nesting-depth -d 'Returns the maximal nesting depth of modules with the component model proposal. Defaults to 10' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-table-elements -d 'The maximum, elements, of any table\'s initial or maximum size. Defaults to 1 million' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-tables -d 'The maximum number of tables to use. Defaults to 1' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-tags -d 'The maximum number of tags to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-type-size -d 'Returns the maximal effective size of any type generated by wasm-smith' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-types -d 'The maximum number of types to generate. Defaults to 100' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l max-values -d 'The maximum number of values to use. Defaults to 10' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l memory64-enabled -d 'Returns whether 64-bit memories are allowed. Defaults to true' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l memory-max-size-required -d 'Whether every Wasm memory must have a maximum size specified. Defaults to `false`' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l memory-offset-choices -d 'Control the probability of generating memory offsets that are in bounds vs. potentially out of bounds' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-data-segments -d 'The minimum number of data segments to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-element-segments -d 'The minimum number of element segments to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-elements -d 'The minimum number of elements within a segment to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-exports -d 'The minimum number of exports to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-funcs -d 'The minimum number of functions to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-globals -d 'The minimum number of globals to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-imports -d 'The minimum number of imports to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-memories -d 'The minimum number of memories to use. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-tables -d 'The minimum number of tables to use. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-tags -d 'The minimum number of tags to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-types -d 'The minimum number of types to generate. Defaults to 0' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l min-uleb-size -d 'The minimum size, in bytes, of all leb-encoded integers. Defaults to 1' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l multi-value-enabled -d 'Determines whether the multi-value results are enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l reference-types-enabled -d 'Determines whether the reference types proposal is enabled for generating instructions' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l relaxed-simd-enabled -d 'Determines whether the Relaxed SIMD proposal is enabled for generating instructions' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l saturating-float-to-int-enabled -d 'Determines whether the non-trapping float-to-int conversions proposal is enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l sign-extension-ops-enabled -d 'Determines whether the sign-extension-ops proposal is enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l shared-everything-threads-enabled -d 'Determines whether the shared-everything-threads proposal is enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l simd-enabled -d 'Determines whether the SIMD proposal is enabled for generating instructions' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l tail-call-enabled -d 'Determines whether the tail calls proposal is enabled for generating instructions' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l table-max-size-required -d 'Whether every Wasm table must have a maximum size specified. Defaults to `false`' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l threads-enabled -d 'Determines whether the threads proposal is enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l allow-invalid-funcs -d 'Indicates whether wasm-smith is allowed to generate invalid function bodies' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l wide-arithmetic-enabled -d 'Determines whether the [wide-arithmetic proposal] is enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l extended-const-enabled -d 'Determines whether the [extended-const proposal] is enabled' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -l ensure-termination -d 'Ensure that execution of generated Wasm modules will always terminate'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand smith" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -s a -l attempts -d 'The number of shrink attempts to try before considering a Wasm module as small as it will ever get' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -s s -l seed -d 'The RNG seed for choosing which size-reducing mutation to attempt next' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -l allow-empty -d 'Allow shrinking the input down to an empty Wasm module'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand shrink" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s s -l seed -d 'The RNG seed used to choose which transformation to apply. Given the same input Wasm and same seed, `wasm-mutate` will always generate the same output Wasm' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s f -l fuel -d 'Fuel to control the time of the mutation' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -l preserve-semantics -d 'Only perform semantics-preserving transformations on the Wasm module'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -l reduce -d 'Only perform size-reducing transformations on the Wasm module. This allows `wasm-mutate` to be used as a test case reducer'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand mutate" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand dump" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand dump" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand dump" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand dump" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand dump" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand dump" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand objdump" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand objdump" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand objdump" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand objdump" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand objdump" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand objdump" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s d -l delete -d 'Remove custom sections matching the specified regex' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s a -l all -d 'Remove all custom sections, regardless of name'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand strip" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s c -l config -d 'The path to the configuration file to use' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s d -l definitions -d 'Definition components whose exports define import dependencies to fulfill from' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s p -l search-path -d 'A path to search for imports' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -l skip-validation -d 'Skip validation of the composed output component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -l no-imports -d 'Do not allow instance imports in the composed output component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand compose" -s V -l version -d 'Print version'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand demangle" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -s h -l help -d 'Print help'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "new" -d 'WebAssembly component encoder from an input core wasm binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "wit" -d 'Tool for working with the WIT text format for components'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "embed" -d 'Embeds metadata for a component inside of a core wasm module'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "targets" -d 'Tool for verifying whether a component conforms to a world'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "link" -d 'Link one or more dynamic library modules, producing a component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "semver-check" -d 'Tool for verifying whether one world is a semver compatible evolution of another'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "unbundle" -d 'Unbundled core wasm modules from a component, switching them from being embedded to being imported'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and not __fish_seen_subcommand_from new wit embed targets link semver-check unbundle help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l adapt -d 'The path to an adapter module to satisfy imports not otherwise bound to WIT interfaces' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l import-name -d 'Rename an instance import in the output component' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l merge-imports-based-on-semver -d 'Indicates whether imports into the final component are merged based on semver ranges' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l skip-validation -d 'Skip validation of the output component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -s t -l wat -d 'Print the output in the WebAssembly text format instead of binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l realloc-via-memory-grow -d 'Use memory.grow to realloc memory and stack allocation'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -l reject-legacy-names -d 'Reject usage of the "legacy" naming scheme of `wit-component` and require the new naming scheme to be used'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l out-dir -d 'Emit the entire WIT resolution graph instead of just the "top level" package to the output directory specified' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l importize-out-world-name -d 'The name of the world to generate when using `--importize` or `importize-world`' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l importize-world -d 'Generates a WIT world to import a component which corresponds to the selected world' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l merge-world-imports-based-on-semver -d 'Updates the world specified to deduplicate all of its imports based on semver versions' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l features -d 'Features to enable when parsing the `wit` option' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -s w -l wasm -d 'Emit a WebAssembly binary representation instead of the WIT text format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -s t -l wat -d 'Emit a WebAssembly textual representation instead of the WIT text format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l no-docs -d 'Do not include doc comments when emitting WIT text'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l skip-validation -d 'Skips the validation performed when using the `--wasm` and `--wat` options'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -s j -l json -d 'Emit the WIT document as JSON instead of text'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l importize -d 'Generates WIT to import the component specified to this command'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -l all-features -d 'Enable all features when parsing the `wit` option'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from wit" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l features -d 'Features to enable when parsing the `wit` option' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l encoding -d 'The expected string encoding format for the component' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -s w -l world -d 'The world that the component uses' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l dummy-names -d 'Same as `--dummy`, but the style of core wasm names is specified' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l all-features -d 'Enable all features when parsing the `wit` option'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l dummy -d 'Don\'t read a core wasm module as input, instead generating a "dummy" module as a placeholder'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l async-callback -d 'With `--dummy-names legacy`, this will generate a core module such that all the imports are lowered using the async ABI and the exports are lifted using the async-with-callback ABI'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l async-stackful -d 'With `--dummy-names legacy`, this will generate a core module such that all the imports are lowered using the async ABI and the exports are lifted using the async-without-callback (i.e. stackful) ABI'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -s t -l wat -d 'Print the output in the WebAssembly text format instead of binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -l only-custom -d 'Print the wasm custom section only'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from embed" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -l features -d 'Features to enable when parsing the `wit` option' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -s w -l world -d 'The world used to test whether a component conforms to its signature. If the `WIT` source provided contains multiple packages, this option must be set, and must be of the fully-qualified form (ex: "wasi:http/proxy")' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -l all-features -d 'Enable all features when parsing the `wit` option'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from targets" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l dl-openable -d 'Input library to link and make available for dynamic resolution via `dlopen` (may be repeated)' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l adapt -d 'The path to an adapter module to satisfy imports not otherwise bound to WIT interfaces' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l stack-size -d 'Size of stack (in bytes) to allocate in the synthesized main module' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l merge-imports-based-on-semver -d 'Indicates whether imports into the final component are merged based on semver ranges' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l skip-validation -d 'Skip validation of the output component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -s t -l wat -d 'Print the output in the WebAssembly text format instead of binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l stub-missing-functions -d 'Generate trapping stubs for any missing functions'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -l use-built-in-libdl -d 'Use built-in implementations of `dlopen`/`dlsym`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from link" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -l features -d 'Features to enable when parsing the `wit` option' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -l prev -d 'The "previous" world, or older version, of what\'s being tested' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -l new -d 'The "new" world which is the "prev" world but modified' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -l all-features -d 'Enable all features when parsing the `wit` option'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from semver-check" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -l module-dir -d 'Where to place unbundled core wasm modules' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -l threshold -d 'The size threshold for core wasm modules to unbundled' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from unbundle" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "new" -d 'WebAssembly component encoder from an input core wasm binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "wit" -d 'Tool for working with the WIT text format for components'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "embed" -d 'Embeds metadata for a component inside of a core wasm module'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "targets" -d 'Tool for verifying whether a component conforms to a world'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "link" -d 'Link one or more dynamic library modules, producing a component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "semver-check" -d 'Tool for verifying whether one world is a semver compatible evolution of another'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "unbundle" -d 'Unbundled core wasm modules from a component, switching them from being embedded to being imported'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand component; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and not __fish_seen_subcommand_from show add help" -s h -l help -d 'Print help'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and not __fish_seen_subcommand_from show add help" -f -a "show" -d 'Read metadata (module name, producers) from a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and not __fish_seen_subcommand_from show add help" -f -a "add" -d 'Add metadata (module name, producers) to a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and not __fish_seen_subcommand_from show add help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -l json -d 'Output in JSON encoding'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l name -d 'Add a module or component name to the names section' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l language -d 'Add a programming language to the producers section' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l processed-by -d 'Add a tool and its version to the producers section' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l sdk -d 'Add an SDK and its version to the producers section' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l authors -d 'Contact details of the people or organization responsible, encoded as a freeform string' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l description -d 'A human-readable description of the binary' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l licenses -d 'License(s) under which contained software is distributed as an SPDX License Expression' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l source -d 'URL to get source code for building the image' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l homepage -d 'URL to find more information on the binary' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l revision -d 'Source control revision identifier for the packaged software' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l version -d 'Version of the packaged software' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-name -d 'Remove a module or component name from the names section'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-authors -d 'Remove authors from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-description -d 'Remove description from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-licenses -d 'Remove licenses from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-source -d 'Remove source from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-homepage -d 'Remove homepage from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-revision -d 'Remove revision from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -l clear-version -d 'Remove version from the metadata'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from help" -f -a "show" -d 'Read metadata (module name, producers) from a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add metadata (module name, producers) to a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand metadata; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-packages -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-type-size -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-interface-items -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-world-items -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-pkg-items -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-type-parts -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-files-per-package -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l max-resource-items -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -s t -l wat -d 'Output the text format of WebAssembly instead of the binary format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -l arbitrary-config -d 'Indicates that "arbitrary configuration" should be used meaning that the input seed is first used to generate the configuration and then afterwards the rest of the seed is used to generate the document'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wit-smith" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -l generate-dwarf -d 'Optionally generate DWARF debugging information from WebAssembly text files' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -s g -d 'Shorthand for `--generate-dwarf full`'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -l code-section-relative -d 'Indicates that addresses are code-section-relative instead of offsets from the beginning of the module'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand addr2line" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand completion" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand completion" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand completion" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -s o -l output -d 'Where to place output' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -l wasm-dir -d 'Where to place binary and text WebAssembly files referenced by tests' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -l allow-confusing-unicode -d 'Controls the "allow confusing unicode" option which will reject parsing files that have unusual characters' -r -f -a "true\t''
false\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -l pretty -d 'Output pretty-printed JSON instead of compact json'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand json-from-wast" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -l color -d 'Configuration over whether terminal colors are used in output' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -s f -l features -d 'Comma-separated list of WebAssembly features to enable during validation' -r
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -s a -l assert -d 'Perform extra internal assertions in `wasm-tools` itself over the provided test' -r -f -a "default\t''
pretty-whitespace\t''
snapshot-print\t''
snapshot-json\t''
snapshot-folded\t''
test-folded\t''
no-test-folded\t''
permissive\t''"
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -l snapshot -d 'Directory to place snapshots in with `--assert snapshot-*` flags' -r -F
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -s v -l verbose -d 'Use verbose output (-v info, -vv debug, -vvv trace)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -l ignore-error-messages -d 'Whether to ignore the error message expectation in `(assert_invalid ..)` directives'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -l allow-confusing-unicode -d 'Whether or not "confusing unicode characters" are allowed to be present in `*.wast` files'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand wast" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "parse" -d 'Parse the WebAssembly text format'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "validate" -d 'Validate a WebAssembly binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "print" -d 'Print the textual form of a WebAssembly binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "smith" -d 'A WebAssembly test case generator'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "shrink" -d 'Shrink a Wasm file while maintaining a property of interest (such as triggering a compiler bug)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "mutate" -d 'A WebAssembly test case mutator'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "dump" -d 'Debugging utility to dump information about a wasm binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "objdump" -d 'Dumps information about sections in a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "strip" -d 'Removes custom sections from an input WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "compose" -d 'WebAssembly component composer'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "demangle" -d 'Demangle Rust and C++ symbol names in the `name` section'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "component" -d 'WebAssembly wit-based component tooling'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "metadata" -d 'Manipulate metadata (module name, producers) to a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "wit-smith" -d 'A WIT test case generator'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "addr2line" -d 'Translate a WebAssembly address to a filename and line number using DWARF debugging information'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "completion" -d 'Generate shell completion scripts for this CLI'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "json-from-wast" -d 'Convert a `*.wast` WebAssembly spec test into a `*.json` file and `*.wasm` files'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "wast" -d 'A subcommand to test `*.wast` files short of executing WebAssembly code'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and not __fish_seen_subcommand_from parse validate print smith shrink mutate dump objdump strip compose demangle component metadata wit-smith addr2line completion json-from-wast wast help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "new" -d 'WebAssembly component encoder from an input core wasm binary'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "wit" -d 'Tool for working with the WIT text format for components'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "embed" -d 'Embeds metadata for a component inside of a core wasm module'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "targets" -d 'Tool for verifying whether a component conforms to a world'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "link" -d 'Link one or more dynamic library modules, producing a component'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "semver-check" -d 'Tool for verifying whether one world is a semver compatible evolution of another'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from component" -f -a "unbundle" -d 'Unbundled core wasm modules from a component, switching them from being embedded to being imported'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from metadata" -f -a "show" -d 'Read metadata (module name, producers) from a WebAssembly file'
complete -c wasm-tools -n "__fish_wasm_tools_using_subcommand help; and __fish_seen_subcommand_from metadata" -f -a "add" -d 'Add metadata (module name, producers) to a WebAssembly file'
