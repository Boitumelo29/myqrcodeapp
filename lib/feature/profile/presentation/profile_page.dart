import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myqrcodeapp/common_widgets/app_bar_screen/app_bar_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //final Box bioBox = Hive.box("bioBox");
  var formKey = GlobalKey<FormState>();

  // late Box box;
  TextEditingController controller = TextEditingController();

  // final List<String> gender = [Strings.male, Strings.female];
  // String selectedGender = Strings.maleC;
  Uint8List? galleryFile;
  final picker = ImagePicker();

  DateTime? selectedDate;

  @override
  // void initState() {
  //   super.initState();
  //   user = FirebaseAuth.instance.currentUser;
  //   box = Hive.box('myBox');
  //   controller.text = box.get("bio", defaultValue: '');
  //   loadImageFromHive();
  // }
  //
  // void loadImageFromHive() async {
  //   try {
  //     var box = Hive.box<ImageModel>('images');
  //     ImageModel? imageModel = box.get('profile_image');
  //
  //     if (imageModel != null) {
  //       setState(() {
  //         galleryFile = imageModel.imageBytes; // Store the Uint8List directly
  //       });
  //     }
  //   } catch (e) {
  //     print("Load from Hive error: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AppBarScreen(
      shouldBeCentered: true,
      title: "Edit profile",
      shouldScroll: true,
      shouldHaveFloatingButton: false,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Edit your Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.drive_file_rename_outline)
          ],
        ),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              galleryFile == null
                  ? const Icon(
                      Icons.person,
                      size: 100,
                    )
                  : SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: ClipOval(
                          child: Image.memory(
                            galleryFile!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    _showPicker(context);
                  },
                  icon: const Icon(
                    Icons.camera,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        EditProfileContainer(
            onTap: () {
              userName();
            },
            icon: Icons.person,
            title: "Username"),
        const SizedBox(
          height: 10,
        ),
        EditProfileContainer(
            onTap: () {
              email();
            },
            icon: Icons.email,
            title:  ""),
        const SizedBox(
          height: 15,
        ),
        EditProfileContainer(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2101));
              if (picked != null) {
                setState(
                  () {
                    selectedDate = picked;
                  },
                );
              }
            },
            icon: Icons.calendar_month,
            title: "Add a date of birth"),
        const SizedBox(
          height: 15,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              AboutBioContainer(
                validator: (value) {
                  // return Validation.textValidation(value);
                },
                controller: controller,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 330,
                child: LongButton(
                    isLoading: false,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _saveBio();
                      }
                    },
                    title:""),
              ),
            ],
          ),
        ),
      ],
    );
  }

  userName() {
    var formKey = GlobalKey<FormState>();
    TextEditingController userName = TextEditingController();
    bool isLoading = false;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: 250,
              width: 480,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Update Username",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
                  const SizedBox(
                    height: 20,
                  ),
                  LongTextFieldForm(
                    controller: userName,
                    onChanged: (value) {},
                    hintText: "Username",
                    labelText: "username",
                    showSuffixIcon: false,
                    showPrefixIcon: true,
                    prefixIcon: Icons.person,
                    validator: (value) {

                    },
                    obsureText: false,
                    isRed: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButton(
                      isLoading: isLoading,
                      onTap: () async {
                        print("object");
                        if (formKey.currentState!.validate()) {
                          print("Here");
                        }
                      },
                      title: "Update Username"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  email() {
    final formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    bool isLoading = false;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: 340,
              width: 480,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Update Email",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
                  const SizedBox(
                    height: 20,
                  ),
                  LongTextFieldForm(
                    controller: email,
                    onChanged: (value) {},
                    hintText: "Enter your new email",
                    labelText: "Enter your new email",
                    showSuffixIcon: false,
                    showPrefixIcon: true,
                    prefixIcon: Icons.email,
                    validator: (value) {

                    },
                    obsureText: false,
                    isRed: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LongTextFieldForm(
                    controller: password,
                    onChanged: (value) {},
                    hintText: "Password",
                    labelText: "Password",
                    showSuffixIcon: false,
                    showPrefixIcon: true,
                    prefixIcon: Icons.email,
                    validator: (value) {

                    },
                    obsureText: false,
                    isRed: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButton(
                      isLoading: isLoading,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          print("Here");
                        }
                      },
                      title: "Update Email"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void _saveBio() {
  //   try {
  //     box.put('bio', controller.text);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Profile Saved'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Oop an error has occurred: $e'),
  //       ),
  //     );
  //   }
  // }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: (Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Strings.photoLibrar"y),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    })
              ],
            )),
          );
        });
  }

  Future getImage(ImageSource img) async {
    try {
      final pickedFile = await picker.pickImage(source: img);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes(); // Read the image bytes
        final Uint8List uint8List = Uint8List.fromList(bytes);
        final imageModel = ImageModel(uint8List);

        var box = Hive.box<ImageModel>('images');
        await box.put('profile_image', imageModel); // Store the image in Hive

        setState(() {
          galleryFile = uint8List; // Update the galleryFile to use Uint8List
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error occurred")));
      }
    } catch (e) {
      print("get image error: $e");
    }
  }
}
