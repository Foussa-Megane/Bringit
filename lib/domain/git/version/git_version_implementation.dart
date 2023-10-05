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

import 'dart:io';

import 'package:git_ihm/domain/git/base_command/command_result.dart';
import 'package:git_ihm/domain/git/base_command/shell_command.dart';
import 'package:git_ihm/domain/git/version/git_version_command.dart';
import 'package:git_ihm/domain/git/version/version_parser.dart';

class GitVersionImplementation extends GitVersionCommand {
  GitVersionImplementation();

  @override
  Future<CommandResult<String>> run() async {
    final ShellCommand command = ShellCommand('git', <String>['--version']);
    final ProcessResult processResult = await command.run();
    if (!processResult.isSuccessful) {
      return CommandResult<String>('', processResult);
    }
    final String version =
        VersionParser().parse(processResult.stdout.toString());
    return CommandResult<String>(version, processResult);
  }
}
