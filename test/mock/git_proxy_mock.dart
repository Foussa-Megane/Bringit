import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/data/git_proxy.dart';

class GitProxyMock implements GitProxy {
  bool willFindGitDir = true;
  @override
  String path = '/original/path';

  @override
  Future<bool> isGitDir(String path) async {
    return willFindGitDir;
  }

  @override
  Future<List<StatusFile>> gitStatus(String path) async {
    return <StatusFile>[];
  }

  @override
  Future<String> gitVersion() {
    throw UnimplementedError();
  }
}
