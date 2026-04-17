import 'package:dasm_core/dasm_core.dart';
import 'package:dasm_souq_mobile/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen renders brand title', (tester) async {
    await setupDasmCore();
    await tester.pumpWidget(const DasmSouqApp());
    await tester.pump();
    expect(find.text('سوق داسم'), findsWidgets);
  });
}
