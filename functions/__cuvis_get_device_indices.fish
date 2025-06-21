function __cuvis_get_device_indices -d "Get list of available CUDA devices"
    # Check nvidia-smi first
    if not command -q nvidia-smi
        echo "__cuvis_get_device_indices: nvidia-smi command not found" >&2
        return 1
    end

    set -l devices (nvidia-smi --query-gpu=index --format=csv,noheader,nounits 2>/dev/null)
    if test $status -eq 0
        printf '%s\n' $devices
        return 0
    else
        echo "__cuvis_get_device_indices: nvidia-smi command failed" >&2
        return 1
    end
end
