// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StreamView extends StatefulWidget {
  const StreamView({Key? key}) : super(key: key);

  @override
  _StreamViewState createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {
  WebSocketChannel? channel;
  final refdata = FirebaseDatabase.instance.ref();
  late String IP;
  @override
  void initState() {
    super.initState();
    refdata.child('IP/').onValue.listen((event) {
      IP = event.snapshot.value.toString();
      channel = IOWebSocketChannel.connect('ws://${IP}:81');
      print(IP);
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (channel == null) {
    //   // return a placeholder or loading indicator until channel is initialized
    //   return CircularProgressIndicator();
    // }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 206, 189),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(
                  //   // height: 100,
                  //   width: 1,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo,
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.indigo,
                      size: 28,
                    ),
                  )
                ],
              ),
              Center(
                child: Image.asset(
                  "assets/banner.png",
                  scale: 1.5,
                ),
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 400,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: channel != null
                              ? StreamBuilder(
                                  stream: channel?.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: SizedBox(
                                          height: 200,
                                          width: 250,
                                          child: Text(
                                            'Error: ${snapshot.error}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Image.memory(
                                        snapshot.data,
                                        gaplessPlayback: true,
                                        width: 260,
                                        height: 280,
                                      );
                                    }
                                  },
                                )
                              : Text("Loading...")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle capture image
                            },
                            child: const Text('Capture Image'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle reconnect
                            },
                            child: const Text('Reconnect'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
