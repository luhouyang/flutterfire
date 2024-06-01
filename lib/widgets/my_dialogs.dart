import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:note/usecase/user_usecase.dart';

class MyDialogs {
  Future<void> editNameDialog(BuildContext context) async {
    TextEditingController editNameController = TextEditingController();

    UserUsecase userUsecase = Provider.of<UserUsecase>(context, listen: false);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Username"),
          content: TextField(
            controller: editNameController,
            decoration:
                InputDecoration(
                  labelText: userUsecase.userEntity.username,
                  ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                // call userUseCase.updateUsername to edit username
                await userUsecase
                    .updateUsername(editNameController.text)
                    .then((value) => Navigator.of(context).pop());
              },
            )
          ],
        );
      },
    );
  }

}