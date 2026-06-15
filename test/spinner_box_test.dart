import 'package:flutter_test/flutter_test.dart';

import 'package:spinner_box/spinner_box.dart';

void main() {
  test('exports public spinner APIs', () {
    expect(SpinnerHeaderData('筛选').title, '筛选');
    expect(MoreContentType.wrap, isA<MoreContentType>());
  });
}
