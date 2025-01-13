#!/bin/bash

# Infinite loop to change wallpaper every 5 seconds
while true; do
  # Dynamically rebuild the list of wallpapers each iteration
  wallpapers=(/home/adminmyusername/Pictures/*.{jpg,jpeg,png,webp,gif,bmp,tiff,tif,heic,heif,ico,raw,pcx,tga,xcf})
  
  # Filter the list to include only files that exist
  wallpapers=($(for w in "${wallpapers[@]}"; do [ -f "$w" ] && echo "$w"; done))
  
  # Check if the wallpapers array is empty
  if [ ${#wallpapers[@]} -eq 0 ]; then
    # Log and fallback to a default wallpaper if no valid images are found
    echo "$(date) - No valid wallpapers found in /home/adminmyusername/Pictures. Falling back to default." >> ~/wallpaper_change.log
    default_wallpaper="/usr/share/backgrounds/Province_of_the_south_of_france_by_orbitelambda.jpg"  # Replace with a valid default path
    gsettings set org.gnome.desktop.background picture-uri "file://$default_wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$default_wallpaper"  # Set for dark theme
  else
    # Randomly select a wallpaper from the array
    random_index=$((RANDOM % ${#wallpapers[@]}))
    wallpaper_uri="file://${wallpapers[$random_index]}"
    
    # Log the change
    # echo "$(date) - Changing wallpaper to: $wallpaper_uri" >> ~/wallpaper_change.log
    
    # Change the wallpaper for both light and dark themes
    gsettings set org.gnome.desktop.background picture-uri "$wallpaper_uri"
    gsettings set org.gnome.desktop.background picture-uri-dark "$wallpaper_uri"
  fi

  # Wait for 60 seconds before changing again
  sleep 60
done
