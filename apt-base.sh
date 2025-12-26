#!/bin/bash

# Update
apt update
apt upgrade -y

# Install
apt install -y \
    htop \
    libgl1-mesa-dri \
    mesa-vulkan-drivers \
    cmake \
    cargo \
    git \
    build-essential \
    libfontconfig-dev \
    libxcb1-dev \
    libfreetype-dev \
    libwlroots-0.18-dev \
    libinput-dev \
    wayland-protocols \
    libwayland-dev \
    libxkbcommon-dev \
    xwayland \
    dbus \
    dbus-x11 \
    xdg-utils \
    xdg-user-dirs \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk \
    kitty \
    chromium \
    wayfire \
    waybar \
    swaybg \
    imagemagick \
    rofi \
    fonts-font-awesome \
    fonts-fork-awesome \
    fonts-noto-color-emoji \
    fonts-hack-ttf \
    fonts-jetbrains-mono \
    zip \
    gedit
    
 # Cache
 fc-cache -fv
