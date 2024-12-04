import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolens/bloc/upload/upload_bloc.dart';
import '../bloc/upload/upload_event.dart';
import '../bloc/upload/upload_state.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => UploadBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<UploadBloc, UploadState>(
          listener: (context, state) {
          if (state is PredictionResult) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.result)));
          }
        }, builder: (context, state) {
          final uploadBloc = BlocProvider.of<UploadBloc>(context);
          if (state is UploadInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenWidth * 0.1,
                  ),
                  Text(
                    'Upload an image to get started',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: screenWidth * 0.05,
                  ),
                  GestureDetector(
                    onTap: () => uploadBloc.add(PickImageEvent()),
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Pick Image',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ImagePicked) {
            final displayImage = MemoryImage(state.convertedImage);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(displayImage.bytes),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context)
                          .add(RetakeImageEvent());
                    },
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Re Take',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context)
                          .add(PredictImageEvent(state.image));
                    },
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is PredictionResult) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Prediction Result:',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: screenWidth * 0.05,
                  ),
                  Text(
                    state.result,
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            );
          } else if (state is PredictionLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Predicting...')],
              ),
            );
          } else {
            return const Center();
          }
        }),
      ),
    );
  }
}
