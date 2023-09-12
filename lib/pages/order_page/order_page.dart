import 'package:auto_route/auto_route.dart';
import 'package:fitb_pantry_app/pages/login_page/widgets/logo_header_widget.dart';
import 'package:fitb_pantry_app/pages/order_page/order_page_store.dart';
import 'package:fitb_pantry_app/pages/order_page/widgets/item_card.dart';
import 'package:fitb_pantry_app/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class OrderPage extends StatefulWidget {

  const OrderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderPageStore pageStore = OrderPageStore();

  @override
  void initState() {
    pageStore.loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (pageStore.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 48.h, 16.w, 0),
          child: ListView.builder(
              itemCount: pageStore.groupList.length + 1 + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: const LogoHeaderWidget(),
                  );
                }
                if (index - 1 == pageStore.groupList.length) {
                  return GestureDetector(
                    onTap: () {
                      context.router.push(
                        OrderSummaryRoute(
                          orderList: pageStore.groupList,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 32.h,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff2F4DED),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.all(14.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              pageStore.groupList[index - 1].name,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          'Select ${pageStore.groupList[index - 1].limit}',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4 / 5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: pageStore.groupList[index - 1].items.length,
                        itemBuilder: (BuildContext context, itemIndex) {
                          return ItemCard(
                            pageStore: pageStore,
                            groupIndex: index - 1,
                            itemIndex: itemIndex,
                          );
                        }),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                );
              }),
        );
      }),
    );
  }
}
