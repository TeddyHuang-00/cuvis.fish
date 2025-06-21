function __cuvis_info -d "Show current CUDA device visibility"
    if set -q CUDA_VISIBLE_DEVICES
        echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"

        # Show which devices are currently visible
        set -l visible_devices (string split "," $CUDA_VISIBLE_DEVICES)
        echo "Visible devices: $visible_devices"
    else
        echo "CUDA_VISIBLE_DEVICES: not set (all devices visible)"
    end

    # Show available devices
    set -l available_devices (__cuvis_get_available_devices)
    if test $status -eq 0
        echo "Available devices: $available_devices"
    else
        echo "Available devices: unable to query"
    end
end
