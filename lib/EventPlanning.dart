import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/dashboard_cc.dart';
import 'package:flutter/material.dart';

class EventPlanning extends StatefulWidget {
  const EventPlanning({super.key});

  @override
  State<EventPlanning> createState() => _EventPlanningState();
}

class _EventPlanningState extends State<EventPlanning> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _ename = TextEditingController();
  TextEditingController _edate = TextEditingController();
  TextEditingController _evenue = TextEditingController();
  TextEditingController _etime = TextEditingController();
  TextEditingController _einfra = TextEditingController();
  TextEditingController _sname = TextEditingController();
  TextEditingController _edesc = TextEditingController();
  TextEditingController _efees = TextEditingController();

  @override
  void dispose() {
    _ename.dispose();
    _edate.dispose();
    _evenue.dispose();
    _etime.dispose();
    _einfra.dispose();
    _sname.dispose();
    _edesc.dispose();
    _efees.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Planning'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ename,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
                  labelText: 'Event time',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _einfra,
                decoration: InputDecoration(
                  labelText: 'Extra Infrastructure',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sname,
                decoration: InputDecoration(
                  labelText: 'Speaker Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edesc,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                onPressed: ()async {
                  String eventname = _ename.text;
                  String eventdate = _edate.text;
                  String eventvenue = _evenue.text;
                  String eventtime = _etime.text;
                  String eventinfra = _einfra.text;
                  String speakername = _sname.text;
                  String eventdesc = _edesc.text;
                  String eventfees = _efees.text;

                  eventPlanning request = eventPlanning(
                    eventname: eventname,
                    eventdate: eventdate,
                    eventvenue: eventvenue,
                    eventtime: eventtime,
                    eventinfra: eventinfra,
                    speakername: speakername,
                    eventdesc: eventdesc,
                    eventfees: eventfees,
                  );

              await FirebaseFirestore.instance
                  .collection('Event_info')
                  .add({
                'eventName': request.eventname,
                'eventdate': request.eventdate,
                'eventvenue': request.eventvenue,
                'eventtime': request.eventtime,
                'eventinfra': request.eventinfra,
                'speakername': request.speakername,
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
                              builder: (context) => DashboardCc()));
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class eventPlanning {
  final String eventname;
  final String eventdate;
  final String eventvenue;
  final String eventtime;
  final String eventinfra;
  final String speakername;
  final String eventdesc;
  final String eventfees;

  eventPlanning({
    required this.eventname,
    required this.eventdate,
    required this.eventvenue,
    required this.eventtime,
    required this.eventinfra,
    required this.speakername,
    required this.eventdesc,
    required this.eventfees,
  });
}
