import 'package:flutter/material.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      this.width,
      this.height,
      this.backgroundColor,
      this.horizontalPadding,
      this.verticalPadding ,
      this.secondTitle = "",
      this.margin,
      required this.onTap,
      this.decoration,
      this.hasSecondText = false,
      this.textColor,
      this.borderColor})
      : super(key: key);

  final void Function()? onTap;
  final String title, secondTitle;
  final double? width, height;
  final Color? backgroundColor;
  final double? horizontalPadding, verticalPadding;
  final BoxDecoration? decoration;
  final Color? textColor, borderColor;
  final bool hasSecondText;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
         height: height,
         width: width,
        padding: EdgeInsets.symmetric(vertical: verticalPadding??14, horizontal: horizontalPadding ??0),
        // margin: margin?? EdgeInsets.symmetric(horizontal: 8.w),
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor,
              // gradient: hasBackgroundColor ? ThemeClass.gradientBtn : null,
              borderRadius:  BorderRadius.circular(10)
            //  border: Border.all(color: borderColor ?? CustomColors.primaryColor)

            ),
        child:  Row(
                mainAxisAlignment: hasSecondText ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          //fontFamily: Provider.of<AppLanguageProvider>(context).appLocale == const Locale("ar") ? "Almarai" : "Montserrat",
                          overflow: TextOverflow.ellipsis,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  hasSecondText ?
                  Text(
                    secondTitle,
                    style: TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          //fontFamily: Provider.of<AppLanguageProvider>(context).appLocale == const Locale("ar") ? "Almarai" : "Montserrat",
                          overflow: TextOverflow.ellipsis,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ) : const SizedBox(),
                ],
              )
      ),
    );
  }
}
