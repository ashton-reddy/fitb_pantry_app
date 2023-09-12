// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderPageStore on _OrderPageStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_OrderPageStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$itemListAtom =
      Atom(name: '_OrderPageStore.itemList', context: context);

  @override
  List<ItemModel> get itemList {
    _$itemListAtom.reportRead();
    return super.itemList;
  }

  @override
  set itemList(List<ItemModel> value) {
    _$itemListAtom.reportWrite(value, super.itemList, () {
      super.itemList = value;
    });
  }

  late final _$groupListAtom =
      Atom(name: '_OrderPageStore.groupList', context: context);

  @override
  List<GroupModel> get groupList {
    _$groupListAtom.reportRead();
    return super.groupList;
  }

  @override
  set groupList(List<GroupModel> value) {
    _$groupListAtom.reportWrite(value, super.groupList, () {
      super.groupList = value;
    });
  }

  late final _$loadPageAsyncAction =
      AsyncAction('_OrderPageStore.loadPage', context: context);

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
itemList: ${itemList},
groupList: ${groupList}
    ''';
  }
}
