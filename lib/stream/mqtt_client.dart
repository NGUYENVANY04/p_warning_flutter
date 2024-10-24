import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Mqtt_client extends StatefulWidget {
  const Mqtt_client({super.key});

  @override
  State<Mqtt_client> createState() => _Mqtt_clientState();
}

class _Mqtt_clientState extends State<Mqtt_client> {
  Future<MqttClient> connect() async {
    MqttServerClient client =
        MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    // Security context
//  SecurityContext context = new SecurityContext()
//    ..useCertificateChain('path/to/my_cert.pem')
//    ..usePrivateKey('path/to/my_key.pem', password: 'my_key_password')
//    ..setClientAuthorities('path/to/client.crt', password: 'password');
//  client.secure = true;
//  client.securityContext = context;

    final connMess = MqttConnectMessage()
        .authenticateAs("username", "password")
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    try {
      print('Connecting');
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
    print("connected");

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMessage = c![0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}');
    });

    return client;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Connected callback
void onConnected() {
  print('Connected');
}

// Disconnected callback
void onDisconnected() {
  print('Disconnected');
}

// Subscribed callback
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// Subscribed failed callback
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// Unsubscribed callback
void onUnsubscribed(String? topic) {
  print('Unsubscribed topic: $topic');
}

// Ping callback
void pong() {
  print('Ping response client callback invoked');
}
