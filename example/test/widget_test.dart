import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('renders spinner demo home page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('筛选弹框'), findsOneWidget);
    expect(find.text('使用'), findsOneWidget);
    expect(find.text('构建'), findsOneWidget);
    expect(find.text('自定义主题'), findsOneWidget);

    expect(find.text('单选条件'), findsOneWidget);
    expect(find.text('多选条件'), findsOneWidget);
  });
}
