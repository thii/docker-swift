FROM ubuntu:trusty
MAINTAINER Doan Truong Thi <t@thi.im>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install \
	git \
	cmake \
	ninja-build \
	clang-3.6 \
	uuid-dev \
	libicu-dev \
	icu-devtools \
	libbsd-dev \
	libedit-dev \
	libxml2-dev \
	libsqlite3-dev \
	swig \
	libpython-dev \
	libncurses5-dev \
	pkg-config

# Create a symlink for clang-3.6 (requires on Ubuntu 14.04 LTS as its default clang version is 3.4)
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100

RUN rm -rf /var/lib/apt/lists/*

ENV SWIFT_VERSION 2.2
ENV SWIFT_COMMIT 5a57e5708c39c119829c98efd3bbcf317d1e0428
ENV SWIFT_PLATFORM ubuntu14.04
ENV SWIFT_SOURCE_ROOT /usr/src/swift
ENV SWIFT_BUILD_ROOT /usr/bin/swift

# Clone Swift source
RUN mkdir -p $SWIFT_SOURCE_ROOT
RUN git clone --depth=1 https://github.com/apple/swift.git $SWIFT_SOURCE_ROOT/swift
RUN git clone --depth=1 https://github.com/apple/swift-llvm.git $SWIFT_SOURCE_ROOT/llvm
RUN git clone --depth=1 https://github.com/apple/swift-clang.git $SWIFT_SOURCE_ROOT/clang
RUN git clone --depth=1 https://github.com/apple/swift-lldb.git $SWIFT_SOURCE_ROOT/lldb
RUN git clone --depth=1 https://github.com/apple/swift-cmark.git $SWIFT_SOURCE_ROOT/cmark
RUN git clone --depth=1 https://github.com/apple/swift-llbuild.git $SWIFT_SOURCE_ROOT/llbuild
RUN git clone --depth=1 https://github.com/apple/swift-package-manager.git $SWIFT_SOURCE_ROOT/swiftpm
RUN git clone --depth=1 https://github.com/apple/swift-corelibs-xctest.git $SWIFT_SOURCE_ROOT/swift-corelibs-xctest
RUN git clone --depth=1 https://github.com/apple/swift-corelibs-foundation.git $SWIFT_SOURCE_ROOT/swift-corelibs-foundation

# Build Swift
RUN $SWIFT_SOURCE_ROOT/swift/utils/build-script \
	--preset=buildbot_linux_1404 \
	installable_package=/tmp/swift.tar.gz \
	install_destdir=/root/swift-$SWIFT_VERSION-$SWIFT_COMMIT-$SWIFT_PLATFORM.tar.gz
