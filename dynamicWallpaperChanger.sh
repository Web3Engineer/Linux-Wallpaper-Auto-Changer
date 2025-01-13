#!/bin/bash
# Array of wallpaper files with correct file URIs
wallpapers=(/home/adminmyusername/Pictures/*.jpg /home/adminmyusername/Pictures/*.png /home/adminmyusername/Pictures/*.jpeg)

# Initialize index
index=0

# Infinite loop to change wallpaper every 5 seconds
while true; do
  # Use file:// prefix to properly format URI for gsettings
  wallpaper_uri="file://${wallpapers[$index]}"
  
  # Log the change
  echo "$(date) - Changing wallpaper to: $wallpaper_uri" >> ~/wallpaper_change.log
  
  # Change the wallpaper for both light and dark themes
  gsettings set org.gnome.desktop.background picture-uri "$wallpaper_uri"
  gsettings set org.gnome.desktop.background picture-uri-dark "$wallpaper_uri"  # Set for dark theme
  
  # Update the index to cycle through the wallpapers
  ((index=(index+1)%${#wallpapers[@]}))
  
  # Wait for 30 seconds before changing again
  sleep 30
done
