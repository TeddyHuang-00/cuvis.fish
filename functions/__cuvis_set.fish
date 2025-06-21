function __cuvis_set -d "Set visible CUDA devices"
    if test (count $argv) -eq 0
        echo "cuvis set: missing device specification" >&2
        echo "Try 'cuvis --help' for usage information." >&2
        return 1
    end

    set -l device_spec $argv[1]
    set -l parsed_devices (__cuvis_parse_devices $device_spec)

    if test $status -ne 0
        return 1
    end

    set -l available_devices (__cuvis_get_available_devices)
    if test $status -ne 0
        echo "cuvis set: failed to query available devices" >&2
        return 1
    end

    # Validate that all requested devices exist
    for device in $parsed_devices
        if not contains $device $available_devices
            echo "cuvis set: device $device not available" >&2
            echo "Available devices: $available_devices" >&2
            return 1
        end
    end

    # Set the environment variable
    set -l device_list (string join "," $parsed_devices)
    set -gx CUDA_VISIBLE_DEVICES $device_list

    echo "CUDA visible devices set to: $device_list"
end
