import 'package:flutter/material.dart';
import 'package:p_warning_flutter/service/dataTempApi.dart';
import 'package:p_warning_flutter/ui/weather/infocardtemp.dart';
import 'package:provider/provider.dart';

class InfoWidgetTemp extends StatelessWidget {
  const InfoWidgetTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Temperature>(builder: (context, view, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              child: infoCard(
                  colorInfo: Colors.white,
                  // context: context,
                  iconInfo: "assets/fan-1.png",
                  nameInfo: "Temprate Indoor",
                  contentInfo: view.roomTemp.toString()),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: infoCard(
                  colorInfo: Colors.white,
                  // context: context,
                  iconInfo: "assets/fan-1.png",
                  nameInfo: "Temprate Outdoor",
                  contentInfo: view.tempApi.toString()),
            )
          ],
        ),
      );
    });
  }
}
