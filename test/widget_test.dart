import 'package:flutter_test/flutter_test.dart';

import 'package:know_me_frontend_v2/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
  });
}
