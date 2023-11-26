#!/bin/bash

wallpaper_dir="/$HOME/.config/hypr/background/"

image_files=("$wallpaper_dir"/*)

shuffled_files=($(shuf -e "${image_files[@]}"))

sed -i '/^preload =/d' ~/.config/hypr/hyprpaper.conf
sed -i '/^wallpaper =/d' ~/.config/hypr/hyprpaper.conf

for image in "${shuffled_files[@]}"; do
  echo "preload = $image" >> ~/.config/hypr/hyprpaper.conf
  echo "wallpaper = [MONITOR STRING], $image" >> ~/.config/hypr/hyprpaper.conf
done

sed -i -e "/wallpaper = [MONITOR ENTRY, CHANGE HERE], ${shuffled_files[0]//\//\\/}/{n;s/^#//}" ~/.config/hypr/hyprpaper.conf

pkill hyprpaper

sleep 1

hyprpaper &
