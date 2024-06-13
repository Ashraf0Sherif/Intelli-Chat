import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class CustomGemini {
  Future<String?> textGeneration(
      {required User firebaseUser,
      required String topicID,
      required String prompt,
      required List<Content> chatHistory}) async {
    final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyBfMT47JgV2jm2ePsV-b1bac74sI7lkZwc');
    final chat = model.startChat(history: chatHistory);
    final content = Content.text(prompt);
    final response = await chat.sendMessage(content);
    return response.text;
  }
}
