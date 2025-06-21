function __cuvis_get_device_names -d "Get names of CUDA devices"
    # Check nvidia-smi first
    if not command -q nvidia-smi
        echo "__cuvis_get_device_names: nvidia-smi command not found" >&2
        return 1
    end

    set -l names (nvidia-smi --query-gpu=name --format=csv,noheader,nounits 2>/dev/null)
    if test $status -ne 0
        echo "__cuvis_get_device_names: nvidia-smi command failed" >&2
        return 1
    end

    for name in $names
        # Truncate long names and clean up
        # set -l clean_name (string replace -r '^\s+|\s+' '' $name)
        set -l clean_name (string trim $name)
        if test (string length $clean_name) -gt 25
            set clean_name (string sub -l 22 $clean_name)"..."
        end
        set -a device_names $clean_name
    end
    printf '%s\n' $device_names
    return 0
end
