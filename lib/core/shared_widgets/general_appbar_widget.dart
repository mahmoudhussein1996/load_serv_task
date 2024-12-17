import 'package:flutter/material.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
import 'package:load_serv_task/core/theme/colors.dart';

class GeneralAppbarWidget extends StatelessWidget {
  String title;
  Color titleColor;
  final void Function()? backOnTap;
  GeneralAppbarWidget({super.key, required this.title, required this.titleColor, required this.backOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ()=> backOnTap!(),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],color: CustomColors.whiteColor,borderRadius: BorderRadius.circular(6)),
              width: 32, height: 32,
              alignment:Alignment.center,
              child: const Center(child: Icon(Icons.arrow_back_ios, size: 16,)),
            ),
          ),
          TextDefaultWidget(title: title,fontWeight: FontWeight.w700, color: titleColor,fontSize: 24,),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],color: CustomColors.whiteColor,borderRadius: BorderRadius.circular(6)),
            width: 32, height: 32,
            alignment:Alignment.center,
            child: const Center(child: Icon(Icons.menu, size: 16,)),
          ),
        ],
      ),
    );
  }
}
