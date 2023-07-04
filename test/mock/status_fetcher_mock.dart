/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:git_ihm/git/base_command/status_fetcher.dart';

class StatusFetcherMock extends StatusFetcher {
  List<String> runResult = <String>[];
  String expectedPath = '';

  @override
  Future<List<String>> fetch(String path) async {
    if (expectedPath.isEmpty) {
      throw Exception('expectedPath for mocked method run is not initialized');
    }
    if (expectedPath != path) {
      throw Exception(
          'Failed to assert method "run" parameter, expected: "$expectedPath", actual: "$path"');
    }
    return runResult;
  }

  void pushUntrackedResult(String filePath) {
    runResult.add('?? $filePath');
  }

  void pushModifiedResult(String filePath) {
    runResult.add(' M $filePath');
  }

  void pushModifiedOrAddedResult(String filePath) {
    runResult.add('M  $filePath');
  }

  void pushUntrackedAndAdded(String filePath) {
    runResult.add('A  $filePath');
  }

  void willRunFor(String gitDirectory) {
    expectedPath = gitDirectory;
  }

  void pushIgnoredResult(String filePath) {
    runResult.add('!! $filePath');
  }
}
