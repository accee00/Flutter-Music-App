import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallet.dart';
import 'package:music_app/core/utils/utils.dart';
import 'package:music_app/core/widgets/custom_text_field.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _artistNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    super.dispose();
  }

  Future<void> selectImage() async {
    final File? image = await pickImage();
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> selectAudio() async {
    final File? audio = await pickAudio();
    if (audio != null) {
      setState(() {
        selectedAudio = audio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Pallete.transparentColor,
        title: const Text('Upload Song'),
        backgroundColor: Pallete.transparentColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          spacing: 20,
          children: [
            GestureDetector(
              onTap: selectImage,
              child:
                  selectedImage != null
                      ? Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      : const DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: Pallete.borderColor,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Column(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              Text(
                                'Select the thumbnail.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
            ),
            CustomField(
              hintText: 'Pick a song',
              controller: null,
              isReadOnly: true,
              onTap: selectAudio,
            ),
            CustomField(hintText: 'Artist', controller: _artistNameController),
            CustomField(hintText: 'Song name', controller: _songNameController),
            ColorPicker(
              color: selectedColor,
              pickersEnabled: {ColorPickerType.wheel: true},
              onColorChanged: (Color value) {
                setState(() {
                  selectedColor = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
