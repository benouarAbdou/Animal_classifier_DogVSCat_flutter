import 'package:camera/camera.dart';
import 'package:emotions/dogCatWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:percent_indicator/percent_indicator.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      title: 'Cat vs Dog',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  double dogPercent = 0.0;
  double catPercent = 0.0;
  int currentCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    loadCamera(currentCameraIndex);
    loadModel();
  }

  loadCamera(int cameraIndex) {
    cameraController =
        CameraController(cameras![cameraIndex], ResolutionPreset.high);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((image) {
            cameraImage = image;
            runModel();
          });
        });
      }
    });
  }

  switchCamera() {
    setState(() {
      if (currentCameraIndex == 1) {
        currentCameraIndex = 0;
      } else {
        currentCameraIndex = 1;
      }
      loadCamera(currentCameraIndex);
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((e) {
            return e.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      for (var element in predictions!) {
        if (element['label'] == 'Dog') {
          setState(() {
            dogPercent = element['confidence'];
            catPercent = 1 - dogPercent;
          });
        } else if (element['label'] == 'Cat') {
          setState(() {
            catPercent = element['confidence'];
            dogPercent = 1 - catPercent;
          });
        }
      }
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      "For best results, use photos clearly showing cats or dogs, as other images may give random results.",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                children: [
                  !cameraController!.value.isInitialized
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: CameraPreview(cameraController!),
                          ),
                        ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: switchCamera,
                      child: const Icon(Icons.switch_camera),
                    ),
                  ),
                ],
              ),
            ),
            CatDog(
              dogPercent: dogPercent,
              catPercent: catPercent,
            ),
          ],
        ),
      ),
    );
  }
}
