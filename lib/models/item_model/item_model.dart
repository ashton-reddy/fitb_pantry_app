class ItemModel {

  final String group;
  final String id;
  final String image;
  final String label;
  bool ordered = false;

  ItemModel({
    required this.group,
    required this.id,
    required this.image,
    required this.label,
  });
}