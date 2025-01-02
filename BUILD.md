## 1. Строим LLVM из исходников

Нужны: git, gcc, g++, cmake, ninja, lld

На Ubuntu:
```sh
$ sudo apt install build-essential git cmake ninja-build lld
```

### Клонируем LLVM (версия [19.1.0](https://github.com/llvm/llvm-project/commit/a4bf6cd7cfb1a1421ba92bca9d017b49936c55e4))
```sh
$ mkdir llvm-project
$ cd llvm-project
$ git init
$ git remote add origin https://github.com/llvm/llvm-project.git
$ git fetch --depth 1 origin a4bf6cd7cfb1a1421ba92bca9d017b49936c55e4
$ git checkout FETCH_HEAD
```
Репо занимает ~2GB

### Строим LLVM
```sh
$ cmake -S llvm -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_TARGETS_TO_BUILD=X86 \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DLLVM_CCACHE_BUILD=ON \
    -DLLVM_PARALLEL_LINK_JOBS=4 \
    -DLLVM_USE_LINKER=lld \
    -DLLVM_BUILD_LLVM_DYLIB=ON \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DLLVM_ENABLE_ZSTD=OFF \
    -DLLVM_ENABLE_ZLIB=OFF
```

- Если строите не на X86, то в `-DLLVM_TARGETS_TO_BUILD=X86` вместо X86 указывайте свою архитектуру ([список таргетов](https://llvm.org/docs/CMake.html#:~:text=target%20architecture%20name.-,LLVM_TARGETS_TO_BUILD,-%3ASTRING))
- `-DLLVM_CCACHE_BUILD=ON` опционально. Ускоряет построение кэшированием компиляций. Для работы нужен `ccache`.

Затем:
```
$ cd build
$ ninja
```

- Если билд падает с Out of Memory, то перезапустите еще раз. Можно попробовать строить в один поток с этого момента: `ninja -j1`

## 2. Строим TestRunner

В корне cjit:

```sh
$ cmake -S . -B build -G Ninja \
    -DLLVM_DIR=/path/to/llvm-project/build/lib/cmake/llvm \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo
$ cd build
$ ninja
```
