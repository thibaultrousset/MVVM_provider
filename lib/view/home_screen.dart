import 'package:flutter/material.dart';
import 'package:test_tech_digital_paca/network/network_api_service.dart';
import 'package:test_tech_digital_paca/res/color.dart';
import 'package:test_tech_digital_paca/utils/routes/routes_name.dart';
import 'package:test_tech_digital_paca/view/tv_show_details.dart';
import 'package:test_tech_digital_paca/view_model/tv_show_list_view_model.dart';
import 'package:test_tech_digital_paca/view_model/tv_show_view_model.dart';
import 'package:test_tech_digital_paca/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TVShowListViewModel tvShowListViewModel = TVShowListViewModel();

  @override
  void initState() {
    super.initState();
  }

  onSelected(BuildContext context, TVShowViewModel tvShow) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TVShowDetails(tvShow: tvShow)));
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      drawer: Drawer(
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
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Deconnexion'),
            onTap: () {
              userPrefernece.remove().then((value) {
                Navigator.popAndPushNamed(context, RoutesName.login);
              });
            },
          )
        ]),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: ChangeNotifierProvider<TVShowListViewModel>(
        create: (BuildContext context) => tvShowListViewModel,
        child: Consumer<TVShowListViewModel>(builder: (context, value, _) {
          switch (value.loadingStatus) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return const Center(child: Text("No results"));
            case Status.completed:
              return ListView.builder(
                  itemCount: value.tvShowsVM.length,
                  itemBuilder: (context, index) {
                    final tvShow = value.tvShowsVM[index];

                    return GestureDetector(
                      onTap: () {
                        onSelected(context, tvShow);
                      },
                      child: Container(
                        width: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              child: SizedBox.fromSize(
                                child: Image.network(
                                  tvShow.thumbUrl.toString(),
                                  errorBuilder: (context, error, stack) {
                                    return const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    );
                                  },
                                  fit: BoxFit.fitHeight,
                                  width: 90,
                                  height: 140,
                                ),
                              ),
                            ),
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width - 140,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tvShow.title.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(tvShow.year.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Text(tvShow.description.toString(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
          }
        }),
      ),
    );
  }
}
