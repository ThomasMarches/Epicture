import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/presentation/pages/preview_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static void moveToPreviewPage(
    ImgurPost image,
    BuildContext context,
  ) {
    Navigator.of(context).pushNamed(PreviewPage.routeName,
        arguments: PreviewPageArguments(
          post: image,
        ));
  }

  static void showAlertDialog(
    BuildContext context,
    void Function() onConfirmCallback,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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

  static String getTimeDifference(DateTime date) {
    final difference = DateTime.now().difference(date);
    var timeDifferenceString = '';

    if (difference.inMinutes < 60) {
      timeDifferenceString = '${difference.inMinutes.toString()} minutes ago';
    } else if (difference.inHours < 24) {
      timeDifferenceString = '${difference.inHours.toString()} hours ago';
    } else if (difference.inDays < 30) {
      timeDifferenceString = '${difference.inDays.toString()} days ago';
    } else {
      timeDifferenceString = DateFormat.yMMMEd().format(date);
    }
    return timeDifferenceString;
  }

  static void showSnackbar(
    BuildContext context,
    String message,
    Color color,
    Duration duration,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }
}
