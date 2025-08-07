import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/consultation/0_model/chat_message_model.dart';
import 'package:flutter/widgets.dart';

class ChatMessageController with ChangeNotifier {
  late StreamSubscription chatSub;
  late StreamSubscription authStream;
  User? currentUser;
  UserModel? patient;
  final StreamController<String?> controller = StreamController();
  Stream<String?> get stream => controller.stream;
  String? chatroom;
  late String recipient;
  List<ChatMessageModel> messages = [];

  ChatMessageController() {
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
    UserModel.fromUid(uid: FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      recipient = currentRecipient;
      patient = value;
      if (patient != null && patient!.chatrooms.contains(room)) {
        subscribe();
      } else {
        controller.add("empty");
      }
      chatroom = room;
    });
  }

  Future<String?> initChatRoom(String room, String currentRecipient) {
    UserModel.fromUid(uid: FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      recipient = currentRecipient;
      patient = value;
      if (patient != null && patient!.chatrooms.contains(room)) {
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
    String currentPatientUid = FirebaseAuth.instance.currentUser!.uid;

    if (currentPatientUid.codeUnits[0] >= recipientUid.codeUnits[0]) {
      if (currentPatientUid.codeUnits[1] == recipientUid.codeUnits[1]) {
        return chatroom = recipientUid + currentPatientUid;
      }
      return chatroom = currentPatientUid + recipientUid;
    }
    return chatroom = recipientUid + currentPatientUid;
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

//---------------------------------Send First Message---------------------------------

  sendFirstMessage({
    required String message,
    required String recipient,
  }) async {
    final currentUserModel = await FirebaseFirestore.instance
        .collection('patients')
        .doc(currentUser!.uid)
        .get()
        .then((value) => UserModel.fromJson(value.data()!));

    final currentDoctorModel = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(recipient)
        .get()
        .then((value) => DoctorModel.fromJson(value.data()!));

    try {
      var newMessage = ChatMessageModel(
        authorUid: FirebaseAuth.instance.currentUser!.uid,
        message: message,
        authorName: currentUserModel.name,
        patientName: currentUserModel.name,
        patientUid: currentUserModel.uid,
        doctorName: currentDoctorModel.name,
        doctorUid: recipient,
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
                    .collection('patients')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'chatrooms': FieldValue.arrayUnion([chatroom])
                }).then(
                  (value) => {
                    FirebaseFirestore.instance
                        .collection('doctors')
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
        .collection('doctors')
        .doc(recipient)
        .get();
    String doctorName = docSnapshot.data()?['name'];

    return await FirebaseFirestore.instance
        .collection('consultation-chatrooms')
        .doc(chatroom)
        .collection('messages')
        .add(ChatMessageModel(
          authorUid: FirebaseAuth.instance.currentUser!.uid,
          authorName: patient!.name,
          patientName: patient!.name,
          patientUid: patient!.uid,
          doctorName: doctorName,
          doctorUid: recipient,
          message: message,
          createdAt: Timestamp.now(),
        ).json);
  }

//-------------------GET START AND END DATE AND TIME----------------------------
  Future<Timestamp?> getFirstMessageTime() async {
    debugPrint('Getting first message time for chatroom $chatroom');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('consultation-chatrooms')
        .doc(chatroom)
        .collection('messages')
        .orderBy('createdAt')
        .limit(1)
        .get();

    debugPrint('Got ${querySnapshot.docs.length} documents');

    if (querySnapshot.docs.isNotEmpty) {
      Timestamp? timestamp = querySnapshot.docs.first.data()['createdAt'];
      debugPrint('First message time: $timestamp');
      return timestamp;
    } else {
      debugPrint('No documents found');
      return null;
    }
  }

  Future<Timestamp?> getLastMessageTime() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('consultation-chatrooms')
        .doc(chatroom)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data()['createdAt'];
    } else {
      return null;
    }
  }
}
