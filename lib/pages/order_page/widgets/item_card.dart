import 'package:fitb_pantry_app/pages/order_page/order_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatefulWidget {
  final OrderPageStore pageStore;
  final int groupIndex;
  final int itemIndex;

  const ItemCard({
    Key? key,
    required this.pageStore,
    required this.groupIndex,
    required this.itemIndex,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.pageStore.chosenItemsCounts[widget.groupIndex] >=
                widget.pageStore.groupList[widget.groupIndex].limit &&
            !widget.pageStore.groupList[widget.groupIndex]
                .items[widget.itemIndex].ordered) {
          final snackBar = SnackBar(
            content: Text(
              'Sorry, you can only choose ${widget.pageStore.groupList[widget.groupIndex].limit}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          if (!widget.pageStore.groupList[widget.groupIndex]
              .items[widget.itemIndex].ordered) {
            widget.pageStore.chosenItemsCounts[widget.groupIndex]++;
            widget.pageStore.groupList[widget.groupIndex]
                .items[widget.itemIndex].ordered = true;
          } else {
            widget.pageStore.chosenItemsCounts[widget.groupIndex]--;
            widget.pageStore.groupList[widget.groupIndex]
                .items[widget.itemIndex].ordered = false;
          }
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.pageStore.groupList[widget.groupIndex]
                  .items[widget.itemIndex].ordered
              ? const Color(0xff4AC074)
              : const Color(0xff364357),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: widget.pageStore.groupList[widget.groupIndex]
                    .items[widget.itemIndex].ordered
                ? const Color(0xff4AC074)
                : const Color(0xff364357),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
                child: Image.network(
                  widget.pageStore.groupList[widget.groupIndex]
                      .items[widget.itemIndex].image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.pageStore.groupList[widget.groupIndex]
                        .items[widget.itemIndex].label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.pageStore.groupList[widget.groupIndex]
                                .items[widget.itemIndex].ordered
                            ? Icons.check_circle
                            : Icons.add_circle_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        widget.pageStore.groupList[widget.groupIndex]
                                .items[widget.itemIndex].ordered
                            ? 'Added'
                            : 'Add',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
