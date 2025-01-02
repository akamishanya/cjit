#!/bin/bash

clang -S -emit-llvm -O1 -Xclang -disable-llvm-passes -o - $1 | grep -vE "target datalayout|target triple" | sed 's/ "target-[^"]*"="[^"]*"//g; s/ "probe-stack"="[^"]*"//g' > ${1%.c}.ll
