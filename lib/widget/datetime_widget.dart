// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do_riverpod/constants/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.iconSection,
    required this.onTap,
  });

  final String titleText;
  final String valueText;
  final IconData iconSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: AppStyle.headingOne,
          ),
          Gap(6),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => onTap(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(iconSection),
                      Gap(10),
                      Text(valueText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
