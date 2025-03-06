import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIS_228 Assignment 2',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final Map<String, bool> _interests = {
    "Planning": false,
    "Journaling": false,
    "Reading": false,
    "Arts": false,
  };

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      print("First Name: ${_firstNameController.text}");
      print("Last Name: ${_lastNameController.text}");
      print("Email: ${_emailController.text}");
      print("Interests: ${_interests.entries.where((entry) => entry.value).map((entry) => entry.key).join(', ')}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/jep.png'),
                  backgroundColor: Colors.blue[200],
                ),
                const SizedBox(height: 20),
                _buildTextField(_firstNameController, "First Name"),
                _buildTextField(_lastNameController, "Last Name"),
                _buildTextField(_emailController, "Email"),
                const SizedBox(height: 20),
                _buildInterestsSection(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label cannot be empty';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildInterestsSection() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Select Interests',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Column(
            children: _interests.keys.map((String key) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CheckboxListTile(
                  title: Text(key, textAlign: TextAlign.left),
                  value: _interests[key],
                  activeColor: Colors.blue,
                  onChanged: (bool? value) {
                    setState(() {
                      _interests[key] = value!;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
