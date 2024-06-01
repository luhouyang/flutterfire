import 'package:flutter/material.dart';
import 'package:note/entities/user_entity.dart';
import 'package:note/model/database_model.dart';

class UserUsecase extends ChangeNotifier {
  UserEntity userEntity = UserEntity(username: "", email: "");

  /*
  getUserData function, async
  doesn't take argument
  get Map<String, dynamic> data by calling database model getUserData
  create new UserEntity
  update userEntity
  notifyListeners()
  return void
  */
  Future<void> getUserData() async {
    // call firebase model
    Map<String, dynamic> data = await DatabaseModel().getUserData();

    // update userEntity
    UserEntity newUserEntity = UserEntity.fromMap(data);
    userEntity.username = newUserEntity.username;
    userEntity.email = newUserEntity.email;

    notifyListeners();
  }

  /*
  updateUsername function, async
  takes String newUsername
  set userEntity.username to newUsername
  call database model updateUsername
  notifyListeners()
  return void
  */
  Future<void> updateUsername(String newUsername) async {
    userEntity.username = newUsername;

    await DatabaseModel().updateUsername(userEntity);
    
    notifyListeners();
  }
}
