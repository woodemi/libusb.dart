# libusb

Dart wrapper via `dart:ffi` for https://github.com/libusb/libusb

## Environment

- Linux(Ubuntu 18.04 LTS)

## Build

### Prepare llvm(9+)

- Linux: `sudo apt install libclang-10-dev`

### Build libusb_xxx.dart

- Linux:

```sh
pub run ffigen:setup -I/usr/lib/llvm-10/include -L/usr/lib/llvm-10/lib/
pub run ffigen
mv lib/libusb.dart lib/libusb_linux.dart
```

## Contribute

### Prepare libusb.h

Download `xxx` verion from `https://github.com/libusb/libusb/releases` and extract `libusb.h`

### Prepare libusb-1.0 dynamic library


- Linux:

Download `xxx` version from http://old.kali.org/kali/pool/main/libu/libusb-1.0/ and install

```
cp /lib/x86_64-linux-gnu/libusb-1.0.so.0.xxx libusb-1.0/libusb-1.0.so
```