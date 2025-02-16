use ../utils.nu get_os

export def open [path: string] {
    let path_type = $path | path type
    let os = get_os
    match $path_type {
        file => { open $path }
        dir => { match $os {
            windows => { ^explorer $path }
            macos => { open $path }
            linux => { open $path }
            unknown => { open $path }
        } }
        _ => {
            let span = (metadata $path).span
            error make {
                msg: "The path is not a file or directory"
                label: {
                    text: "Give a valid file or directory path"
                    start: $span.start
                    end: $span.end
                }
            }
        }
    }
}
