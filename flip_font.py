#!/usr/bin/python
import yaml
import sys

font = sys.argv[1]
size = int(sys.argv[2])
offset_x = int(sys.argv[3])
offset_y = int(sys.argv[4])
path = '.config/alacritty/alacritty.yml'

with open(path, 'r') as f:
    current = yaml.full_load(f)

current['font']['normal']['family'] = font
current['font']['bold']['family'] = font
current['font']['italic']['family'] = font
current['font']['bold_italic']['family'] = font
current['font']['size'] = size
current['font']['offset']['x'] = offset_x
current['font']['offset']['y'] = offset_y

with open(path, 'w') as f:
    yaml.dump(current, f)
