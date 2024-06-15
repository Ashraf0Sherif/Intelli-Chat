import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class CustomGemini {
  Future<String?> textGeneration(
      {required User firebaseUser,
      required String topicID,
      required ChatMessage chatMessage,
      required List<Content> chatHistory}) async {
    final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyBfMT47JgV2jm2ePsV-b1bac74sI7lkZwc',
        safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.low),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.low),
        ]);
    Iterable<Part> parts = [TextPart(chatMessage.text)];
    if (chatMessage.medias != null) {
      File imageFile = File(chatMessage.medias!.first.url);
      final imageBytes = await imageFile.readAsBytes();
      final imageParts = DataPart('image/jpeg', imageBytes);
      parts = [...parts, imageParts];
    }
    final Content content = Content.multi(parts);
    final chat = model.startChat(history: chatHistory);
    final response = await chat.sendMessage(content);
    return response.text;
  }
}
