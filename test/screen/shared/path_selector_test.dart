import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:git_ihm/screen/shared/path_selector.dart';

import '../../git_dependent_loader.dart';
import '../../mock/git_proxy_mock.dart';

late GitProxyMock _gitProxy;

void main() {
  setUp(() {
    _gitProxy = GitProxyMock();
  });

  testWidgets('PathSelector contains an IconButton',
      (WidgetTester tester) async {
    await buildPathSelector(tester);

    expect(getIconButtonWithinApp(), findsOneWidget);
  });

  testWidgets('displays an icon', (WidgetTester tester) async {
    await buildPathSelector(tester);

    expect(getIconWithinIconButtonFinder(), findsOneWidget);
  });

  testWidgets('Icon is a folder', (WidgetTester tester) async {
    await buildPathSelector(tester);

    expect(getPathSelectorIcon(), equals(Icons.folder));
  });

  testWidgets('shows a modal when tapped', (WidgetTester tester) async {
    await buildSelectorAndTap(tester);

    expect(findAlertModal(), findsOneWidget,
        reason: 'Modal with title not found');
    expect(findModalTextField(), findsOneWidget,
        reason: 'No text field in modal');
    expect(getTextFieldValue(), equals(_gitProxy.path));
  });

  testWidgets('Cancel removes modal', (WidgetTester tester) async {
    await buildSelectorAndTap(tester);
    await tapButton(tester, 'Cancel');

    expect(findAlertModal(), findsNothing);
  });

  testWidgets('Cancel does not update path', (WidgetTester tester) async {
    final String originalPath = _gitProxy.path;
    await buildSelectorAndTap(tester);
    await tester.enterText(findModalTextField(), 'anyValue');
    await tapButton(tester, 'Cancel');
    await tapFolderIcon(tester);

    expect(getTextFieldValue(), equals(originalPath));
  });

  testWidgets('Validating modal update stored path',
      (WidgetTester tester) async {
    const String newPath = '/foo/bar';
    await savePathInModal(tester, newPath);
    await tapFolderIcon(tester);

    expect(getTextFieldValue(), equals(newPath));
  });

  testWidgets('Display non git directory error', (WidgetTester tester) async {
    _gitProxy.willFindGitDir = false;
    await savePathInModal(tester, 'an/invalid/path');

    final TextField textField =
        findModalTextField().evaluate().first.widget as TextField;
    expect(textField.decoration?.errorText, equals('not a git directory'));
  });
}

Future<void> savePathInModal(WidgetTester tester, String newPath) async {
  await buildSelectorAndTap(tester);
  await tester.enterText(findModalTextField(), newPath);
  await tapButton(tester, 'Save');
}

Future<void> buildPathSelector(WidgetTester tester) async {
  await tester.pumpWidget(createWidgetForTesting(_gitProxy));
}

Widget createWidgetForTesting(GitProxy gitProxy) {
  final GitDependentLoader loader = GitDependentLoader();
  loader.gitProxy = gitProxy;
  return loader.loadAppWithWidget(const PathSelector());
}

Finder getIconButtonWithinApp() {
  return find.descendant(
      of: find.byType(Material), matching: find.byType(IconButton));
}

Finder getIconWithinIconButtonFinder() {
  return find.descendant(
    of: getIconButtonWithinApp(),
    matching: find.byType(Icon),
  );
}

IconData? getPathSelectorIcon() {
  final Icon iconObject =
      getIconWithinIconButtonFinder().evaluate().single.widget as Icon;

  return iconObject.icon;
}

Future<void> buildSelectorAndTap(WidgetTester tester) async {
  await buildPathSelector(tester);
  await tapFolderIcon(tester);
}

Future<void> tapFolderIcon(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.folder));
  await tester.pumpAndSettle();
}

Finder findAlertModal() {
  final Finder alertDialog =
      find.widgetWithText(AlertDialog, 'Set project path');
  return alertDialog;
}

Finder findModalTextField() {
  final Finder textField =
      find.descendant(of: findAlertModal(), matching: find.byType(TextField));
  return textField;
}

Future<void> tapButton(WidgetTester tester, String name) async {
  await tester.tap(find.widgetWithText(TextButton, name));
  await tester.pumpAndSettle();
}

String? getTextFieldValue() {
  final TextField field =
      findModalTextField().evaluate().single.widget as TextField;

  return field.controller?.text;
}
