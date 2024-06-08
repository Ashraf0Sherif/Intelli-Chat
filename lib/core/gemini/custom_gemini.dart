import 'package:google_generative_ai/google_generative_ai.dart';

import '../../constants.dart';

class CustomGemini {
  Future<String?> textGeneration({required String prompt}) async {
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: kApiKey!);
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text;
  }
}
