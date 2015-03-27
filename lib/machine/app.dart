library machine;

import 'dart:async';
import 'package:tri/trisc/core.dart';
import 'package:tri/tri/mathe.dart';
import 'package:tri/halt.dart';
import 'package:logging/logging.dart';
import 'package:logging_handlers/logging_handlers_shared.dart';
import 'dart:html';
import 'dart:convert';
import 'package:event_bus/event_bus.dart';

part 'host.dart';
part 'loader.dart';

final EventBus bus = new EventBus();

class WriteCharEvent{
  final int char;
  WriteCharEvent(this.char);
}

class WriteIntEvent{
  final int value;
  WriteIntEvent(this.value);
}

void tuneLog() {
  startQuickLogging();
  fmt.level = Level.WARNING;
}

init() async {
  Host host = new Host();
  Flasher flash = new Flasher(host.mem, mtOrg, 81);
  await flash.flash("bootstrap", adr: bootPC, list: false);
  await flash.flash("Core", boot: true);
  await flash.flash("Test2");
  host.run();
}
