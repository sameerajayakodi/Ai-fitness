import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_fitness/core/constants/app_constants.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';
import 'dart:convert';

abstract class GeminiService {
  Future<String> sendChatMessage(String message, String language);
  Future<String> analyzeFoodImage(String base64Image);
  Future<List<String>> generateMealPlan(String dietaryPreferences, int calorieTarget);
}

class GeminiServiceImpl implements GeminiService {
  final String apiKey;
  late final GenerativeModel _geminiProModel;
  late final GenerativeModel _geminiProVisionModel;

  GeminiServiceImpl({required this.apiKey}) {
    _geminiProModel = GenerativeModel(
      model: AppConstants.geminiProModel,
      apiKey: apiKey,
    );

    _geminiProVisionModel = GenerativeModel(
      model: AppConstants.geminiProVisionModel,
      apiKey: apiKey,
    );
  }

  @override
  Future<String> sendChatMessage(String message, String language) async {
    try {
      final languagePrompt = language == 'sinhala'
          ? 'You are a helpful fitness coach. Respond in Sinhala language only.'
          : 'You are a helpful fitness coach. Respond in English language only.';

      final prompt =
          '$languagePrompt\n\nUser message: $message\n\nProvide helpful, motivational fitness advice.';

      final response = await _geminiProModel.generateContent([
        Content.text(prompt),
      ]);

      final text = response.text ?? 'Sorry, I could not generate a response.';
      AppLogger.info('Chatbot response generated successfully');
      return text;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate chat response', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> analyzeFoodImage(String base64Image) async {
    try {
      final imageParts = [
        DataPart('image/jpeg', base64Decode(base64Image)),
      ];

      const prompt = '''Analyze this food image and provide:
1. Food name
2. Estimated calories
3. Estimated protein (g)
4. Estimated carbs (g)
5. Estimated fat (g)
6. Key nutritional benefits
7. Health tips

Format the response clearly with labels for each item.''';

      final response = await _geminiProVisionModel.generateContent([
        Content.multi([
          TextPart(prompt),
          ...imageParts.map((part) => part as Part),
        ]),
      ]);

      final analysis = response.text ?? 'Could not analyze image';
      AppLogger.info('Food image analyzed successfully');
      return analysis;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to analyze food image', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<String>> generateMealPlan(
    String dietaryPreferences,
    int calorieTarget,
  ) async {
    try {
      final prompt = '''Generate a personalized meal plan with the following requirements:
- Dietary preferences: $dietaryPreferences
- Target daily calories: $calorieTarget
- Include 4 meals: Breakfast, Lunch, Dinner, Snack
- Each meal should have estimated calories and key ingredients

Format each meal like this:
MEAL: [name]
CALORIES: [number]
INGREDIENTS: [list]

Keep the total calories close to $calorieTarget.''';

      final response = await _geminiProModel.generateContent([
        Content.text(prompt),
      ]);

      final mealPlanText = response.text ?? '';
      final meals = _parseMealPlan(mealPlanText);

      AppLogger.info('Meal plan generated successfully');
      return meals;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate meal plan', e, stackTrace);
      rethrow;
    }
  }

  List<String> _parseMealPlan(String response) {
    final meals = <String>[];
    final mealBlocks = response.split('MEAL:').skip(1);

    for (var block in mealBlocks) {
      final lines = block.split('\n').where((line) => line.isNotEmpty).toList();
      if (lines.isNotEmpty) {
        meals.add('MEAL:${block.split('CALORIES:').first.trim()}');
      }
    }

    return meals.isNotEmpty ? meals : ['Unable to parse meal plan'];
  }
}
