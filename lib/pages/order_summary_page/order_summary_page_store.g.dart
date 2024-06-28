// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderSummaryPageStore on _OrderSummaryPageStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_OrderSummaryPageStore.isLoading', context: context);

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

  late final _$schoolEmailAtom =
      Atom(name: '_OrderSummaryPageStore.schoolEmail', context: context);

  @override
  String get schoolEmail {
    _$schoolEmailAtom.reportRead();
    return super.schoolEmail;
  }

  @override
  set schoolEmail(String value) {
    _$schoolEmailAtom.reportWrite(value, super.schoolEmail, () {
      super.schoolEmail = value;
    });
  }

  late final _$loadSchoolEmailAsyncAction =
      AsyncAction('_OrderSummaryPageStore.loadschoolEmail', context: context);

  @override
  Future<void> loadSchoolEmail() {
    return _$loadSchoolEmailAsyncAction.run(() => super.loadSchoolEmail());
  }

  late final _$loadPageAsyncAction =
      AsyncAction('_OrderSummaryPageStore.loadPage', context: context);

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  late final _$sendEmailAsyncAction =
      AsyncAction('_OrderSummaryPageStore.sendEmail', context: context);

  @override
  Future<void> sendEmail() {
    return _$sendEmailAsyncAction.run(() => super.sendEmail());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
schoolEmail: ${schoolEmail}
    ''';
  }
}
