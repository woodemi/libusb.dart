import 'dart:ffi';
import 'package:ffi/ffi.dart' as pkg_ffi;

class Timeval extends Struct {
  @pkg_ffi.Long()
  external int tv_sec;

  @Susecond()
  external int tv_usec;
}

/// [pkg_ffi.Long] on Linux
/// [pkg_ffi.Int] on macOS
/// [pkg_ffi.Long] on Windows
@AbiSpecificIntegerMapping({
  Abi.linuxArm: Int32(),
  Abi.linuxArm64: Int64(),
  Abi.linuxIA32: Int32(),
  Abi.linuxX64: Int64(),
  Abi.macosArm64: Int32(),
  Abi.macosX64: Int32(),
  Abi.windowsArm64: Int32(),
  Abi.windowsIA32: Int32(),
  Abi.windowsX64: Int32(),
})
class Susecond extends AbiSpecificInteger {
  const Susecond();
}

/// [pkg_ffi.Long] on Linux
/// [pkg_ffi.Long] on macOS
/// [pkg_ffi.LongLong] on Windows
@AbiSpecificIntegerMapping({
  Abi.linuxArm: Int32(),
  Abi.linuxArm64: Int64(),
  Abi.linuxIA32: Int32(),
  Abi.linuxX64: Int64(),
  Abi.macosArm64: Int64(),
  Abi.macosX64: Int64(),
  Abi.windowsArm64: Int64(),
  Abi.windowsIA32: Int64(),
  Abi.windowsX64: Int64(),
})
class Ssize extends AbiSpecificInteger {
  const Ssize();
}
