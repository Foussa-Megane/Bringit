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

import 'package:flutter/material.dart';
import 'package:git_ihm/domain/git/git_factory.dart';
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/helpers/localization/wording.dart';
import 'package:git_ihm/ui/common/widget/shared/button/modal_action_button.dart';
import 'package:git_ihm/ui/common/widget/shared/textfield/textfield_project_name.dart';

import '../../../screens/main_screen.dart';
import '../shared/textfield/textfield_select_folder_path.dart';

class NewGitProjectForm extends StatefulWidget {
  const NewGitProjectForm({Key? key}) : super(key: key);

  @override
  State<NewGitProjectForm> createState() => _NewGitProjectFormState();
}

class _NewGitProjectFormState extends State<NewGitProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String pathToNewProject = '';
  late String projectNameMessageError = '';
  bool isProjectPathValid = false;
  bool isProjectNameValid = true;
  bool isProjectNameNotYetModified = true;
  late GitProxy git;

  final TextEditingController pathDirectoryController = TextEditingController();
  String? selectedDirectory;

  Future<void> onProjectNameChanged(String? val) async {
    projectNameMessageError = '';
    final String pathDirectory = pathDirectoryController.text;
    pathToNewProject = '$pathDirectory/$val';
    isProjectNameNotYetModified = false;

    if (val!.isEmpty) {
      projectNameMessageError =
          Wording.modalCreateNewGitProjectErrorMessageForEmptyProjectName;
      isProjectNameValid = false;
    } else if (!isValidFolderNameSyntax(val)) {
      projectNameMessageError =
          '$val ${Wording.modalCreateNewGitProjectErrorMessageForInvalidProjectName}';
      isProjectNameValid = false;
    } else {
      isProjectNameValid = true;
      final bool isPathExisting = Directory(pathToNewProject).existsSync();
      if (isPathExisting) {
        projectNameMessageError =
            '$pathToNewProject ${Wording.modalCreateNewGitProjectErrorMessageForExistingProjectPath}';
        isProjectNameValid = false;
      }
    }
    setState(() {});
  }

  bool isValidFolderNameSyntax(String name) {
    final RegExp folderNameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    return folderNameRegex.hasMatch(name);
  }

  @override
  void initState() {
    GitFactory().getGit().then((GitProxy gitP) {
      setState(() {
        git = gitP;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextfieldSelectFolderPath(
            isProjectPathValid: isProjectPathValid,
            label:
                Wording.modalCreateNewGitProjectTextfieldSelectFolderPathLabel,
            pathDirectoryController: pathDirectoryController,
          ),
          TextfieldProjectName(
            isProjectNameValid: isProjectNameValid,
            isProjectNameNotYetModified: isProjectNameNotYetModified,
            pathDirectoryController: pathDirectoryController,
            onProjectNameChanged: onProjectNameChanged,
            projectNameMessageError: projectNameMessageError,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: ModalActionButton(
                        onSubmit: () {
                          Navigator.of(context).pop();
                        },
                        title:
                            Wording.modalCreateNewGitProjectCancelButtonTitle)),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: ModalActionButton(
                  onSubmit: () {
                    git.gitInit(pathToNewProject);
                    Navigator.push<MaterialPageRoute<dynamic>>(
                        context,
                        MaterialPageRoute<MaterialPageRoute<dynamic>>(
                            builder: (BuildContext context) =>
                                const MainScreen()));
                  },
                  enable: isProjectNameValid && !isProjectNameNotYetModified,
                  title: Wording.modalCreateNewGitProjectCreateButtonTitle,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
