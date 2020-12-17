#!/bin/bash

set -eu

encode() {
    exec qrencode -t PNG "$@" -o -
}

decode() {
    dd if=/dev/stdin of=/tmp/a.png >/dev/null 2>&1
    exec zbarimg --nodbus --quiet "$@" /tmp/a.png
}

help() {
    echo "echo -n hello | encode > hello.png"
    echo "decode < hello.png"
}

case "$1" in
    encode) shift; encode "$@";;
    decode) shift; decode "$@";;
    *)      help ;;
esac
