// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StreamView extends StatefulWidget {
  const StreamView({Key? key}) : super(key: key);

  @override
  _StreamViewState createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.1.11:81');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 206, 189),
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(31, 88, 11, 15),
      //   title: const Text(
      //     "Stream Camera From ESP32",
      //     style: TextStyle(fontSize: 20),
      //   ),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Image.asset(
              "assets/banner.png",
              scale: 1.2,
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
                    child: StreamBuilder(
                      stream: channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: SizedBox(
                              height: 200,
                              width: 250,
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(fontSize: 15),
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
                            width: 280,
                            height: 280,
                          );
                        }
                      },
                    ),
                  ),
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
    );
  }
}