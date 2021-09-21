import 'package:epicture/core/presentation/pages/image_page.dart';
import 'package:flutter/material.dart';

class Utils {
  static void moveToImagePage(
    String id,
    String type,
    int width,
    int height,
    String? vote,
    bool favorite,
    String? title,
    String? description,
    int datetime,
    String? section,
    String link,
    BuildContext context,
  ) {
    Navigator.of(context).pushNamed(ImagePage.routeName,
        arguments: ImagePageArguments(
          section: section,
          id: id,
          title: title,
          vote: vote,
          width: width,
          height: height,
          favorite: favorite,
          type: type,
          description: description,
          link: link,
          datetime: datetime,
        ));
  }

  static void showAlertDialog(
      BuildContext context, void Function() onConfirmCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm delete"),
          content: const Text(
              "Would you like to continue and delete your comment ?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirmCallback();
              },
            ),
          ],
        );
      },
    );
  }
}
