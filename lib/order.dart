import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitb_pantry_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: OrderPage()));
}

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}



class _OrderPageState extends State<OrderPage> {
  String _itemNameOrder = '';
  bool _isPopupOpen = false;
  List<String> imageUrls = [];
  List<String> itemIds = [];
  List<String> imageUrls2 = [];
  List<String> itemIds2 = [];
  List<String> imageUrls3 = [];
  List<String> itemIds3 = [];
  List<String> imageUrls4 = [];
  List<String> itemIds4 = [];
  List<String> groupNames = [];
  List<int> totalLimits = [];
  List<int> eachLimits = [];
  List<String> groupDirections = [];


  @override
  void initState() {
    super.initState();
    createLists();
    getDirections();
  }

  void _showPopupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: PopupContent(itemNameOrder: '',),
        );
      },
    ).then((value) {
      // Handle any logic after the popup is closed (if needed)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Set mainAxisSize to MainAxisSize.min
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity, height: 100),
            Image(
              image: AssetImage('assets/fitb.png'),
            ),
            SizedBox(height: 50),
            Text(
              groupNames.elementAt(3),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
                groupDirections.elementAt(3),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemIds.length,
              itemBuilder: (context, index) {
                return itemCard(index);

              },
            ),
            Text(
              groupNames.elementAt(0),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              groupDirections.elementAt(0),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemIds2.length,
              itemBuilder: (context, index) {
                return itemCard2(index);

              },
            ),
            Text(
              groupNames.elementAt(2),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              groupDirections.elementAt(2),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemIds3.length,
              itemBuilder: (context, index) {
                return itemCard3(index);

              },
            ),
            Text(
              groupNames.elementAt(1),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              groupDirections.elementAt(1),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemIds4.length,
              itemBuilder: (context, index) {
                return itemCard4(index);

              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                elevation: 0.0,
              ).copyWith(elevation: MaterialStateProperty.all<double>(0.0)),
              child: Container(
                child: const Text(
                  'Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                height: 60,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  Future<Map<dynamic, List<String>>> createLists() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Items').get();
    final Map<dynamic, List<String>> lists = {};

    querySnapshot.docs.forEach((doc) {
      final itemImage = doc['image'];
      final itemId = doc['id'];
      final itemGrouping = doc['group'];

      if (querySnapshot.docs.isNotEmpty) {
        if (!lists.containsKey(itemGrouping)) {
          lists[itemGrouping] = [];
        }
        lists[itemGrouping]?.add(itemImage);
        lists[itemGrouping]?.add(itemId);
      }
    });

    return lists;
  }
  Future<void> getDirections() async {
    try {

      CollectionReference innerCollectionRef2 = FirebaseFirestore.instance.collection('Food_Group');

      QuerySnapshot querySnapshot2 = await innerCollectionRef2.get();

      if (querySnapshot2.docs.isNotEmpty) {
        for (var document in querySnapshot2.docs) {
          String directions = document['directions'];
          String groupName = document['name'];
          int totalLimit = document['totalLimit'];
          int eachLimit = document['eachLimit'];
          setState(() {
            groupDirections.add(directions);
            groupNames.add(groupName);
            eachLimits.add(eachLimit);
            totalLimits.add(totalLimit);
          });

        }
      } else {
        print('No documents found in the collection');
      }
    } catch (e) {
      print('Error fetching information from Firestore: $e');
    }
  }
  /*
 Future<void> loadSnacks() async {
    try {
      DocumentReference outerDocumentRef = FirebaseFirestore.instance.collection('Food_Group').doc('snacks');

      // Get the reference to the inner collection within the parent document
      CollectionReference innerCollectionRef = outerDocumentRef.collection('Items');

      // Fetch all documents within the inner collection
      QuerySnapshot querySnapshot = await innerCollectionRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var document in querySnapshot.docs) {
          String itemImage = document['image'];
          String itemId = document['id'];
          setState(() {
            imageUrls.add(itemImage);
            itemIds.add(itemId);
          });
        }
      } else {
        print('No documents found in the collection');
      }
    } catch (e) {
      print('Error fetching information from Firestore: $e');
    }
  }
  Future<void> loadBreakfast() async {
    try {
      DocumentReference outerDocumentRef = FirebaseFirestore.instance.collection('Food_Group').doc('breakfast');

      // Get the reference to the inner collection within the parent document
      CollectionReference innerCollectionRef = outerDocumentRef.collection('Items');

      // Fetch all documents within the inner collection
      QuerySnapshot querySnapshot2 = await innerCollectionRef.get();

      if (querySnapshot2.docs.isNotEmpty) {
        for (var document2 in querySnapshot2.docs) {
          String itemImage2 = document2['image'];
          String itemId2 = document2['id'];
          setState(() {
            imageUrls2.add(itemImage2);
            itemIds2.add(itemId2);
          });
        }
      } else {
        print('No documents found in the collection');
      }
    } catch (e) {
      print('Error fetching information from Firestore: $e');
    }
  }
  Future<void> loadMeals() async {
    try {
      DocumentReference outerDocumentRef = FirebaseFirestore.instance.collection('Food_Group').doc('meals');

      // Get the reference to the inner collection within the parent document
      CollectionReference innerCollectionRef = outerDocumentRef.collection('Items');

      // Fetch all documents within the inner collection
      QuerySnapshot querySnapshot3 = await innerCollectionRef.get();

      if (querySnapshot3.docs.isNotEmpty) {
        for (var document3 in querySnapshot3.docs) {
          String itemImage3 = document3['image'];
          String itemId3 = document3['id'];
          setState(() {
            imageUrls3.add(itemImage3);
            itemIds3.add(itemId3);
          });
        }
      } else {
        print('No documents found in the collection');
      }
    } catch (e) {
      print('Error fetching information from Firestore: $e');
    }
  }
  Future<void> loadDrinks() async {
    try {
      DocumentReference outerDocumentRef = FirebaseFirestore.instance.collection('Food_Group').doc('drinks');

      // Get the reference to the inner collection within the parent document
      CollectionReference innerCollectionRef = outerDocumentRef.collection('Items');

      // Fetch all documents within the inner collection
      QuerySnapshot querySnapshot4 = await innerCollectionRef.get();

      if (querySnapshot4.docs.isNotEmpty) {
        for (var document4 in querySnapshot4.docs) {
          String itemImage4 = document4['image'];
          String itemId4 = document4['id'];
          setState(() {
            imageUrls4.add(itemImage4);
            itemIds4.add(itemId4);
          });
        }
      } else {
        print('No documents found in the collection');
      }
    } catch (e) {
      print('Error fetching information from Firestore: $e');
    }
  }
  */

  Widget itemCard(int index) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPopupOpen = true;
            _itemNameOrder = itemIds[index];
          });
          _showPopupDialog(context);
        },
        child: RepaintBoundary(
          child: Hero(
            tag: itemIds[index],
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imageUrls[index],
                    alignment: Alignment.bottomCenter,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.add_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // alignment: Alignment.bottomCenter,
                      constraints: BoxConstraints.expand(
                        height: Spacing.matGridUnit(scale: 5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      padding: EdgeInsets.all(
                        Spacing.matGridUnit(scale: .5),
                      ),
                      child: Center(
                        child: Text(itemIds[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget itemCard2(int index2) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPopupOpen = true;
            _itemNameOrder = itemIds2[index2];
          });
          _showPopupDialog(context);
        },
        child: RepaintBoundary(
          child: Hero(
            tag: itemIds2[index2],
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imageUrls2[index2],
                    alignment: Alignment.bottomCenter,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.add_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // alignment: Alignment.bottomCenter,
                      constraints: BoxConstraints.expand(
                        height: Spacing.matGridUnit(scale: 5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      padding: EdgeInsets.all(
                        Spacing.matGridUnit(scale: .5),
                      ),
                      child: Center(
                        child: Text(itemIds2[index2]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget itemCard3(int index3) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPopupOpen = true;
            _itemNameOrder = itemIds3[index3];
          });
          _showPopupDialog(context);
        },
        child: RepaintBoundary(
          child: Hero(
            tag: itemIds3[index3],
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imageUrls3[index3],
                    alignment: Alignment.bottomCenter,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.add_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // alignment: Alignment.bottomCenter,
                      constraints: BoxConstraints.expand(
                        height: Spacing.matGridUnit(scale: 5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      padding: EdgeInsets.all(
                        Spacing.matGridUnit(scale: .5),
                      ),
                      child: Center(
                        child: Text(itemIds3[index3]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget itemCard4(int index4) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPopupOpen = true;
            _itemNameOrder = itemIds4[index4];
          });
          _showPopupDialog(context);
        },
        child: RepaintBoundary(
          child: Hero(
            tag: itemIds4[index4],
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imageUrls4[index4],
                    alignment: Alignment.bottomCenter,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.add_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // alignment: Alignment.bottomCenter,
                      constraints: BoxConstraints.expand(
                        height: Spacing.matGridUnit(scale: 5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      padding: EdgeInsets.all(
                        Spacing.matGridUnit(scale: .5),
                      ),
                      child: Center(
                        child: Text(itemIds4[index4]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PopupContent extends StatefulWidget {
  final String itemNameOrder; // Add this line

  PopupContent({required this.itemNameOrder}); // Add this constructor

  @override
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  @override
  bool isIconActive = true;
  bool isIconActive2 = true;

  int _quantity = 1;

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
                fontWeight: FontWeight.bold,
                fontSize: 30,
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
                    icon: Icon(Icons.remove_circle),
                    color: isIconActive2 ? Colors.green : Colors.grey,
                    onPressed: () {
                      if (_quantity >= 1) {
                        setState(() {
                          _quantity--;
                          isIconActive2 = true;
                          isIconActive = true; // Set the icon as active
                        });
                      } else {
                        setState(() {
                          isIconActive2 = false;
                        });
                      }
                      if (_quantity <= 0) {
                        isIconActive2 = false;
                      }
                    }),
                Text(
                  _quantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                IconButton(
                  iconSize: 40.0,
                  icon: Icon(Icons.add_circle),
                  color: isIconActive ? Colors.green : Colors.grey,
                  onPressed: () {
                    if (_quantity <= 1) {
                      setState(() {
                        _quantity++;
                        isIconActive2 = true;
                        isIconActive = true; // Set the icon as active
                      });
                    } else {
                      setState(() {
                        isIconActive = false;
                      });
                    }
                    if (_quantity >= 2) {
                      isIconActive = false;
                    }
                  },
                )
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shadowColor: Colors.transparent,
                elevation: 0.0,
              ).copyWith(elevation: MaterialStateProperty.all<double>(0.0)),
              child: Text(
                "Add To Cart".toUpperCase(),
              ),
              onPressed: () async {
                if (_quantity > 0) {
                  // Generate a unique ID for the new order
                  String orderId = FirebaseFirestore.instance.collection('Orders').doc().id;

                  // Create a reference to the new order collection
                  CollectionReference orderCollection =
                  FirebaseFirestore.instance.collection('Orders');

                  // Prepare the data to save
                  Map<String, dynamic> dataToSave = {
                    'item name': widget.itemNameOrder,
                    'quantity': _quantity,
                  };

                  try {
                    // Save the data to the new order collection
                    await orderCollection.add(dataToSave);

                    // Display a success message
                    const snackBar = SnackBar(
                      content: Text(
                        'Item added to cart',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // Close the dialog and pass the order ID back to the main screen
                    Navigator.of(context).pop(orderId);
                  } catch (e) {
                    // Display an error message if there was an issue saving the data
                    const snackBar = SnackBar(
                      content: Text(
                        'Error adding item to cart',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  const snackBar = SnackBar(
                    content: Text(
                      'Add more items',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              })
        ],
      ),
    );
  }
}






