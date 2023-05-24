import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/user/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final modelUser = Provider.of<ModelUser>(context, listen: false);
    _nameController.text = modelUser.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  final picker = ImagePicker();
  late String base64Image;
  File? imageFile;
  FormData? formData;
  Uint8List? img;
  bool _isLoading = false;

  Future<void> _selectAndUploadImage() async {
    final modelUser = Provider.of<ModelUser>(context, listen: false);

    final imgFile = await picker.getImage(source: ImageSource.gallery);

    if (imgFile != null) {
      imageFile = File(imgFile.path);
      List<int> imageBytes = await imageFile!.readAsBytes();
      base64Image = 'data:image/png;base64,' + base64Encode(imageBytes);
    } else if (modelUser.user.profile != null) {
      base64Image = modelUser.user.profile!;
    }
  }

  Future<void> _saveChanges() async {
    // Save the changes
    final modelUser = Provider.of<ModelUser>(context, listen: false);

    final dio = Dio();
    final String token = modelUser.user.token;

    try {
      final response = await dio.post(
        '$mainUrl/profile/update',
        queryParameters: modelUser.toJson(),
        data: {
          'name': _nameController.text,
          'profile': base64Image,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setStringList('credentials', <String>[
        response.data['data']['_id'].toString(),
        response.data['data']['name'].toString(),
        response.data['data']['username'].toString(),
        response.data['data']['phone'].toString(),
        response.data['data']['auth_token'].toString(),
        response.data['data']['profile'].toString(),
      ]);

      modelUser.setUser(
        id: response.data['data']['_id'].toString(),
        name: response.data['data']['name'].toString(),
        username: response.data['data']['username'].toString(),
        phone: response.data['data']['phone'].toString(),
        token: response.data['data']['auth_token'].toString(),
        profile: response.data['data']['profile'].toString(),
      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated Successfully"),
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } // Navigate back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    final modelUser = Provider.of<ModelUser>(context, listen: false);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: mainColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 728,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      imageFile != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: FileImage(imageFile!),
                              backgroundColor: Colors.red,
                            )
                          : modelUser.user.profile != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      modelUser.user.profile.toString()),
                                  backgroundColor: Colors.red,
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://i.stack.imgur.com/l60Hf.png'),
                                  backgroundColor: Colors.red,
                                ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: _selectAndUploadImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    width: 200,
                    height: 47,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });

                              await _saveChanges();
                              //await widget.loginController.otp_submit(context);

                              setState(() {
                                _isLoading = false;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Save Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
