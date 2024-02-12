import 'package:club_hub/welcome.dart';
import 'package:club_hub/firebase_auth_services.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _idno = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  final _rolList = ["Student", "Staff"];
  String? _selectedVal = "Student";

  @override
  void dispose() {
    _name.dispose();
    _idno.dispose();
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idno,
                decoration: InputDecoration(
                  labelText: 'College Id No.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _selectedVal,
                items: _rolList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select your role',
                ),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'E-mail Id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  } else if (!_isValidEmail(value)) {
                    return 'Please enter a valid email with the domain "fcrit.ac.in"';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pass,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Use a regular expression to check if the email has the correct domain
    if (_selectedVal == 'Student' ) {
      RegExp emailRegex1 =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z]+\.fcrit\.ac\.in$');
      return emailRegex1.hasMatch(email);
    } else {
      RegExp emailRegex2 = RegExp(r'^[a-zA-Z0-9._%+-]+@fcrit\.ac\.in$');
      return emailRegex2.hasMatch(email);
    }
  }

  void _signUp() async {
    String email = _email.text;
    String password = _pass.text;
    String collegeidno = _idno.text;
    String name = _name.text;

    //User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (_formKey.currentState!.validate()) {
      _auth.signUpWithEmailAndPassword(
          email, password, collegeidno, name, _selectedVal);
      print('User is successfully created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    } else {
      print('Some error occured');
    }
  }
}
