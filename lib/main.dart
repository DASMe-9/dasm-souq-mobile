import 'package:dasm_core/dasm_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDasmCore();
  runApp(const DasmSouqApp());
}
