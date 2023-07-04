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
import 'package:git_ihm/widget/button/staging_g_button.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class StagingScreen extends StatelessWidget {
  StagingScreen({Key? key}) : super(key: key);

  final List<Widget> stagingChildren = <Widget>[
    const ScrollablePanelContainer(
      title: Wording.stagingBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
      footer: StagingGButton(),
    ),
    const ScrollablePanelContainer(
      title: Wording.diffBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    ),
    const ScrollablePanelContainer(
      flex: 2,
      title: Wording.commitBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(sections: 2, children: stagingChildren);
  }
}
