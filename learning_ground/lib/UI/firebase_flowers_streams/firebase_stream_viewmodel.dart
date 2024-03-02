import 'package:flutter/material.dart';
import 'package:learning_ground/core/base/base_viewmodel.dart';
import 'package:learning_ground/core/model/flower.dart';
import 'package:learning_ground/core/services/database_service.dart';
import 'package:learning_ground/locator.dart';

class FlowersScreenViewModel extends BaseViewModel {
  final firebaseDb = locator<FirebaseDatabaseService>();
  TextEditingController nameController = TextEditingController();

  bool isSavingData = false;

  saveFlower() async {
    isSavingData = true;
    print('FLOWER NAME: ${nameController.text}');
    await firebaseDb.storeflower(
      Flower(
        name: nameController.text,
        isFavorite: false,
      ),
    );

    nameController.clear();
    isSavingData = false;

    notifyListeners();
  }

  likeDislikeFlower({required String flowerId, required bool isLiked}) async {
    print('liked $isLiked');
    await firebaseDb.updateLike(flowerId, isLiked);
  }
}
