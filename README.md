# Cat vs Dog Classifier App

## Overview

The Cat vs Dog Classifier App is a Flutter-based mobile application that uses machine learning to classify images as either cats or dogs in real-time. This app demonstrates the integration of TensorFlow Lite models with Flutter to perform on-device inference using the device's camera.

## Features

- **Real-time Classification**: Instantly classifies images from the camera feed
- **Percentage Display**: Shows the confidence level for both cat and dog classifications
- **Camera Controls**: Allows switching between front and rear cameras
- **Visual Feedback**: Uses progress bars to display classification results
- **User Guidance**: Provides tips for best results

## Technologies Used

- **Flutter**: UI framework for building natively compiled applications
- **Dart**: Programming language used with Flutter
- **TensorFlow Lite**: On-device machine learning framework
- **flutter_tflite**: Flutter plugin for using TensorFlow Lite models
- **camera**: Plugin for accessing the device's cameras
- **percent_indicator**: Library for displaying percentage indicators

## Project Structure

The project is structured as follows:

- `lib/`
  - `main.dart`: Entry point of the application, contains the main UI and logic
  - `dogCatWidget.dart`: Custom widget for displaying classification results
- `assets/`
  - `model_unquant.tflite`: TensorFlow Lite model for cat/dog classification
  - `labels.txt`: Labels file for the model

## Getting Started

To run this project locally:

1. Ensure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Ensure you have the TensorFlow Lite model and labels file in the `assets/` directory
5. Connect a device or start an emulator
6. Run `flutter run` to start the app

## Usage

1. **Launch the App**: Open the app on your device
2. **Allow Camera Access**: Grant the app permission to use your device's camera
3. **Point Camera**: Aim your camera at a cat or dog
4. **View Results**: The app will display the classification results in real-time
5. **Switch Camera**: Use the camera switch button to toggle between front and rear cameras

## Model Information

The app uses a pre-trained TensorFlow Lite model for cat and dog classification. The model file (`model_unquant.tflite`) and the corresponding labels file (`labels.txt`) should be placed in the `assets/` directory.

Note: The current implementation assumes a binary classification (cat vs dog). For best results, ensure the images clearly show either a cat or a dog.

## Contributing

Contributions to improve the Cat vs Dog Classifier App are welcome. Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).
