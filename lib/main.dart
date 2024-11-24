import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VirtualBusinessCard(),
    );
  }
}

class VirtualBusinessCard extends StatefulWidget {
  const VirtualBusinessCard({super.key});

  @override
  _VirtualBusinessCardState createState() => _VirtualBusinessCardState();
}

class _VirtualBusinessCardState extends State<VirtualBusinessCard> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for user input
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _workPhoneController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _generatedVCard;

  // Method to generate vCard
  void _generateVCard() {
    setState(() {
      _generatedVCard = """
BEGIN:VCARD
VERSION:3.0
N:${_lastNameController.text};${_firstNameController.text};;;
FN:${_firstNameController.text} ${_lastNameController.text}
ORG:${_organizationController.text}
TITLE:${_jobTitleController.text}
TEL;TYPE=work,voice:${_workPhoneController.text}
TEL;TYPE=cell,voice:${_mobilePhoneController.text}
EMAIL:${_emailController.text}
URL:${_websiteController.text}
ADR:;;${_addressController.text}
END:VCARD
      """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Virtual Business Card"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Enter your details to create a business card:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: "First Name"),
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter your first name"
                        : null,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: "Last Name"),
                  ),
                  TextFormField(
                    controller: _organizationController,
                    decoration: const InputDecoration(labelText: "Organization"),
                  ),
                  TextFormField(
                    controller: _jobTitleController,
                    decoration: const InputDecoration(labelText: "Job Title"),
                  ),
                  TextFormField(
                    controller: _workPhoneController,
                    decoration: const InputDecoration(labelText: "Work Phone"),
                  ),
                  TextFormField(
                    controller: _mobilePhoneController,
                    decoration: const InputDecoration(labelText: "Mobile Phone"),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter your email"
                        : null,
                  ),
                  TextFormField(
                    controller: _websiteController,
                    decoration: const InputDecoration(labelText: "Website"),
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: "Address"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _generateVCard();
                      }
                    },
                    child: const Text("Generate QR Code"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_generatedVCard != null)
              Column(
                children: [
                  const Text(
                    "Scan this QR code to save contact:",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  QrImageView(
                    // backgroundColor: Colors.blueAccent,
                    data: _generatedVCard!,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ],
              )

          ],
        ),
      ),
    );
  }
}



