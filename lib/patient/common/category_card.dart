import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/home/home.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/my_text_style.dart';

class CategoryCard extends StatelessWidget {
  final Categories? categories;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    this.categories,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${ConstRes.itemBaseURL}${categories?.image}');
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorRes.silver.withOpacity(0.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                              Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: '${ConstRes.itemBaseURL}${categories?.image ?? ' '}',
                        fit: BoxFit.cover,
                        height: 100,
                        width: double.infinity,
                        errorWidget: (context, url, error) {
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              Text(
                (categories?.title ?? PS.current.unKnown).toUpperCase(),
                style: MyTextStyle.montserratSemiBold(
                    size: 12, color: ColorRes.havelockBlue),
              ),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
