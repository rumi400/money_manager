import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Common
{
  static Future<DateTime> showMyDatePicker(BuildContext context) async
  {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime(2122)
    );

    if(date != null)
      {
        return date;
      }
    else
      {
        return DateTime.now();
      }
  }

  static String getFormattedDate(DateTime dateTime)
  {
    return DateFormat("dd-MMM-yyyy").format(dateTime);
  }

  static showMyDialog({required BuildContext context,required Function() onPressed}) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete"),
            content: const Text("Do You want to delete this task?"),
            actions: [
              TextButton(
                  onPressed: (){
                    onPressed();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  static signOutDialog({required BuildContext context,required Function() onPressed}) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sign Out"),
            content: const Text("Do You want to Sign out from the App?"),
            actions: [
              TextButton(
                  onPressed: (){
                    onPressed();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  static showSnackBar({required BuildContext context, required String message}) async
  {
    SnackBar snackBar = SnackBar
      (content: Text(message),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showNotification({required BuildContext context, required String title, required String content, required MessageType messageType})
  {
    if(messageType == MessageType.success)
      {
        ElegantNotification.success(
            title:  Text(title),
            description:  Text(content)
        ).show(context);
      }
    else if(messageType == MessageType.error)
    {
      ElegantNotification.error(
          title:  Text(title),
          description:  Text(content)
      ).show(context);
    }
    else if(messageType == MessageType.info)
    {
      ElegantNotification.info(
          title:  Text(title),
          description:  Text(content)
      ).show(context);
    }
  }


}

enum MessageType{error, success, info}