import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';


class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? hint;
  final String? label;
  final Color? backGroundColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLine;
  final int? prefixWidth;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? enable, isDense;
  final Color? borderColor;
  final double? borderRadiusValue, width, height;
  final EdgeInsets? insidePadding;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onchange;
  final void Function(String)? onFieldSubmitted;
  final Function()? onSuffixTap;
  final void Function()? onTap;
  final List<TextInputFormatter>? formatter;
  final TextInputAction? textInputAction;
  final bool? noBorder;
final TextDirection? textDirection;
  const CustomTextFieldWidget({
    Key? key,
    this.isDense,
    this.style,
    this.onchange,
    this.insidePadding, this.validator,
    this.maxLine,
    this.hint,
    this.label,
    this.backGroundColor,
    this.controller,
    this.obscure = false,
    this.enable = true,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.borderColor,
    this.borderRadiusValue,
    this.prefixIcon,
    this.width,
    this.hintStyle,
    this.suffixIcon,
    this.onSuffixTap,
    this.height,
    this.onTap,
    this.prefixWidth,
    // this.noBorder = true,
    this.formatter,
    this.onFieldSubmitted,  this.textDirection, this.noBorder=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
       height: height,
      child: TextFormField(
        // cursorHeight: 20.h,
        readOnly: readOnly ?? false,
        textAlignVertical: TextAlignVertical.center,
        validator: validator,
        onTap: () => onTap,
        enabled: enable,
        inputFormatters: formatter ?? [],
        obscureText: obscure ?? false,
        obscuringCharacter: obscure != null ? "*" : '',
        textInputAction: textInputAction,
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          errorStyle:TextStyle(height: 0,
           fontFamily: Localizations.localeOf(context).languageCode == "ar" ? "Almarai" : "Montserrat",
            fontSize: 14
          ),
          label: TextDefaultWidget(title: label ?? "", color: CustomColors.greyColor, fontWeight: FontWeight.w500, fontSize: 12,),
          enabledBorder:noBorder==true?InputBorder.none: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue ?? 10),
              borderSide: BorderSide(color: CustomColors.whiteColor)),
          disabledBorder: noBorder==true?InputBorder.none:OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue ?? 10),
              borderSide: BorderSide(color: CustomColors.whiteColor)),
          focusedBorder:noBorder==true?InputBorder.none: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue ?? 10),
              borderSide: BorderSide(color: CustomColors.whiteColor)),
          border:noBorder==true?InputBorder.none: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue ?? 10),
              borderSide: BorderSide(color: CustomColors.whiteColor)),
          isDense: isDense ?? false,
          prefixIconConstraints: BoxConstraints(minWidth: prefixIcon == null ? 0 : 35, maxHeight: 20),
          suffixIconConstraints: BoxConstraints(minWidth: suffixIcon == null ? 0 : 45, maxHeight: 40),
          contentPadding: insidePadding ?? const EdgeInsets.symmetric(vertical: 6),
          fillColor: backGroundColor,
          filled: backGroundColor != null,
          hintText: hint,
          prefixIcon: prefixIcon == null ? const SizedBox(width: 10) : SizedBox(width: 30, child: prefixIcon),
          suffixIcon: suffixIcon == null ? const SizedBox(width: 5) : InkWell(onTap: onSuffixTap, child: SizedBox(width: 30, child: suffixIcon),),
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 16,
                  fontFamily: Localizations.localeOf(context).languageCode == "ar" ? "Almarai" : "Montserrat",
                  color: CustomColors.whiteColor,
                  height: 1.5,
                  fontWeight: FontWeight.w400),
          // labelStyle: TextStyle(
          //    // fontSize: 12.sp,
          //     color: CustomColors.whiteColor,
          //     height: 1.5,
          //    // fontWeight: FontWeight.w400
          // )
        ),
        onChanged: onchange,
        textCapitalization: TextCapitalization.words,
        maxLines: maxLine ?? 1,
        keyboardType: textInputType,
        style: style ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: Localizations.localeOf(context).languageCode == "ar" ? "Almarai" : "Montserrat",
              color: CustomColors.whiteColor,
            ),
        cursorColor: Colors.black,
        onEditingComplete: (){
          if(controller?.text.indexOf(' ',0)!=null){
            controller?.text.replaceFirst(" ", '');
          }
        },
      ),
    );
  }
}

