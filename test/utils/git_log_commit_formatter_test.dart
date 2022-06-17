import 'package:test/test.dart';

import 'git_log_commit_formatter.dart';

void main() {
  late GitLogCommitFormatter formatter;

  group('it formats elements into a supported console output for "git log"',
      () {
    setUp(() {
      formatter = GitLogCommitFormatter();
    });

    test('with default values', () {
      expect(formatter.format(), <String>[r'00\0\', '', '']);
    });

    test('with author', () {
      formatter.author = 'John Doe';
      expect(formatter.format(), <String>[r'00\0\John Doe', '', '']);
    });

    test('with subject', () {
      formatter.subject = 'my new subject';
      expect(formatter.format(), <String>[r'00\0\', 'my new subject', '']);
    });

    test('with one reference', () {
      formatter.reference = 'master';
      expect(formatter.format(), <String>[r'00\0\', '', 'master']);
    });

    test('with multiple reference', () {
      formatter.reference = 'master, my-new-branch';
      expect(
          formatter.format(), <String>[r'00\0\', '', 'master, my-new-branch']);
    });

    test('complete example', () {
      formatter.hash = '1481da5';
      formatter.timeStamp = '1654609197';
      formatter.author = 'John Doe';
      formatter.subject = 'my new subject';
      formatter.reference = 'HEAD -> master, my-new-branch';
      expect(formatter.format(), <String>[
        r'1481da5\1654609197\John Doe',
        'my new subject',
        'HEAD -> master, my-new-branch'
      ]);
    });
  });
}
