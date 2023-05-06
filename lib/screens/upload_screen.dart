import 'package:defecto/screens/result_screen.dart';
import 'package:flutter/material.dart';

import '../constants/consts.dart';


class UploadScreen extends StatefulWidget {
  static const id = "upload_screen";
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Upload Your Product'),
      ),
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'I\'m ready ,\n\n Upload your Image ',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const Expanded(
              flex: 2,
                child: Image(
                  image: AssetImage('assets/images/defecto_upload.png'),
                )),
            Expanded(
              flex: 1,
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding:
                            const EdgeInsets.only(bottom: 15, left: 30, right: 30, top: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            'Upload',
                            style: TextStyle(fontSize: 20),
                          )),
                      const SizedBox(width: 40,),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ResultScreen.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding:
                            const EdgeInsets.only(bottom: 15, left: 30, right: 30, top: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            'Check',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
