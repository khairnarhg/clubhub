import 'package:flutter/material.dart';

class membershipForm extends StatefulWidget {
  const membershipForm({super.key});

  @override
  State<membershipForm> createState() => _membershipFormState();
}

class _membershipFormState extends State<membershipForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mname = TextEditingController();
  TextEditingController _mId = TextEditingController();
  TextEditingController _mbranch = TextEditingController();
  TextEditingController _myear = TextEditingController();
  TextEditingController _mcon = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _mname,
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
                controller: _mId,
                decoration: InputDecoration(
                  labelText: 'College ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mbranch,
                decoration: InputDecoration(
                  labelText: 'Branch',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _myear,
                decoration: InputDecoration(
                  labelText: 'Year',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mcon,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){}, child: Text('Submit')),
            ],
          ),
        )
      ),
    );
  }
}

