function __cuvis_complete_devices -d "List available CUDA devices for completion"
    set -l prefix $argv[1]
    set -l devices (__cuvis_get_available_devices 2>/dev/null)
    if test $status -ne 0
        # Gracefully return if nvidia-smi is not available
        return
    end

    if test -z "$prefix"
        # If token is empty, suggest all available devices

        for device in $devices
            echo "$device"
        end

    else if string match -q "*," "$prefix"
        # Check if token ends with comma - suggest next device

        set -l prev (__cuvis_parse_devices "$prefix" 2>/dev/null)
        if test $status -ne 0
            return
        end

        for device in $devices
            if contains $device $prev
                continue
            end
            echo "$prefix$device"
        end

    else if string match -q "*-" "$prefix"
        # Check if token ends with dash - suggest range end

        set -l before_dash (string replace -r '.*?(\d+)-' '$1' "$prefix")
        set -l start (__cuvis_parse_devices "$before_dash" 2>/dev/null)
        if test $status -ne 0
            return
        end

        set -l before_comma (string replace -r '(.*?)\d+-' '$1' "$prefix")
        set -l prev (__cuvis_parse_devices "$before_comma" 2>/dev/null)

        for device in $devices
            if test $device -le $start; or contains $device $prev
                continue
            end
            echo "$prefix$device"
        end
    end
    return
end
