// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p_warning_flutter/stream/streamesp32.dart';
import 'package:p_warning_flutter/ui/device/device.dart';
import 'package:p_warning_flutter/ui/weather/widget_temp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final refdata = FirebaseDatabase.instance.ref();
  late String? token;
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((value) {
      setState(() {
        token = value;
      });
      print("Firebase Messaging Token: $token");
      refdata.child('fcm-token/').update(
        {
          "token": token,
        },
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 14, 27, 98),
              const Color.fromARGB(255, 1, 16, 23).withOpacity(0.2)
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(31, 185, 148, 148),
            blurRadius: 0.0,
          ),
        ],
        // ignore: unnecessary_const
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      // ignore: sort_child_properties_last
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 18, left: 10, right: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RotatedBox(
                    quarterTurns: 135,
                    child: IconButton(
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              value.visible
                                  ? Icons.clear
                                  : Icons.bar_chart_rounded,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Text(
                    "Smart Warning",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 41, 99),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                color: const Color.fromARGB(255, 154, 146, 207),
                height: 130,
                child: const Center(
                  child: InfoWidgetTemp(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  "assets/banner.png",
                  scale: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: ListTileTheme(
            textColor: const Color.fromARGB(255, 15, 14, 14),
            iconColor: const Color.fromARGB(255, 196, 68, 68),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 400.0, // Điều chỉnh kích thước chiều rộng theo ý muốn
                  height: 200.0, // Điều chỉnh kích thước chiều cao theo ý muốn
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 50.0,
                    left: 24,
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/smarthome.jpg"), // Đường dẫn đến tệp ảnh asset của bạn
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Divider(), // Thêm Divider giữa các ListTile

                ListTile(
                  leading: const Icon(
                    Icons.store_mall_directory_outlined,
                    weight: 20,
                  ),
                  iconColor: const Color.fromARGB(255, 90, 75, 74),
                  // subtitle: const Text('Dashboard'),
                  title: const Text(
                    'Stream Camera from Esp32 Cam',
                    style: TextStyle(
                        color: Color.fromARGB(255, 27, 8, 7),
                        fontStyle: FontStyle.normal,
                        fontSize: 15),
                  ),

                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StreamView(),
                      )),
                ),
                const Divider(), // Thêm Divider giữa các ListTile
                ListTile(
                  leading: const Icon(
                    Icons.devices_other_rounded,
                    weight: 20,
                  ),
                  iconColor: const Color.fromARGB(255, 90, 75, 74),
                  // subtitle: const Text('Dashboard'),
                  title: const Text(
                    'Device at Home',
                    style: TextStyle(
                        color: Color.fromARGB(255, 27, 8, 7),
                        fontStyle: FontStyle.normal,
                        fontSize: 15),
                  ),

                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Device(),
                      )),
                ),
                const Divider(), // Thêm Divider giữa các ListTile

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

void handleNotifi() {}
