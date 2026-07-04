import 'dart:typed_data';
class MemoryGuard {
  static void clear(Uint8List? buffer) {
    if (buffer == null) return;
    for (var i = 0; i < buffer.length; i++) {
      buffer[i] = 0;
    }
  }
}
