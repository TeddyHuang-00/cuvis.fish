function cuvis -d "Manage CUDA device visibility"
    set -l options h/help
    argparse $options -- $argv
    or return 1

    if set -q _flag_help
        __cuvis_help
        return 0
    end

    if test (count $argv) -eq 0
        __cuvis_help
        return 1
    end

    set -l command $argv[1]
    set -l args $argv[2..-1]

    switch $command
        case set
            __cuvis_set $args
        case info
            __cuvis_info $args
        case unset
            __cuvis_unset $args
        case '*'
            echo "cuvis: unknown command '$command'" >&2
            echo "Try 'cuvis --help' for more information." >&2
            return 1
    end
end
