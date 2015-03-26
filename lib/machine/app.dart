library machine;

import 'dart:async';
import 'package:tri/trisc/core.dart';
import 'package:tri/tri/mathe.dart';
import 'package:tri/halt.dart';
import 'package:logging/logging.dart';
import 'package:logging_handlers/logging_handlers_shared.dart';
import 'dart:html';
import 'dart:convert';

part 'host.dart';
part 'loader.dart';

void tuneLog() {
  startQuickLogging();
  fmt.level = Level.ALL;
}

init() async {
  Host host = new Host();
  Flasher flash = new Flasher(host.mem, mtOrg, 81);
  await flash.flash("bootstrap", adr: bootPC);
  host.run();
}
