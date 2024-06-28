// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fitb_pantry_app/models/group_model/group_model.dart' as _i7;
import 'package:fitb_pantry_app/pages/login_page/login_page_store.dart' as _i4;
import 'package:fitb_pantry_app/pages/order_page/order_page_store.dart' as _i5;
import 'package:fitb_pantry_app/pages/order_summary_page/order_summary_page_store.dart'
    as _i6;
import 'package:fitb_pantry_app/services/account_service.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AccountService>(() => _i3.AccountService());
    gh.factory<_i4.LoginPageStore>(() => _i4.LoginPageStore());
    gh.factory<_i5.OrderPageStore>(() => _i5.OrderPageStore());
    gh.factory<_i6.OrderSummaryPageStore>(
        () => _i6.OrderSummaryPageStore(gh<List<_i7.GroupModel>>()));
    return this;
  }
}
