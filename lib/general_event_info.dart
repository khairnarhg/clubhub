import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/dashboard_student.dart';
import 'package:club_hub/sponsorship_event_info.dart';
import 'package:flutter/material.dart';

class GeneralInfo extends StatelessWidget {
  final String clubid;
  GeneralInfo({required this.clubid});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ename = TextEditingController();
  final TextEditingController _edate = TextEditingController();
  final TextEditingController _evenue = TextEditingController();
  final TextEditingController _etime = TextEditingController();
  // final TextEditingController _einfra = TextEditingController();
  // final TextEditingController _sname = TextEditingController();
  final TextEditingController _edesc = TextEditingController();
  final TextEditingController _efees = TextEditingController();
  final TextEditingController _eId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Information'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('Enter "NA" if any field is not applicable'),
              TextFormField(
                controller: _eId,
                decoration: const InputDecoration(
                  labelText: 'Event Id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ename,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edate,
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _evenue,
                decoration: const InputDecoration(
                  labelText: 'Event Venue',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _etime,
                decoration: const InputDecoration(
                  labelText: 'Event time',
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
                controller: _edesc,
                decoration: const InputDecoration(
                  labelText: 'Event  Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _efees,
                decoration: const InputDecoration(
                  labelText: 'Event  fees',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  String eventId = _eId.text;
                  String eventname = _ename.text;
                  String eventdate = _edate.text;
                  String eventvenue = _evenue.text;
                  String eventtime = _etime.text;
                  // String eventinfra = _einfra.text;
                  // String speakername = _sname.text;
                  String eventdesc = _edesc.text;
                  String eventfees = _efees.text;

                  eventPlanning request = eventPlanning(
                    eventId: eventId,
                    eventname: eventname,
                    eventdate: eventdate,
                    eventvenue: eventvenue,
                    eventtime: eventtime,
                    // eventinfra: eventinfra,
                    // speakername: speakername,
                    eventdesc: eventdesc,
                    eventfees: eventfees,
                  );

                  await FirebaseFirestore.instance
                      .collection('clubs')
                      .doc(clubid)
                      .collection('Events')
                      .doc(eventId)
                      .collection('general_info')
                      .add({
                    'eventId': request.eventId,
                    'eventName': request.eventname,
                    'eventdate': request.eventdate,
                    'eventvenue': request.eventvenue,
                    'eventtime': request.eventtime,
                    // 'eventinfra': request.eventinfra,
                    // 'speakername': request.speakername,
                    'eventdesc': request.eventdesc,
                    'eventfees': request.eventfees,
                  });
                  if (_formKey.currentState!.validate()) {
                    print('database created');
                  } else {
                    print('Some error occured');
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  SponsorshipInfo(clubid: clubid,eventid: eventId,)));
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

class eventPlanning {
  final String eventId;
  final String eventname;
  final String eventdate;
  final String eventvenue;
  final String eventtime;
  // final String eventinfra;
  // final String speakername;
  final String eventdesc;
  final String eventfees;

  eventPlanning({
    required this.eventId,
    required this.eventname,
    required this.eventdate,
    required this.eventvenue,
    required this.eventtime,
    // required this.eventinfra,
    // required this.speakername,
    required this.eventdesc,
    required this.eventfees,
  });
}
