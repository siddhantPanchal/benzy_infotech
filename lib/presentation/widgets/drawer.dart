import 'package:flutter/material.dart';

import '../../model/food_delivery.dart';

class IDrawer extends StatelessWidget {
  const IDrawer({
    Key? key,
    required FoodDelivery? foodDelivery,
  })  : _foodDelivery = foodDelivery,
        super(key: key);

  final FoodDelivery? _foodDelivery;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text('${_foodDelivery?.user.email}'),
            accountName: Text('${_foodDelivery?.user.fName}'),
            currentAccountPicture: Image.network(
              '${_foodDelivery?.user.image}',
              errorBuilder: (context, error, stackTrace) {
                return Container();
              },
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: const [0.8, 0.2],
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).backgroundColor,
                ],
              ),
            ),
            arrowColor: Colors.black,
            // onDetailsPressed: () {},
          ),
          ListTile(
            style: ListTileStyle.drawer,
            leading: const Icon(Icons.phone_android_rounded),
            title: Text('${_foodDelivery?.user.phone}'),
          ),
          ListTile(
            style: ListTileStyle.drawer,
            leading: const Icon(Icons.person),
            title: Text('${_foodDelivery?.user.empId}'),
          ),
        ],
      ),
    );
  }
}
