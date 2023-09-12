import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/models/item_model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'order_page_store.g.dart';

@injectable
class OrderPageStore = _OrderPageStore with _$OrderPageStore;

abstract class _OrderPageStore with Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _OrderPageStore();

  @observable
  bool isLoading = false;

  @observable
  List<ItemModel> itemList = [];

  @action
  Future<void> loadPage() async {
    isLoading = true;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("Items").get();

    for (var doc in querySnapshot.docs) {
      itemList.add(
        ItemModel(
          image: doc['image'],
          group: doc['group'],
          id: doc['id'],
          label: doc['label'],
        ),
      );
    }
    isLoading = false;
  }
}
