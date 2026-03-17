import 'package:flutter_test/flutter_test.dart';
import 'package:mi_intesud_social/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {

    await tester.pumpWidget(const MiIntesudApp());

    expect(find.byType(MiIntesudApp), findsOneWidget);

  });
}