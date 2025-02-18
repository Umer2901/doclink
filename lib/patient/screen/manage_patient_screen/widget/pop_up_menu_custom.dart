import 'package:flutter/material.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';

class PopUpMenuCustom extends StatelessWidget {
  final Function(int value) onSelectedChange;

  const PopUpMenuCustom({Key? key, required this.onSelectedChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: ColorRes.whiteSmoke,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
      ),
      onSelected: onSelectedChange,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(PS.current.edit),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(PS.current.delete),
        ),
      ],
      child: Image.asset(
        AssetRes.icMore,
        width: 18,
        color: ColorRes.tuftsBlue,
      ),
    );
  }
}
