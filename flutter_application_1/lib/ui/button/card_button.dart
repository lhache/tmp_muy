import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/design.dart';

class CardButton extends StatelessWidget {
  final void Function() onTap;
  final void Function()? onShare;
  final bool enableShare;
  final bool? disabled;
  final String title;
  final String description;
  final bool? success;
  final String? next;

  const CardButton({
    required this.onTap,
    this.onShare,
    required this.enableShare,
    required this.title,
    required this.description,
    this.success,
    this.disabled,
    this.next,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: disabled == true
            ? CustomColors.disabledBackgroundColor
            : CustomColors.lighterBackgroundColor,
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 300,
            // height: 135,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    title,
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: CustomColors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // trailing: success == null
                  //     ? null
                  //     : success == true
                  //         ? const Icon(
                  //             Icons.check_circle,
                  //             color: CustomColors.rightPosition,
                  //           )
                  //         : const Icon(
                  //             Icons.mood_bad_outlined,
                  //             color: CustomColors.wrongPosition,
                  //           ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: onTap,
                      child: Text(
                        next != null ? '$next' : '',
                        style: const TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    enableShare
                        ? IconButton(
                            icon: const Icon(Icons.share),
                            color: CustomColors.white,
                            iconSize: 35,
                            onPressed: onShare,
                          )
                        : !disabled!
                            ? IconButton(
                                icon: const Icon(Icons.play_circle_outline),
                                color: CustomColors.rightPosition,
                                iconSize: 35,
                                onPressed: onTap,
                              )
                            : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
