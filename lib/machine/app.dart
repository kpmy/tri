library machine;

import 'dart:async';
import 'package:tri/trisc/core.dart';
import 'package:tri/tri/mathe.dart';
import 'package:logging/logging.dart';
import 'package:logging_handlers/logging_handlers_shared.dart';

part 'host.dart';

void tuneLog() {
  startQuickLogging();
  fmt.level = Level.ALL;
}

void init() {
  Host host = new Host();
}
