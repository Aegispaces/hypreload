#!/bin/bash

# Specify the path to your wallpaper directory
wallpaper_dir="/$HOME/.config/hypr/background/"

# Get a list of all image files in the directory
image_files=("$wallpaper_dir"/*)

# Randomly shuffle the image files
shuffled_files=($(shuf -e "${image_files[@]}"))

# Remove existing entries in the configuration file
sed -i '/^preload =/d' ~/.config/hypr/hyprpaper.conf
sed -i '/^wallpaper =/d' ~/.config/hypr/hyprpaper.conf

# Add all images as preload and wallpaper entries in the configuration file
for image in "${shuffled_files[@]}"; do
  echo "preload = $image" >> ~/.config/hypr/hyprpaper.conf
  echo "wallpaper = [MONITOR STRING], $image" >> ~/.config/hypr/hyprpaper.conf
done

# Uncomment one randomly chosen wallpaper entry
sed -i -e "/wallpaper = [MONITOR ENTRY, CHANGE HERE], ${shuffled_files[0]//\//\\/}/{n;s/^#//}" ~/.config/hypr/hyprpaper.conf

# Restart Hyprpaper to apply the changes
pkill hyprpaper

# Sleep
sleep 1

hyprpaper &
