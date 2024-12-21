FROM rust:1.74-slim-bullseye

ARG http_proxy
ARG https_proxy
ARG no_proxy

ENV http_proxy=$http_proxy
ENV https_proxy=$https_proxy
ENV no_proxy=$no_proxy

RUN mkdir -p /app
WORKDIR /app
