
import 'package:amalia_musica/constants/colors.dart';
import 'package:flutter/material.dart';

import 'app_bar_widget.dart';

class HeaderWidget extends StatelessWidget {
  final double fontSizeMainHeader;

  const HeaderWidget({Key? key, required this.fontSizeMainHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double toolbarHeight = kToolbarHeight + 50;
    return Container(
      child: const AppBarWidget(),
      height: toolbarHeight,
      padding: const EdgeInsets.only(top: 50.0),
      decoration: const BoxDecoration(
        color: AppColors.rosaBase,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
      ),
    );
  }
}
