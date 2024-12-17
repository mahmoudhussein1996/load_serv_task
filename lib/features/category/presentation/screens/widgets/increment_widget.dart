import 'package:flutter/material.dart';
import 'package:load_serv_task/core/shared_widgets/custom_text_widget.dart';
class IncrementWidget extends StatelessWidget {
  int counter;
  final void Function()? plusOnTap;
  final void Function()? minusOnTap;
  IncrementWidget({super.key, required this.counter, required this.plusOnTap, required this.minusOnTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(onTap: (){
          minusOnTap!();
        },child: Image.asset("assets/images/minus.png", width: 34, height: 34, fit: BoxFit.scaleDown, filterQuality: FilterQuality.high,)),
        const SizedBox(width: 10,),
        TextDefaultWidget(title: "$counter", fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black,),
        const SizedBox(width: 10,),
        InkWell(onTap: (){
          plusOnTap!();
        },child: Image.asset("assets/images/plus.png", width: 34, height: 34, fit: BoxFit.scaleDown, filterQuality: FilterQuality.high,)),
      ],
    );
  }
}
