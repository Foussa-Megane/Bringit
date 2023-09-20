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

import 'package:git_ihm/data/git/git_init_command.dart';
import 'package:git_ihm/domain/git/commit/commit_parser.dart';
import 'package:git_ihm/domain/git/log/git_log_command.dart';
import 'package:git_ihm/domain/git/log/git_log_implementation.dart';
import 'package:git_ihm/domain/git/log/log_fetcher.dart';
import 'package:git_ihm/domain/git/status/git_status_command.dart';
import 'package:git_ihm/domain/git/status/git_status_implementation.dart';
import 'package:git_ihm/domain/git/status/status_fetcher.dart';
import 'package:git_ihm/domain/git/status/status_parser.dart';
import 'package:git_ihm/domain/git/version/git_version_command.dart';
import 'package:git_ihm/domain/git/version/git_version_implementation.dart';
import 'package:git_ihm/domain/git/version/version_fetcher.dart';
import 'package:git_ihm/git/base_command/init_fetcher.dart';
import 'package:git_ihm/git/git_init_implementation.dart';

class GitRegistry {
  GitStatusCommand get statusCommand =>
      GitStatusImplementation(StatusParser(), StatusFetcher());

  GitVersionCommand get versionCommand =>
      GitVersionImplementation(VersionFetcher());

  GitLogCommand get logCommand =>
      GitLogImplementation(LogFetcher(), CommitParser());

  //GitInitCommand get initCommand => GitInitImplementation(InitFetcher());
}
