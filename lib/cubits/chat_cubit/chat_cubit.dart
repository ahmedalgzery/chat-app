import 'package:chat/constatns.dart';
import 'package:chat/cubits/chat_cubit/chat_state.dart';
import 'package:chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);
  List<Message> messagesList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessage({required String message, required var email}) {
    messages.add(
      {kMessage: message, kCreatedAt: DateTime.now(), 'id': email},
    );
    getMessage();
  }

  void getMessage() {
    messages
        .orderBy(kCreatedAt, descending: true)
        .snapshots()
        .listen((event) async {
      if (await messages
          .orderBy(kCreatedAt, descending: true)
          .snapshots()
          .isEmpty) {
      } else {
        messagesList = [];
        for (var doc in event.docs) {
          messagesList.add(Message.fromJson(doc));
        }
      }
      emit(ChatSuccess());
    });
  }
}
