/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

//import 'package:e_commerce/blocs/app_state.dart';
//import 'package:e_commerce/utils/styles.dart';
import 'package:fitb_pantry_app/styles.dart';
import 'package:flutter/material.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet({required Key key}) : super(key: key);

  @override
  _AddToCartBottomSheetState createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int _quantity = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height / 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Spacing.matGridUnit()),
            child: Text(
              "Add item to Cart",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: Spacing.matGridUnit(scale: 3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    iconSize: 40.0,
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 0) {
                        setState(() => _quantity--);
                      }
                    }),
                Text(_quantity.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    )),
                IconButton(
                  iconSize: 40.0,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() => _quantity++);
                  },
                )
              ],
            ),
          ),
          ElevatedButton(
            child: Text(
              "Add To Cart".toUpperCase(),
              style: TextStyle(
                backgroundColor: AppColors.primary[500],
                color: Colors.white,
              ),
            ),
            //         onPressed: () => state.updateCartTotal(_quantity)
            onPressed: () => Navigator.of(context).pop(_quantity),
          )
        ],
      ),
    );
  }
}
