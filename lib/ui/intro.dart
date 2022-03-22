import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home2.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.9,
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
              height: 60,
            ),
            Container(
              height: size.height * 0.6,
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Text(
                  Strings.texto,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: FontFamily.helvetica,
                    fontSize: ScreenUtil().setSp(18),
                    height: 1.5,
                    color: AppColors.grisBase,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
