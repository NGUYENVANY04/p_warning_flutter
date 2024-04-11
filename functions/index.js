const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.helloWolrd = functions.database.ref("/isNoti")
    .on(async (change, context) => {
      try {
        const dataState = change.after.val(); // Giá trị sau khi thay đổi
        if (dataState == true) {
          console.log("New data:", dataState);

          // Lấy token từ cơ sở dữ liệu Firebase Realtime Database
          const snapshot = await admin.database()
              .ref("/fcm-token/token").once("value");
          const tokens = snapshot.val();
          console.log("Tokens:", tokens);

          // Tạo payload cho thông báo
          const payload = {
            notification: {
              title: "Cảnh Báo",
              body: "Có người đột nhập ",
              badge: "1",
              sound: "default",
            },
          };

          // Gửi thông báo đến tất cả các token
          const response = await admin.messaging()
              .sendToDevice(tokens, payload);
          console.log("Notification sent successfully:", response);
        }
      } catch (error) {
        console.error("Error sending notification:", error);
      }
    });
