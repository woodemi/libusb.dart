# libusb

Dart wrapper via `dart:ffi` for https://github.com/libusb/libusb

## Environment

- Windows(10)
- macOS
- Linux(Ubuntu 18.04 LTS)

## Usage

Checkout example

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme

## Build

### Prepare llvm(9+)

- Windows: `winget install -e --id LLVM.LLVM`
- macOS: `brew install llvm`
- Linux: `sudo apt install libclang-10-dev`

### Build libusb_xxx.dart

- Windows:

```
pub run ffigen
move lib/libusb.dart lib/libusb_windows.dart
```

- macOS:

```
pub run ffigen
mv lib/libusb.dart lib/libusb_macos.dart
```

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

- Windows:

Download `xxx` version from https://github.com/libusb/libusb/releases and extract

```
copy libusb-1.0.23\MS64\dll\libusb-1.0.dll libusb-1.0\
```

- macOS:

Download `xxx` version from https://homebrew.bintray.com/bottles/libusb-1.0.23.catalina.bottle.tar.gz and extract

```
cp libusb/1.0.21/lib/libusb-1.0.dylib libusb-1.0/
```

- Linux:

Download `xxx` version from http://old.kali.org/kali/pool/main/libu/libusb-1.0/ and install

```
cp /lib/x86_64-linux-gnu/libusb-1.0.so.0.xxx libusb-1.0/libusb-1.0.so
```