FROM rust:1.60

# Build time options to avoid dpkg warnings and help with reproducible builds.
ENV DEBIAN_FRONTEND=noninteractive \
    CARGO_HOME="/app/target"

# Create CARGO_HOME folder and don't download rust docs
RUN mkdir -pv "${CARGO_HOME}" \
    && rustup set profile minimal

# Install system packages
RUN apt-get update \
    && apt-get install -y \
        --no-install-recommends \
        clang-18 libclang-18-dev llvm-18-dev libopencv-dev pkg-config && \
    ln -sf /usr/lib/x86_64-linux-gnu/libclang-18.so.18 /usr/lib/llvm-18/lib/libclang.so && \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV OPENCV_PKGCONFIG_NAME=opencv
ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig

WORKDIR /app

ENTRYPOINT ["cargo", "run", "--release"]
