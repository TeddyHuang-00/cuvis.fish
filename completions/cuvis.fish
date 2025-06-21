# Disable file completion
complete -c cuvis -f

# Complete subcommands
complete -c cuvis -n __fish_use_subcommand -a set -d "Set visible CUDA devices"
complete -c cuvis -n __fish_use_subcommand -a info -d "Show current device visibility"
complete -c cuvis -n __fish_use_subcommand -a unset -d "Unset device visibility"

# Complete help option
complete -c cuvis -l help -s h -d "Show help"

# Complete device numbers for 'set' command
complete -c cuvis -n "__fish_seen_subcommand_from set" -r -a "(__cuvis_complete_devices (commandline -ct))"
