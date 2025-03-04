import 'package:flutter/material.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:doclink/utils/update_res.dart';

class ChatDateFormat extends StatelessWidget {
  final String? time;

  const ChatDateFormat({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        (time ?? milliDate).dateMilliFormat(ddMmmYyyyHhMmA),
        style: const TextStyle(
          fontFamily: FontRes.light,
          fontSize: 12,
          color: ColorRes.davyGrey,
        ),
      ),
    );
  }
}
