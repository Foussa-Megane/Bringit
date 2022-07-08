import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/git_version_command.dart';
import 'package:git_ihm/git/base_command/log_fetcher.dart';
import 'package:git_ihm/git/base_command/status_fetcher.dart';
import 'package:git_ihm/git/base_command/version_fetcher.dart';
import 'package:git_ihm/git/git_log_implementation.dart';
import 'package:git_ihm/git/git_status_implementation.dart';
import 'package:git_ihm/git/git_version_implementation.dart';
import 'package:git_ihm/git/parsers/commit_parser.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';

import '../data/git/git_log_command.dart';

class GitRegistry {
  GitStatusCommand get statusCommand =>
      GitStatusImplementation(StatusParser(), StatusFetcher());

  GitVersionCommand get versionCommand =>
      GitVersionImplementation(VersionFetcher());

  GitLogCommand get logCommand =>
      GitLogImplementation(LogFetcher(), CommitParser());
}
