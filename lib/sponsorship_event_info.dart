import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/dashboard_student.dart';
import 'package:flutter/material.dart';


class SponsorshipInfo extends StatelessWidget {
  final String clubid;
  final String eventid;
 SponsorshipInfo({required this.clubid, required this.eventid});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cname = TextEditingController();
  final TextEditingController _caddress = TextEditingController();
  final TextEditingController _samount = TextEditingController();
  final TextEditingController _personname = TextEditingController();
  final TextEditingController _personemail = TextEditingController();
  final TextEditingController _personphno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sponsorship Information'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('Enter "NA" if any field is not applicable'),
              TextFormField(
                controller: _cname,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _caddress,
                decoration: const InputDecoration(
                  labelText: 'Company Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _samount,
                decoration: const InputDecoration(
                  labelText: 'Sponsorship Amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _personname,
                decoration: const InputDecoration(
                  labelText: 'Person Incharge Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _personemail,
                decoration: const InputDecoration(
                  labelText: 'Person Incharge e-mail Id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: _einfra,
              //   decoration: const InputDecoration(
              //     labelText: 'Extra Infrastructure',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'This field is mandatory';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: _sname,
              //   decoration: const InputDecoration(
              //     labelText: 'Speaker Name',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'This field is mandatory';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: _personphno,
                decoration: const InputDecoration(
                  labelText: 'Person Incharge Phone number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: _efees,
              //   decoration: const InputDecoration(
              //     labelText: 'Event  fees',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'This field is mandatory';
              //     }
              //     return null;
              //   },
              // ),
              ElevatedButton(
                onPressed: () async {
                  String cname = _cname.text;
                  String caddress = _caddress.text;
                  String samount = _samount.text;
                  String personname = _personname.text;
                  String personemail = _personemail.text;
                  // String eventinfra = _einfra.text;
                  // String speakername = _sname.text;
                  String personphno = _personphno.text;
                  

                  sponsorship request = sponsorship(
                    cname: cname,
                    caddress: caddress,
                    samount: samount,
                    personname: personname,
                    personemail: personemail,
                    // eventinfra: eventinfra,
                    // speakername: speakername,
                    personphno: personphno ,
                    // eventfees: eventfees,
                  );

                  await FirebaseFirestore.instance
                      .collection('clubs')
                      .doc(clubid)
                      .collection('Events')
                      .doc(eventid)
                      .collection('general_info')
                      .add({
                    'company name': request.cname,
                    'company address': request.caddress,
                    'sponsorship amount': request.samount,
                    'person name': request.personname,
                    'person email': request.personemail,
                    // 'eventinfra': request.eventinfra,
                    // 'speakername': request.speakername,
                    'person phno': request.personphno,
                    // 'eventfees': request.eventfees,
                  });
                  if (_formKey.currentState!.validate()) {
                    print('database created');
                  } else {
                    print('Some error occured');
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardStudent()));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class sponsorship {
  final String cname;
  final String caddress;
  final String samount;
  final String personname;
  final String personemail;
  // final String eventinfra;
  // final String speakername;
  final String personphno;
  // final String eventfees;

  sponsorship({
    required this.cname,
    required this.caddress,
    required this.samount,
    required this.personname,
    required this.personemail,
    // required this.eventinfra,
    // required this.speakername,
    required this.personphno,
    // required this.eventfees,
  });
}
  