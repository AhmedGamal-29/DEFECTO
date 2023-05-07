import 'dart:convert';
import 'dart:io';
import 'package:defecto/modules/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/constants/consts.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class UploadScreen extends StatefulWidget {
  static const id = "upload_screen";
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? image;
  var resultController = TextEditingController();
  var detectedObjectController = TextEditingController();
  var classification;
  var message;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();
  var percentage = 0.0;
  var stage = 0;

  Future pickImage() async {
    print("i entered pick");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final image_temp = File(image.path);

    setState(() {
      this.image = image_temp;
    });
  }

  Future<String> uploadImage() async {
    const url = 'https://fbd2-197-39-14-185.eu.ngrok.io/predict';


    final request = http.MultipartRequest('POST', Uri.parse(url));
    final headers = {"Content-Type": "multipart/form-data"};

    final file = await http.MultipartFile.fromPath('image', image!.path);
    request.files.add(file);
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
      var jsonResponse = json.decode(response.body);
      print(jsonResponse['classification']);


      return jsonResponse['classification'];
    } else {
      throw Exception('Failed to classify image: ${response.statusCode}');
      print('Image upload failed with status code ${response.statusCode}');
    }
  }

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
              'I\'m ready ,\n\nUpload your Image ',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
             Expanded(
                flex: 2,
                child: Center(
                    child: image!=null?Image.file(image!):Image.asset("assets/images/logo.png")
                )
             ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        pickImage().then((value) => print("DONE"));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 30, right: 30, top: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'Upload',
                        style: TextStyle(fontSize: 20),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        message = await uploadImage();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResultScreen(result: message)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 30, right: 30, top: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'Check',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              )),
            ),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
