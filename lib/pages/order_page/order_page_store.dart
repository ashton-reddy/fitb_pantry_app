import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/models/group_model/group_model.dart';
import 'package:fitb_pantry_app/models/item_model/item_model.dart';
import 'package:fitb_pantry_app/services/account_service.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'order_page_store.g.dart';

@injectable
class OrderPageStore = _OrderPageStore with _$OrderPageStore;

abstract class _OrderPageStore with Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _OrderPageStore();

  List<int> chosenItemsCounts = [];

  @observable
  bool isLoading = false;

  @observable
  List<ItemModel> itemList = [];

  @observable
  List<GroupModel> groupList = [];

  @action
  Future<void> loadPage() async {
    isLoading = true;

    QuerySnapshot<Map<String, dynamic>> groupsSnapshot =
        await firestore.collection("Groups").get();

    for (var doc in groupsSnapshot.docs) {
      groupList.add(
        GroupModel(
          name: doc['name'],
          limit: doc['totalLimit'],
        ),
      );
      chosenItemsCounts.add(0);
    }

    QuerySnapshot<Map<String, dynamic>> itemsSnapshot =
        await firestore.collection("Items").get();

    for (var group in groupList) {
      for (var doc in itemsSnapshot.docs) {
        if (doc['group'] == group.name) {
          group.items.add(
            ItemModel(
              image: doc['image'],
              group: doc['group'],
              id: doc['id'],
              label: doc['label'],
            ),
          );
        }
      }
    }
    isLoading = false;
  }
}
