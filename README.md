# cuvis

A Fish shell plugin for managing CUDA device visibility, providing a lightweight interface to control which GPUs are visible to CUDA applications.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install TeddyHuang-00/cuvis.fish
```

## Usage

```fish
# Set visible devices using various formats
cuvis set 0                   # Use only device 0
cuvis set 1,2,3               # Use devices 1, 2, and 3
cuvis set 2-5                 # Use devices 2 through 5
cuvis set 1,3-5               # Use device 1 and devices 3 through 5

# Show current device visibility status
cuvis info

# Remove device visibility restrictions
cuvis unset

# Show help
cuvis --help
```

## Requirements

- Fish shell 3.0+
- NVIDIA GPU with CUDA support
- One of the following for device detection:
  - `nvidia-smi` (recommended)
  - Python 3 with `pynvml` package
  - CUDA toolkit installation

## Features

- **Flexible device specification**: Supports single devices, comma-separated lists, ranges, and combinations
- **Smart tab completion**: Context-aware completions that understand comma and dash separators
- **Device validation**: Ensures specified devices actually exist before setting
- **Multiple detection methods**: Automatically detects available devices using the best available method
- **Lightweight**: Focused solely on managing `CUDA_VISIBLE_DEVICES` environment variable

## Examples

```fish
# Check what devices are available
cuvis info

# Use only the first GPU
cuvis set 0

# Use GPUs 1 and 3
cuvis set 1,3

# Use GPUs 2 through 4
cuvis set 2-4

# Complex specification: GPU 0 and GPUs 2-4
cuvis set 0,2-4

# Check current status
cuvis info

# Remove visibility restrictions to show all devices
cuvis unset
```

## Tab Completion

The plugin provides intelligent tab completion for device specifications:

- `cuvis set <TAB>` - Shows available devices
- `cuvis set 1,<TAB>` - Shows next available devices
- `cuvis set 1-<TAB>` - Shows valid range endings
- `cuvis set 1,2-<TAB>` - Shows completions for complex expressions
