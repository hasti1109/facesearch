import 'dart:io';
import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class MyCard extends StatefulWidget {
  final Function() pickImageFromGallery;
  final Function() deleteImage;
  final File? selectedImage;

  MyCard({super.key, required this.pickImageFromGallery, required this.deleteImage, required this.selectedImage});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: [14, 7],
      strokeWidth: 2.5,
      radius: Radius.circular(20),
      child: Container(
          height: 300,
          width: 325,
          child: widget.selectedImage != null
              ? Column(
            children: [
              Container(
                  width: 280,
                  height: 220,
                  child: Image.file(widget.selectedImage!)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 95),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: widget.deleteImage,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF23395D),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
              : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 200,
                    height: 200,
                    child: Lottie.network('https://lottie.host/6ed29f59-cdc8-4044-9ee3-f6cbb53fbb9e/XJfps9XS2y.json')
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 95),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: widget.pickImageFromGallery,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF23395D),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'Upload',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          )
      ),
    );
  }
}
