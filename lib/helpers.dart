import 'dart:math';

Random random = new Random();

int generateId() {
  return DateTime.now().microsecondsSinceEpoch + random.nextInt(4294967296);
}
