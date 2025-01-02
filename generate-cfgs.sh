#!/bin/bash

set -e

LLVM_OPT=$1
IR_FILE=$2

if [[ -z "$IR_FILE" || -z "$LLVM_OPT" ]]; then
    echo "Usage: $0 /path/to/llvm/opt ir.ll"
    exit 1
fi

DIRNAME=$(dirname -- $IR_FILE)
IR_FILE=$(basename -- $IR_FILE)

pushd "$DIRNAME" > /dev/null

LLVM_OUT=$($LLVM_OPT -passes=dot-cfg -disable-output "$IR_FILE" 2>&1)

while IFS= read -r line; do
    DOT=$(echo $line | sed -n "s/.*'\(.*\.dot\)'.*/\1/p")
    if [[ -z "$DOT" ]]; then
        echo "Couldn't parse $line"
        continue
    fi
    if [[ ! -f "$DOT" ]]; then
        echo "dot file $DOT not found"
        continue
    fi
    SVG_PATH="${DOT%.dot}.svg"
    SVG_PATH=${SVG_PATH:1}
    dot -Tsvg "$DOT" &> "$SVG_PATH"
    rm "$DOT"
    echo "$DIRNAME/$SVG_PATH"
done <<< "$LLVM_OUT"

popd > /dev/null
