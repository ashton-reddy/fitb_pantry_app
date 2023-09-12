import 'package:fitb_pantry_app/models/item_model/item_model.dart';

class GroupModel {

  final String name;
  final int limit;
  List<ItemModel> items = [];

  GroupModel({
    required this.name,
    required this.limit,
  });
}