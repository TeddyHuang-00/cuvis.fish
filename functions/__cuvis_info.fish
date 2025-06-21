function __cuvis_info -d "Show current CUDA device visibility"
    # Print CUDA_VISIBLE_DEVICES status
    if set -q CUDA_VISIBLE_DEVICES
        echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
    else
        echo "CUDA_VISIBLE_DEVICES: not set (all devices visible)"
    end
    echo ""

    # Get available devices and their info
    set -l available_devices (__cuvis_get_device_indices)
    if test $status -ne 0
        echo "Unable to query available devices"
        return 1
    end

    # Get visible devices list
    set -l visible_devices
    if set -q CUDA_VISIBLE_DEVICES
        set visible_devices (string split "," $CUDA_VISIBLE_DEVICES)
    else
        set visible_devices $available_devices
    end

    # Get device names
    set -l device_names (__cuvis_get_device_names)

    set -l format "%3s   %-26s  %-8s\n"
    # Print header
    set_color --bold
    printf $format ID "Device Name" Visible
    set_color normal
    echo (string repeat 4 -) (string repeat 27 -) (string repeat 9 -)

    # Print each device
    for i in (seq (count $available_devices))
        set -l device_id $available_devices[$i]
        set -l device_name $device_names[$i]

        # Determine status
        if contains $device_id $visible_devices
            set -f status_symbol (printf "%s%s%s" (set_color green) "o" (set_color normal))
        else
            set -f status_symbol (printf "%s%s%s" (set_color red) "x" (set_color normal))
        end

        printf $format $device_id $device_name $status_symbol
    end
end
