# phusion/baseimage (ubuntu 16.04) Dockerfile for Red Data Tools

FROM phusion/baseimage:latest

MAINTAINER Yusuke Saito

# https://packages.red-data-tools.org/ provides packages. You need to enable the package repository before you install packages.
RUN apt-get update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    && apt-get install -y \
    apt-transport-https \
    lsb-release \
    ansible \
    && cat <<APT_LINE | \
       tee /etc/apt/sources.list.d/red-data-tools.list \
       deb https://packages.red-data-tools.org/ubuntu/ $(lsb_release --codename --short) universe \
       deb-src https://packages.red-data-tools.org/ubuntu/ $(lsb_release --codename --short) universe \
       APT_LINE \
    && apt update --allow-insecure-repositories || apt update \
    && apt install -y --allow-unauthenticated red-data-tools-keyring \
    && apt update \
# Install Apache Arrow C++
    && apt install -y libarrow-dev \ 
# Install Apache Arrow GLib (C API)
    barrow-glib-dev \
# Apache Parquet C++
    libparquet-dev \
# Parquet GLib
    libparquet-glib-dev \
#For packages.red-data-tools.org administrator

#RUN  rake deploy
