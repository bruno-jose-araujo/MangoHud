# Use a base image with the required environment (e.g., Ubuntu, Arch, or Debian)
FROM archlinux:latest

# Install dependencies
RUN pacman -Syu --noconfirm base-devel \
    gcc \
    meson \
    ninja \
    glslang \
    mesa \
    libx11 \
    xcb-util \
    python-mako \
    dbus \
    wayland \
    cmake \
    pkgconf \
    libxkbcommon \
    git \
    libxnvctrl \
    appstream

# Set the working directory inside the container
WORKDIR /workspace

# Copy the source code of MangoHUD into the container (this assumes you're building from source)
COPY . /workspace

# Set the default command to start bash or any other command you need
CMD ["bash"]
