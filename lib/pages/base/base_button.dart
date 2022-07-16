import 'package:flutter/material.dart';
import '../../../res/all_core.dart';

//button Icon and Text Elevation
class IconAndTextButton extends StatelessWidget {
  IconAndTextButton({
    Key? key,
    required this.onPressed,
    required this.baseIcon,
    required this.buttonName,
    this.baseColor = Colors.blue,
    this.width = double.infinity,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData baseIcon;
  final String buttonName;
  final MaterialColor baseColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        gradient:  LinearGradient(
            colors: [baseColor.shade200, baseColor.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      width: width.w,
      height: 40.w,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(baseColor.shade100),
            elevation: MaterialStateProperty.all(10),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Icon(baseIcon),
            SizedBox(width: 10,),
            Text(buttonName, style: text16.semiBold,)
          ],)),
    );
  }
}
//button Only Icon and Text Elevation
class TextElevationButton extends StatelessWidget {
  TextElevationButton({
    Key? key,
    required this.onPressed,
    required this.buttonName,
    this.baseColor = Colors.blue,
    this.width = double.infinity,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonName;
  final MaterialColor baseColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        gradient:  LinearGradient(
            colors: [baseColor.shade200, baseColor.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      width: width.w,
      height: 40.w,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(baseColor),
            elevation: MaterialStateProperty.all(10),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(buttonName, style: text16.semiBold,)),
    );
  }
}

class TextInkWellButton extends StatelessWidget {
  TextInkWellButton({
    Key? key,
    required this.onPressed,
    required this.buttonName,
    this.baseIcon,
    this.baseColor,
    this.width = double.infinity,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData? baseIcon;
  final String buttonName;
  final MaterialColor? baseColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (baseColor != null) ?BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        gradient:  LinearGradient(
            colors: [baseColor!.shade200, baseColor!.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ) : null,
      width: width.w,
      height: 35.w,
      child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              (baseIcon != null) ?  Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Icon(baseIcon, size: 20,),
              ) : SizedBox.shrink(),
              Text(buttonName, style: text16),
            ],
          )),
    );
  }
}