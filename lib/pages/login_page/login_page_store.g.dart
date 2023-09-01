// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginPageStore on _LoginPageStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_LoginPageStore.isLoading', context: context);

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

  late final _$schoolsListAtom =
      Atom(name: '_LoginPageStore.schoolsList', context: context);

  @override
  List<DropdownMenuItem<dynamic>> get schoolsList {
    _$schoolsListAtom.reportRead();
    return super.schoolsList;
  }

  @override
  set schoolsList(List<DropdownMenuItem<dynamic>> value) {
    _$schoolsListAtom.reportWrite(value, super.schoolsList, () {
      super.schoolsList = value;
    });
  }

  late final _$loadPageAsyncAction =
      AsyncAction('_LoginPageStore.loadPage', context: context);

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
schoolsList: ${schoolsList}
    ''';
  }
}
