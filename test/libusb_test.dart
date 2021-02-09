import 'dart:ffi';
import 'dart:io';

import 'package:libusb/libusb64.dart'; // if (Platform.isMacOS) 'package:libusb/libusb32.dart
import 'package:test/test.dart';

final DynamicLibrary Function() loadLibrary = () {
  if (Platform.isWindows) {
    return DynamicLibrary.open('${Directory.current.path}/libusb-1.0/libusb-1.0.dll');
  } if (Platform.isMacOS) {
    return DynamicLibrary.open('${Directory.current.path}/libusb-1.0/libusb-1.0.dylib');
  } else if (Platform.isLinux) {
    return DynamicLibrary.open('${Directory.current.path}/libusb-1.0/libusb-1.0.so');
  }
  return null;
};

final libusb = Libusb(loadLibrary());

void main() {
  group('inline test', () {
    Pointer<libusb_transfer> transfer;
    Pointer<libusb_device_handle> dev_handle;
    Pointer<Uint8> buffer;
    Pointer<NativeFunction<libusb_transfer_cb_fn>> callback;
    Pointer<Void> user_data;

    test('libusb_cpu_to_le16', () {
      expect(() => libusb.libusb_cpu_to_le16(0), throwsArgumentError);
    });
    test('libusb_control_transfer_get_data', () {
      expect(() => libusb.libusb_control_transfer_get_data(transfer), throwsArgumentError);
    });
    test('libusb_fill_control_transfer', () {
      expect(() => libusb.libusb_fill_control_transfer(transfer, dev_handle, buffer, callback, user_data, 0), throwsArgumentError);
    });
    test('libusb_fill_bulk_transfer', () {
      expect(() => libusb.libusb_fill_bulk_transfer(transfer, dev_handle, 0, buffer, 0, callback, user_data, 0), throwsArgumentError);
    });
    test('libusb_fill_bulk_stream_transfer', () {
      expect(() => libusb.libusb_fill_bulk_stream_transfer(transfer, dev_handle, 0, 0, buffer, 0, callback, user_data, 0), throwsArgumentError);
    });
    test('libusb_fill_iso_transfer', () {
      expect(() => libusb.libusb_fill_iso_transfer(transfer, dev_handle, 0, buffer, 0, 0, callback, user_data, 0), throwsArgumentError);
    });
    test('libusb_set_iso_packet_lengths', () {
      expect(() => libusb.libusb_set_iso_packet_lengths(transfer, 0), throwsArgumentError);
    });
    test('libusb_get_iso_packet_buffer', () {
      expect(() => libusb.libusb_get_iso_packet_buffer(transfer, 0), throwsArgumentError);
    });
    test('libusb_get_iso_packet_buffer_simple', () {
      expect(() => libusb.libusb_get_iso_packet_buffer_simple(transfer, 0), throwsArgumentError);
    });
    test('libusb_get_descriptor', () {
      expect(() => libusb.libusb_get_descriptor(dev_handle, 0, 0, buffer, 0), throwsArgumentError);
    });
    test('libusb_get_string_descriptor', () {
      expect(() => libusb.libusb_get_string_descriptor(dev_handle, 0, 0, buffer, 0), throwsArgumentError);
    });
  });
}