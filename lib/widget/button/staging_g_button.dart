import 'package:flutter/material.dart';
import 'package:git_ihm/utils/button_level.dart';

import 'gamified_icon_text_button.dart';

class StagingGButton extends StatelessWidget {
  const StagingGButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return
      Container(
       height: 45,
        child: Row(
          children: <Widget> [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GamifiedIconTextButton(
                          title: 'Restore',
                          icon: Icons.restore,
                          onPressed: () {},
                          level: ButtonLevel.risky,
                        ),
                        GamifiedIconTextButton(
                          title: 'Add All',
                          icon: Icons.arrow_circle_right_rounded,
                          onPressed: () {},
                          level: ButtonLevel.safe,
                        ),
                        GamifiedIconTextButton(
                          title: 'Stash',
                          icon: Icons.cloud_download,
                          onPressed: () {},
                          level: ButtonLevel.safe,
                        ),
                        GamifiedIconTextButton(
                          title: 'Restore staged',
                          icon: Icons.arrow_circle_left_rounded,
                          onPressed: () {},
                          level: ButtonLevel.safe,
                        ),
                        GamifiedIconTextButton(
                          title: 'Delete',
                          icon: Icons.delete,
                          onPressed: () {},
                          level: ButtonLevel.risky,
                        ),
                     //   const Spacer(),

                      ],
                    ),
              ),
            ),
            GamifiedIconTextButton(
              title: 'Commit',
              icon: Icons.check,
              onPressed: () {},
              level: ButtonLevel.safe,
            )
          ],
        ),
      );
  }
}
