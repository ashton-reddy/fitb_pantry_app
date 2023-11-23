import 'package:auto_route/auto_route.dart';
import 'package:fitb_pantry_app/models/group_model/group_model.dart';
import 'package:fitb_pantry_app/pages/order_summary_page/order_summary_page_store.dart';
import 'package:fitb_pantry_app/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class OrderSummaryPage extends StatefulWidget {
  final List<GroupModel> orderList;

  const OrderSummaryPage({Key? key, required this.orderList}) : super(key: key);

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late final OrderSummaryPageStore pageStore;

  @override
  void initState() {
    pageStore = OrderSummaryPageStore(widget.orderList);
    pageStore.loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (pageStore.isLoading) {
          if (pageStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
        }
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: pageStore.orderSummaryList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 48.h,
                        ),
                        child: Text(
                          'Your order summary',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32.sp,
                          ),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        pageStore.orderSummaryList[index - 1].items.isNotEmpty
                            ? Text(
                                '$index. ${pageStore.orderSummaryList[index - 1].name}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 16.h,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                pageStore.orderSummaryList[index - 1].items.length,
                            itemBuilder: (BuildContext context, itemIndex) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4AC074),
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: const Color(0xff4AC074),
                                      width: 4.r,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 65.w,
                                        height: 50.h,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r),
                                          ),
                                        ),
                                        child: Image.network(
                                          pageStore.orderSummaryList[index - 1]
                                              .items[itemIndex].image,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        pageStore.orderSummaryList[index - 1]
                                            .items[itemIndex].label,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      const SizedBox(),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    context.router.replace(const CompletedRoute());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFF6600),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
