import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:face_camera/face_camera.dart';


void main() async{
 // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  final firstcamera = cameras.first;
  runApp(CameraApp(camera: firstcamera,));
}


class CameraApp extends StatelessWidget {
   final CameraDescription camera;
   const CameraApp({Key? key, required this.camera}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: mainScreen(camera: camera,),
    );
  }
}




class mainScreen extends StatefulWidget {
  const mainScreen({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  //late FaceCameraController controller;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Face Detection App"),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(100)),
            ),
          ),
          body: FutureBuilder(future: _initializeControllerFuture, builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.done)
              return CameraPreview(_controller);
            else
              return const Center(child: CircularProgressIndicator(),);
          })
        ),
    );
  }
}
//Center(
//             child: Column(
//               children: [
//
//                 Expanded(
//                   flex: 4,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Colors.redAccent),
//
//                   ),
//                 ),
//                 Expanded(flex: 1,
//                     child: Container(color: Colors.blueAccent,))
//               ],
//             ),
//           ),