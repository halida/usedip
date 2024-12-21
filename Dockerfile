# 使用官方 Rust 镜像作为基础镜像
FROM rust:1.74-slim-bullseye AS builder

# 设置工作目录
WORKDIR /app

# 将 Cargo.toml 和 Cargo.lock 复制到工作目录
COPY Cargo.toml Cargo.lock ./

# 下载依赖并缓存
RUN cargo generate-lockfile
RUN cargo build --release

# 复制源代码
COPY src ./src

# 构建发布版本
RUN cargo build --release

# 使用更小的镜像作为最终镜像
FROM debian:bullseye-slim

# 安装 openssl 依赖，某些 crate 可能需要
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates openssl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 从 builder 阶段复制构建好的二进制文件
COPY --from=builder /app/target/release/hello-web .

# 暴露端口
EXPOSE 8080

# 设置运行命令
CMD ["./hello-web"]
