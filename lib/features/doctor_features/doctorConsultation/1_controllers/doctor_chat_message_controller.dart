import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/consultation/0_model/chat_message_model.dart';
import 'package:flutter/material.dart';

class DoctorChatMessageController with ChangeNotifier {
  late StreamSubscription chatSub;
  late StreamSubscription authStream;
  User? currentUser;
  DoctorModel? doctor;
  final StreamController<String?> controller = StreamController();
  Stream<String?> get stream => controller.stream;
  String? chatroom;
  late String recipient;
  List<ChatMessageModel> messages = [];

  DoctorChatMessageController() {
    chatSub = const Stream.empty().listen((_) {});
    if (chatroom != null) {
      subscribe();
    } else {
      controller.add("empty");
    }

    authStream = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    chatSub.cancel();
    super.dispose();
  }

  subscribe() {
    chatSub = ChatMessageModel.individualCurrentChats(chatroom!)
        .listen(chatUpdateHandler);
    controller.add("success");
  }

  getChatRoom(String room, String currentRecipient) {
    DoctorModel.fromUid(uid: FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      recipient = currentRecipient;
      doctor = value;
      if (doctor != null && doctor!.chatrooms.contains(room)) {
        subscribe();
      } else {
        controller.add("empty");
      }
      chatroom = room;
    });
  }

  Future<String?> initChatRoom(String room, String currentRecipient) {
    DoctorModel.fromUid(uid: FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      recipient = currentRecipient;
      doctor = value;
      if (doctor != null && doctor!.chatrooms.contains(room)) {
        subscribe();
      } else {
        controller.add("empty");
      }

      chatroom = room;
      return chatroom;
    });
    return Future.value(chatroom);
  }

  generateRoomId(String recipientUid) {
    String currentDoctorUid = FirebaseAuth.instance.currentUser!.uid;

    if (currentDoctorUid.codeUnits[0] >= recipientUid.codeUnits[0]) {
      if (currentDoctorUid.codeUnits[1] == recipientUid.codeUnits[1]) {
        return chatroom = recipientUid + currentDoctorUid;
      }
      return chatroom = currentDoctorUid + recipientUid;
    }
    return chatroom = recipientUid + currentDoctorUid;
  }

  chatUpdateHandler(List<ChatMessageModel> update) {
    for (ChatMessageModel message in update) {
      if (chatroom == generateRoomId(recipient) &&
          message.hasNotSeenMessage(FirebaseAuth.instance.currentUser!.uid)) {
        message.individualUpdateSeen(
            FirebaseAuth.instance.currentUser!.uid, chatroom!);
      } else {}
    }

    messages = update;
    notifyListeners();
  }

  //-------------------------------Send First Message------------------------------------
  sendFirstMessage({
    required String message,
    required String recipient,
  }) async {
    final currentUserModel = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(currentUser!.uid)
        .get()
        .then((value) => DoctorModel.fromJson(value.data()!));

    final currentPatientModel = await FirebaseFirestore.instance
        .collection('patients')
        .doc(recipient)
        .get()
        .then((value) => UserModel.fromJson(value.data()!));

    try {
      var newMessage = ChatMessageModel(
        authorUid: FirebaseAuth.instance.currentUser!.uid,
        message: message,
        authorImage: '',
        authorName: currentUserModel.name,
        doctorName: currentUserModel.name,
        doctorUid: currentUserModel.uid,
        patientName: currentPatientModel.name,
        patientUid: recipient,
        createdAt: Timestamp.now(),
      ).json;

      var thisUser = FirebaseAuth.instance.currentUser!.uid;
      String chatroom = generateRoomId(recipient);

      firstMessageText(chatroom, recipient, thisUser, newMessage);
      debugPrint('First message sent');
    } catch (e) {
      debugPrint('Error sending first message: $e');
    }
  }

  Future<void> firstMessageText(String chatroom, String recipient,
      String thisUser, Map<String, dynamic> newMessage) async {
    await FirebaseFirestore.instance
        .collection('consultation-chatrooms')
        .doc(chatroom)
        .set({
      'chatroom': chatroom,
      'members': FieldValue.arrayUnion([recipient, thisUser])
    }).then(
      (snap) => {
        FirebaseFirestore.instance
            .collection('consultation-chatrooms')
            .doc(chatroom)
            .collection('messages')
            .add(newMessage)
            .then(
              (value) => {
                FirebaseFirestore.instance
                    .collection('doctors')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'chatrooms': FieldValue.arrayUnion([chatroom])
                }).then(
                  (value) => {
                    FirebaseFirestore.instance
                        .collection('patients')
                        .doc(recipient)
                        .update(
                      {
                        'chatrooms': FieldValue.arrayUnion([chatroom])
                      },
                    ),
                    subscribe(),
                  },
                ),
              },
            ),
      },
    );
  }

  //---------------------------------Send Message---------------------------------
  Future sendMessage({
    String message = '',
    required String recipient,
  }) async {
    var thisUser = FirebaseAuth.instance.currentUser!.uid;
    return await sendMessageText(recipient, message, thisUser);
  }

  Future<DocumentReference<Map<String, dynamic>>> sendMessageText(
      String recipient, String message, String thisUser) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore
        .instance
        .collection('patients')
        .doc(recipient)
        .get();
    String patientName = docSnapshot.data()?['name'];

    return await FirebaseFirestore.instance
        .collection('consultation-chatrooms')
        .doc(chatroom)
        .collection('messages')
        .add(ChatMessageModel(
          authorUid: FirebaseAuth.instance.currentUser!.uid,
          authorImage: '',
          authorName: doctor!.name,
          patientName: patientName,
          patientUid: recipient,
          doctorName: doctor!.name,
          doctorUid: doctor!.uid,
          message: message,
          createdAt: Timestamp.now(),
        ).json);
  }
}
