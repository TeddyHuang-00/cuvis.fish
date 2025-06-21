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

    set -l cmd $argv[1]
    set -e argv[1]

    switch $cmd
        case set
            __cuvis_set $argv
        case info
            __cuvis_info $argv
        case unset
            __cuvis_unset $argv
        case '*'
            echo "cuvis: unknown command '$cmd'" >&2
            echo "Try 'cuvis --help' for more information." >&2
            return 1
    end
end
