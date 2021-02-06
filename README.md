# libusb

Dart wrapper via `dart:ffi` for https://github.com/libusb/libusb

## Environment

- Linux(Ubuntu 18.04 LTS)

## Build

### Prepare libusb

- Linux:

```
sudo apt install libusb-1.0.0-dev
cp -r /usr/include/libusb-1.0 . && cp /lib/x86_64-linux-gnu/libusb-1.0.so.0* libusb-1.0/
```

### Prepare llvm(9+)

- Linux: `sudo apt install libclang-10-dev`

### Build libusb.dart

- Linux:

```sh
pub run ffigen:setup -I/usr/lib/llvm-10/include -L/usr/lib/llvm-10/lib/
pub run ffigen
```