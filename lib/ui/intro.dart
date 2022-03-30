import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:amalia_musica/widgets/line_horizontal_gruesa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: ScreenUtil().setWidth(size.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(size.width * 0.9),
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.rosaBase,
                      width: 3.0,
                      style: BorderStyle.solid)),
              margin: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text(
                  Strings.intro,
                  style: TextStyle(
                    fontFamily: FontFamily.bodoniFLF,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(36),
                    color: AppColors.grisBase,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPaint(
                painter: LineaHorizontalGruesa(
                    3, const Offset(-20.0, 0.0), const Offset(20.0, 0.0))),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: ResponsiveValue(
                  context,
                  defaultValue:  ScreenUtil().setHeight((size.height - kBottomNavigationBarHeight) * 0.6),
                  valueWhen:  [
                    
                    Condition.equals(
                      name: TABLET,
                      value:  ScreenUtil().setHeight((size.height - kBottomNavigationBarHeight) * 0.7),
                    )
                  ],
                ).value ?? 0.0,
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: -1.0,
                  children:[
                    Text(
                    Strings.texto1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: FontFamily.helvetica,
                      fontSize: ResponsiveValue(
                    context,
                    defaultValue: ScreenUtil().setSp(18),
                    valueWhen: const [
                      
                      Condition.equals(
                        name: TABLET,
                        value: 24.0,
                      )
                    ],
                  ).value ?? 0.0,
                      height: 1.5,
                      color: AppColors.grisBase,
                    ),
                  ),
                  Text(
                    Strings.texto2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: FontFamily.helvetica,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveValue(
                    context,
                    defaultValue: ScreenUtil().setSp(18),
                    valueWhen: const [
                      
                      Condition.equals(
                        name: TABLET,
                        value: 24.0,
                      )
                    ],
                  ).value ?? 0.0,
                      height: 1.5,
                      color: AppColors.grisBase,
                    ),
                  ),
                  Text(
                    Strings.texto3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: FontFamily.helvetica,
                      fontSize: ResponsiveValue(
                    context,
                    defaultValue: ScreenUtil().setSp(18),
                    valueWhen: const [
                      
                      Condition.equals(
                        name: TABLET,
                        value: 24.0,
                      )
                    ],
                  ).value ?? 0.0,
                      height: 1.5,
                      color: AppColors.grisBase,
                    ),
                  ),
                  ]
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
