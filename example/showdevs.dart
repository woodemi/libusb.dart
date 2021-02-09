import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart' as ffi;
import 'package:libusb/libusb_macos.dart';

final _libusb = Libusb(DynamicLibrary.open('${Directory.current.path}/libusb-1.0/libusb-1.0.dylib'));

void main() {
  var deviceNameList = QuickUsbMacos().getDeviceNameList();
  print('deviceNameList ${deviceNameList.join(', ')}');
}

class QuickUsbMacos {
  List<String> getDeviceNameList() {
    var init = _libusb.libusb_init(nullptr);
    if (init != libusb_error.LIBUSB_SUCCESS) {
      throw StateError('init error: ${_libusb.describeError(init)}');
    }

    var deviceListPtr = ffi.allocate<Pointer<Pointer<libusb_device>>>();
    try {
      var count = _libusb.libusb_get_device_list(nullptr, deviceListPtr);
      if (count < 0) {
        return [];
      }
      try {
        return _iterateDeviceName(deviceListPtr.value).toList();
      } finally {
        _libusb.libusb_free_device_list(deviceListPtr.value, 1);
      }
    } finally {
      ffi.free(deviceListPtr);
      _libusb.libusb_exit(nullptr);
    }
  }

  Iterable<String> _iterateDeviceName(
      Pointer<Pointer<libusb_device>> deviceList) sync* {
    var descPtr = ffi.allocate<libusb_device_descriptor>();
    var devHandlePtr = ffi.allocate<Pointer<libusb_device_handle>>();
    final strDescLength = 42;
    var strDescPtr = ffi.allocate<Uint8>(count: strDescLength);

    for (var i = 0; deviceList[i] != nullptr; i++) {
      yield _getDeviceName(
          deviceList[i], descPtr, devHandlePtr, strDescPtr, strDescLength);
    }

    ffi.free(descPtr);
    ffi.free(devHandlePtr);
    ffi.free(strDescPtr);
  }

  String _getDeviceName(
      Pointer<libusb_device> dev,
      Pointer<libusb_device_descriptor> descPtr,
      Pointer<Pointer<libusb_device_handle>> devHandlePtr,
      Pointer<Uint8> strDescPtr,
      int strDescLength) {
    var devDesc = _libusb.libusb_get_device_descriptor(dev, descPtr);
    if (devDesc != libusb_error.LIBUSB_SUCCESS) {
      print('devDesc error: ${_libusb.describeError(devDesc)}');
      return '';
    }
    var idVendor = descPtr.ref.idVendor.toRadixString(16).padLeft(4, '0');
    var idProduct = descPtr.ref.idProduct.toRadixString(16).padLeft(4, '0');
    var idDevice = '$idVendor:$idProduct';

    if (descPtr.ref.iProduct == 0) {
      print('$idDevice iProduct empty');
      return '';
    }

    var open = _libusb.libusb_open(dev, devHandlePtr);
    if (open != libusb_error.LIBUSB_SUCCESS) {
      print('$idDevice open error: ${_libusb.describeError(open)}');
      return '';
    }
    var devHandle = devHandlePtr.value;

    try {
      var langDesc = _libusb.libusb_get_string_descriptor(
          devHandle, 0, 0, strDescPtr, strDescLength);
      if (langDesc < 0) {
        print('$idDevice langDesc error: ${_libusb.describeError(langDesc)}');
        return '';
      }
      var langId = strDescPtr[2] << 8 | strDescPtr[3];

      var prodDesc = _libusb.libusb_get_string_descriptor(
          devHandle, descPtr.ref.iProduct, langId, strDescPtr, strDescLength);
      if (prodDesc < 0) {
        print('$idDevice prodDesc error: ${_libusb.describeError(prodDesc)}');
        return '';
      }
      return utf8.decode(strDescPtr.asTypedList(prodDesc));
    } finally {
      _libusb.libusb_close(devHandle);
    }
  }
}

const int _kMaxSmi64 = (1 << 62) - 1;
const int _kMaxSmi32 = (1 << 30) - 1;
final int _maxSize = sizeOf<IntPtr>() == 8 ? _kMaxSmi64 : _kMaxSmi32;

extension LibusbExtension on Libusb {
  String describeError(int error) {
    var array = _libusb.libusb_error_name(error);
    var nativeString = array.asTypedList(_maxSize);
    var strlen = nativeString.indexWhere((char) => char == 0);
    return utf8.decode(array.asTypedList(strlen));
  }
}
