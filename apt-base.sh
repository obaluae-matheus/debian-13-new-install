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
    libwayland-dev \
    libwlroots-dev \
    libinput-dev \
    wayland-protocols \
    libxwayland-dev \
    libxkbcommon-dev
    dbus \
    dbus-x11 \
    xdg-utils \
    xdg-user-dirs \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk
    kitty \
    chromium \
    wayfire \
    waybar \
    swaybg \
    imagemagick \
    rofi
