import 'package:flutter/material.dart';

class MembershipForm extends StatefulWidget {
  const MembershipForm({super.key, required clubId});
  @override
  State<MembershipForm> createState() => _MembershipFormState();
}

class _MembershipFormState extends State<MembershipForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mname = TextEditingController();
  final TextEditingController _mId = TextEditingController();
  final TextEditingController _mcon = TextEditingController();
  String _selectedBranch = '';
  String _selectedTenure = '';
  final List<String> branchOptions = [
    'Computer',
    'Mechanical',
    'Electrical',
    'EXTC',
    'IT'
  ];
  final List<String> tenureOptions = [
    '1 year: 200 rupees',
    '2 years: 300 rupees',
    '3 years: 400 rupees',
    '4 years: 500 rupees'
  ];
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
              DropdownButtonFormField<String>(
                value: _selectedBranch,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBranch = newValue!;
                  });
                },
                items: branchOptions.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch,
                    child: Text(branch),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Branch',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a branch';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedBranch,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBranch = newValue!;
                  });
                },
                items: branchOptions.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch,
                    child: Text(branch),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Branch',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a branch';
                  }
                  return null;
                },
                isExpanded:
                    true, // Ensures the dropdown expands to show all options
                icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
                elevation: 2, // Dropdown menu elevation
                style: const TextStyle(
                    color: Colors.black), // Text style for selected item
                selectedItemBuilder: (BuildContext context) {
                  return branchOptions.map<Widget>((String branch) {
                    return Text(branch); // Display the selected item as text
                  }).toList();
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
        ),
      ),
    );
  }
}
