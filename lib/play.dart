import 'dart:math';

void main() {
  final rnd = Random.secure();
  print(rnd.nextInt(255));
}

class TimeDebugger {
  static DateTime _start = DateTime.now();

  static String? lastMarker;

  static int indentLevel = 0;

  static void marker(String name) {
    final now = DateTime.now();
    final diff = now.difference(_start);

    if (lastMarker == null) {
      show('Start at $name');
    } else {
      show('$lastMarker to $name took: ${diff.inMilliseconds}ms');
    }

    lastMarker = name;
    _start = now;
  }

  static void indent(String s) {
    show('$s {');
    indentLevel++;
  }

  static void unindent() {
    indentLevel--;
    show('}');
  }

  static void show(String s) {
    print('${'  ' * indentLevel}$s');
  }
}
