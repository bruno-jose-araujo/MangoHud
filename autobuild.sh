#!/bin/sh
# Automation of building, compiling, copying to host, and testing of current Mangohud source code.
# To be ran in host bash from project root, NOT by Docker container.

echo "Enter Docker container name/id:"
read container_name


if [ -d "build" ]; then
    rm -r build
fi
#echo -e "\e[►Previous build config cleaned\e[0m"

docker exec -it "$container_name" bash -c "meson build"
#echo -e "\e[32m►Build complete\e[0m"
docker exec -it "$container_name" bash -c "ninja -C build install"
#echo -e "\e[32m►Compile successfull\e[0m"

if [ -f "/usr/local/bin/mangohud" ]; then
    sudo rm /usr/local/bin/mangohud<gi
fi

if [ -f "/usr/local/bin/mangoplot" ]; then
    sudo rm /usr/local/bin/mangoplot
fi

sudo pacman -R --noconfirm goverlay mangohud
#echo -e "\e[32m►Previous MangoHUD binaries cleaned form host\e[0m"

docker cp "$container_name:/usr/local/bin/mangohud" /home/brunoaraujo/Desktop/
docker cp "$container_name:/usr/local/bin/mangoplot" /home/brunoaraujo/Desktop/

sudo mv /home/brunoaraujo/Desktop/mangohud /usr/local/bin/
sudo mv /home/brunoaraujo/Desktop/mangoplot /usr/local/bin/
#echo -e "\e[32m►MangoHUD binaries copied to host\e[0m"

sudo pacman -S --noconfirm goverlay

goverlay
#echo -e "\e[32m►Done\e[0m"