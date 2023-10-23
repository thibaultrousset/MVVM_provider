import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tech_digital_paca/res/color.dart';
import 'package:test_tech_digital_paca/utils/routes/routes_name.dart';
import 'package:test_tech_digital_paca/view_model/user_view_model.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Drawer(
      backgroundColor: AppColors.lightBlue,
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: AppColors.lightBlue,
          ),
          child: Row(children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Image(
                image: AssetImage(
                    'images/DigitalPACA-Logo_Round_poulpe-en-haut.png'),
                height: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Menu',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
        ),
        ListTile(
          leading: const Image(
            image: AssetImage('images/home.png'),
            height: 20,
          ),
          title: const Text('Home',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Image(
            image: AssetImage('images/deconnexion.png'),
            height: 20,
          ),
          title: const Text('Déconnexion',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onTap: () {
            userPrefernece.remove().then((value) {
              Navigator.popAndPushNamed(context, RoutesName.login);
            });
          },
        )
      ]),
    );
  }
}
