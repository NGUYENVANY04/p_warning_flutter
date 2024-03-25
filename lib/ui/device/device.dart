import 'package:flutter/material.dart';
import 'package:p_warning_flutter/ui/device/temperature.dart';

class Device extends StatefulWidget {
  const Device({super.key});

  @override
  State<Device> createState() => _StreamCamState();
}

class _StreamCamState extends State<Device> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HI THERE",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      size: 28,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/banner.png",
                        scale: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Center(
                      child: Text(
                        "Smart Home",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: _cardMenu(
                              title: "ENERGY", icon: "assets/energy.png"),
                        ),
                        const SizedBox(
                            width: 16), // Khoảng cách giữa các ô vuông
                        Flexible(
                          flex: 1,
                          child: _cardMenu(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TemperaturePage()));
                            },
                            title: "TEMPERATURE",
                            icon: "assets/temperature.png",
                            fontColor: Colors.white,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: _cardMenu(
                              title: "WATER", icon: "assets/water.png"),
                        ),
                        const SizedBox(
                            width: 16), // Khoảng cách giữa các ô vuông
                        Flexible(
                          flex: 1,
                          child: _cardMenu(
                              title: "ENTERTAINMENT",
                              icon: "assets/entertainment.png"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 36,
        ),
        width: 156,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.asset(icon),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }
}
