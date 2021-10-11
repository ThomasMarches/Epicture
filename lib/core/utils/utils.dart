import 'package:epicture/core/presentation/pages/image_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static void moveToImagePage(
    String id,
    String? author,
    String type,
    int width,
    int height,
    String? vote,
    bool favorite,
    String? title,
    String? description,
    DateTime datetime,
    String link,
    BuildContext context,
  ) {
    Navigator.of(context).pushNamed(ImagePage.routeName,
        arguments: ImagePageArguments(
          id: id,
          author: author,
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
    BuildContext context,
    void Function() onConfirmCallback,
  ) {
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
