import 'package:auto_route/auto_route.dart';
import 'package:fitb_pantry_app/pages/order_page/order_page_store.dart';
import 'package:fitb_pantry_app/pages/order_page/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class OrderPage extends StatefulWidget {
  final String studentId;

  const OrderPage({
    Key? key,
    required this.studentId,
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
          child: ListView(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: pageStore.itemList.length,
                  itemBuilder: (BuildContext context, index) {
                    return ItemCard(
                      img: pageStore.itemList[index].image,
                      label: pageStore.itemList[index].label,
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }
}
