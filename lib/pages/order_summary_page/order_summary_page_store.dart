import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/models/group_model/group_model.dart';
import 'package:fitb_pantry_app/models/item_model/item_model.dart';
import 'package:fitb_pantry_app/services/account_service.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'order_summary_page_store.g.dart';

@injectable
class OrderSummaryPageStore = _OrderSummaryPageStore with _$OrderSummaryPageStore;

abstract class _OrderSummaryPageStore with Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<GroupModel> orderList;

  _OrderSummaryPageStore(this.orderList);

  List<GroupModel> orderSummaryList = [];
  List<ItemModel> orderedItems = [];

  @observable
  bool isLoading = false;

  @action
  Future<void> loadPage() async {
    isLoading = true;

    orderSummaryList = List.from(orderList);
    for (int i = 0; i < orderList.length; i++) {
      for (int j = 0; j < orderList[i].items.length; j++) {
        if (!orderList[i].items[j].ordered) {
          orderSummaryList[i].items.removeAt(j);
        } else {
          orderedItems.add(orderList[i].items[j]);
        }
      }
    }

    try {

      CollectionReference studentOrders =
      FirebaseFirestore.instance.collection('Orders');

      Map<String, dynamic> dataToSave = {
        'items': orderedItems.map((item) => {'itemId': item.id, 'quantity': 1})
          .toList(),
        'studentId': AccountService.id,
      };

      // Save the data to the cart items collection
      await studentOrders.add(dataToSave);
      print('Items added to cart in Firestore.');

    } catch (e) {
      print('Error adding items to cart in Firestore: $e');
    }

    isLoading = false;
  }
}