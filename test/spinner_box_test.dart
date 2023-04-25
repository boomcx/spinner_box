// import 'package:flutter_test/flutter_test.dart';
// import 'package:spinner_box/spinner_box.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockSpinnerBoxPlatform
//     with MockPlatformInterfaceMixin
//     implements SpinnerBoxPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final SpinnerBoxPlatform initialPlatform = SpinnerBoxPlatform.instance;

//   test('$MethodChannelSpinnerBox is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelSpinnerBox>());
//   });

//   test('getPlatformVersion', () async {
//     SpinnerBox spinnerBoxPlugin = SpinnerBox();
//     MockSpinnerBoxPlatform fakePlatform = MockSpinnerBoxPlatform();
//     SpinnerBoxPlatform.instance = fakePlatform;

//     expect(await spinnerBoxPlugin.getPlatformVersion(), '42');
//   });
// }
