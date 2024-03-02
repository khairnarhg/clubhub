import 'package:club_hub/event_planning.dart';
import 'package:flutter/material.dart';


class EventCoordinatorsInfo extends StatelessWidget {
  EventCoordinatorsInfo({super.key});
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _scname = TextEditingController();
  final TextEditingController _scclass = TextEditingController();
  final TextEditingController _sccollegeid = TextEditingController();
  final TextEditingController _sct = TextEditingController();
  final TextEditingController _stcname= TextEditingController();
  final TextEditingController _stcdep= TextEditingController();
  final TextEditingController _stcid= TextEditingController();
  final TextEditingController _stct= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Coordinators'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('Enter "NA" if any field is not applicable'),
              TextFormField(
                controller: _scname,
                decoration: const InputDecoration(
                  labelText: 'Student Coordinator Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _scclass,
                decoration: const InputDecoration(
                  labelText: 'Student Coordinator Class',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sccollegeid,
                decoration: const InputDecoration(
                  labelText: 'Students coordinator id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sct,
                decoration: const InputDecoration(
                  labelText: 'Student coordinator task',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stcname,
                decoration: const InputDecoration(
                  labelText: 'Staff Coordinator name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stcdep,
                decoration: const InputDecoration(
                  labelText: 'Staff Coordinator department',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller:_stcid,
                decoration: const InputDecoration(
                  labelText: 'Staff Coordinator Id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stct,
                decoration: const InputDecoration(
                  labelText: 'Staff Coordinator tasks',
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
                  // String iname = _iname.text;
                  // String iq = _iquantity.text;
                  // String isp = _isp.text;
                  // String isv = _isv.text;
                  // String ic = _ic.text;
                  // // String eventinfra = _einfra.text;
                  // // String speakername = _sname.text;
                  // // String personphno = _personphno.text;
                  

                  // insfrastructure request = infrastructure(
                  //   iname: iname,
                  //   iq: iq,
                  //   isp: isp,
                  //   isv: isv,
                  //   ic: ic,
                  //   // eventinfra: eventinfra,
                  //   // speakername: speakername,
                
                  //   // eventfees: eventfees,
                  // );

                  // await FirebaseFirestore.instance
                  //     .collection('clubs')
                  //     .doc(clubid)
                  //     .collection('Events')
                  //     .doc(eventid)
                  //     .collection('general_info')
                  //     .add({
                  //   'iname': request.iname,
                  //   'iq': request.iq,
                  //   'isp': request.isp,
                  //   'isv': request.isv,
                  //   'ic': request.ic,
                  //   // 'eventinfra': request.eventinfra,
                  //   // 'speakername': request.speakername,
                  //   // 'person phno': request.personphno,
                  //   // 'eventfees': request.eventfees,
                  // });
                  // if (_formKey.currentState!.validate()) {
                  //   print('database created');
                  // } else {
                  //   print('Some error occured');
                  // }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventPlanningPage(clubId: '225643',)));
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

// class sponsorship {
//   final String cname;
//   final String caddress;
//   final String samount;
//   final String personname;
//   final String personemail;
//   // final String eventinfra;
//   // final String speakername;
//   final String personphno;
//   // final String eventfees;

//   sponsorship({
//     required this.cname,
//     required this.caddress,
//     required this.samount,
//     required this.personname,
//     required this.personemail,
//     // required this.eventinfra,
//     // required this.speakername,
//     required this.personphno,
//     // required this.eventfees,
//   });
    