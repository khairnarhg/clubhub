import 'package:flutter/material.dart';

class MembershipForm extends StatefulWidget {
  const MembershipForm({super.key});

  @override
  State<MembershipForm> createState() => _MembershipFormState();
}

class _MembershipFormState extends State<MembershipForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mname = TextEditingController();
  final TextEditingController _mId = TextEditingController();
  final TextEditingController _mbranch = TextEditingController();
  final TextEditingController _myear = TextEditingController();
  final TextEditingController _mcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Form'),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _mname,
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is mandatory';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Submit')),
          ],
        ),
      )),
    );
  }
}
