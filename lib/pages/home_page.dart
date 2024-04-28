import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:facesearch/components/mycard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> imagesList = [];
  File ? _selectedImage;
  Timer? timer;
  bool imageSelected = false;

  //method to upload pic
  Future _pickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      imageSelected = true;
      _selectedImage = File(returnedImage.path);
    });
    _showImageEvery2Sec();
  }

  void _deleteImage() {
    setState(() {
      imageSelected = false;
      _selectedImage = null;
    });
    imagesList.clear();
    timer?.cancel();
  }

  void _showImageEvery2Sec() {
    int counter = 0;
    timer = Timer.periodic(const Duration(seconds: 2), (timer){
      if (counter<10){
        fetchImage();
        setState(() {

        });
        counter++;
      }
      else{
        timer.cancel();
      }
    });
  }
  
  Future<void> fetchImage() async{
    try{
      final response = await http.get(Uri.http('192.168.32.169:3000','images'));
      if (response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        setState(() {
          imagesList.add(jsonData["imageUrl"]);
        });
      }
      else {
        print('Failed to fetch image: ${response.statusCode}');
      }
    }
    catch(error){
      print('Error fetching image:${error}');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          backgroundColor: Colors.transparent,
          title: Text('Upload Image', style: GoogleFonts.ubuntu(),),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                  ],
                ),
            
                MyCard(
                    pickImageFromGallery: _pickImageFromGallery,
                    deleteImage: _deleteImage,
                    selectedImage: _selectedImage
                ),

                SizedBox(height: 10,),
            
                imagesList.isEmpty
                  ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      imageSelected
                      ? SizedBox(height:400, width:300, child: Center(child: CircularProgressIndicator(color: Color(0xFF23395D), strokeWidth: 3.0,)))
                      : SizedBox(height:400, child: Center(child: Text('Please upload an image to search for images.')))
                    ],
                  )
                  : Padding(
                    padding: EdgeInsets.all(8),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: imagesList.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as per your requirement
                              child: Image.network(
                                imagesList[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover, // Adjust the fit as per your requirement
                              ),
                            )
                          );
                        }
                    ),
                  )
              ],
            ),
          ),
        )
    );
  }
}

