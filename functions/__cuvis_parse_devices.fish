function __cuvis_parse_devices -d "Parse device specification into list of device IDs"
    if test (count $argv) -ne 1
        echo "__cuvis_parse_devices: expected exactly one argument" >&2
        return 1
    end

    set -l device_spec (string trim -c , $argv[1])
    set -l result

    # Split by comma first
    set -l parts (string split "," $device_spec)

    for part in $parts
        set -l part (string trim $part)

        if string match -q "*-*" $part
            # Handle range (e.g., "2-5")
            set -l range_parts (string split "-" $part)

            if test (count $range_parts) -ne 2
                echo "__cuvis_parse_devices: invalid range format '$part'" >&2
                return 1
            end

            set -l start (string trim $range_parts[1])
            set -l end (string trim $range_parts[2])

            # Validate that start and end are numbers
            if not string match -qr '^\d+$' $start; or not string match -qr '^\d+$' $end
                echo "__cuvis_parse_devices: range values must be numbers '$part'" >&2
                return 1
            end

            set -l start_num (math $start)
            set -l end_num (math $end)

            if test $start_num -gt $end_num
                echo "__cuvis_parse_devices: invalid range '$part' (start > end)" >&2
                return 1
            end

            # Add all numbers in range
            for i in (seq $start_num $end_num)
                set -a result $i
            end
        else
            # Handle single device
            if not string match -qr '^\d+$' $part
                echo "__cuvis_parse_devices: '$part' is not a valid device number" >&2
                return 1
            end
            set -a result $part
        end
    end

    # Remove duplicates and sort
    set -l unique_result (printf '%s\n' $result | sort -nu)

    printf '%s\n' $unique_result
end
