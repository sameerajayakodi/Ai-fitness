import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodRecognitionPage extends StatefulWidget {
  const FoodRecognitionPage({Key? key}) : super(key: key);

  @override
  State<FoodRecognitionPage> createState() => _FoodRecognitionPageState();
}

class _FoodRecognitionPageState extends State<FoodRecognitionPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  String? _analysisResult;
  bool _isAnalyzing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recognition'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _selectedImage!.path,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text('Take a photo of your food'),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile =
                      await _imagePicker.pickImage(source: ImageSource.camera);
                  setState(() {
                    _selectedImage = pickedFile;
                    _analysisResult = null;
                  });
                },
                icon: Icon(Icons.camera),
                label: Text('Take Photo'),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile =
                      await _imagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _selectedImage = pickedFile;
                    _analysisResult = null;
                  });
                },
                icon: Icon(Icons.photo_library),
                label: Text('Pick from Gallery'),
              ),
              if (_selectedImage != null) ...[
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _isAnalyzing
                      ? null
                      : () async {
                          setState(() {
                            _isAnalyzing = true;
                          });
                          // TODO: Call Gemini API to analyze food
                          // For now, show a mock response
                          await Future.delayed(Duration(seconds: 2));
                          setState(() {
                            _analysisResult =
                                'Food: Grilled Chicken Salad\nCalories: 350\nProtein: 35g\nCarbs: 20g\nFat: 12g';
                            _isAnalyzing = false;
                          });
                        },
                  icon: _isAnalyzing
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(Icons.analytics),
                  label: Text(_isAnalyzing ? 'Analyzing...' : 'Analyze'),
                ),
              ],
              if (_analysisResult != null) ...[
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nutritional Information',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 12),
                      Text(_analysisResult!),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Log this nutrition entry
                        },
                        child: Text('Log This Meal'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
