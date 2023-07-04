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
import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/screen/screen_template.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

import '../widget/file_tree.dart';

class ExplorerScreen extends StatelessWidget {
  ExplorerScreen({Key? key}) : super(key: key);

  final List<Widget> explorerChildren = <Widget>[
    const ScrollablePanelContainer(
      title: Wording.previewBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    ),
    const ScrollablePanelContainer(
      flex: 2,
      title: Wording.explorerBlockTitle,
      child: FileTree(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(sections: 1, children: explorerChildren);
  }
}
