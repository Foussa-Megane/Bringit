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
import 'package:git_ihm/services/path/path_manager.dart';
import 'package:test/test.dart';

import '../mock/shared_preferences.dart';

void main() {
  late PathManager pm;

  setUp(() {
    pm = SpPathManager(MockedSharedPreferences());
  });

  test('returns empty string if not initialized', () {
    expect(pm.path, equals(''));
  });

  test('keeps the provided path', () async {
    pm.path = 'foo/bar';

    expect(pm.path, equals('foo/bar'));
  });
}
