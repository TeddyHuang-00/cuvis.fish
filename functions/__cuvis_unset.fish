function __cuvis_unset -d "Unset CUDA device visibility"
    if set -q CUDA_VISIBLE_DEVICES
        set -e CUDA_VISIBLE_DEVICES
        echo "Reset CUDA device visibility to all devices"
    else
        echo "CUDA device visibility was not set, skipping"
    end
end
