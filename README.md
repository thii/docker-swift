docker-swift
============
A Docker container of Swift built from source from the latest commit on [official Swift's git repo](https://github.com/apple/swift).

## Quick start
### Install docker on OSX

    brew install docker docker-machine
    docker-machine create -d virtualbox dev
    docker-machine start dev
    eval "$(docker-machine env dev)"

## Usage

Pull from Docker Hub

    docker pull thii/swift

Compile and run a Swift file

    docker run thii/swift example.swift

## License
MIT
