import 'package:club_hub/event_planning.dart';
import 'package:flutter/material.dart';


class SpeakerInfo extends StatelessWidget {
   SpeakerInfo({super.key});
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _sname = TextEditingController();
  final TextEditingController _sphno = TextEditingController();
  final TextEditingController _semail = TextEditingController();
  final TextEditingController _saddress = TextEditingController();
  final TextEditingController _scompany= TextEditingController();
  final TextEditingController _sexperience= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speaker Information'),
      ),
       body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('Enter "NA" if any field is not applicable'),
              TextFormField(
                controller: _sname,
                decoration: const InputDecoration(
                  labelText: 'Speaker name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sphno,
                decoration: const InputDecoration(
                  labelText: 'Speaker Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _saddress,
                decoration: const InputDecoration(
                  labelText: 'Infrastructure Source person',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _scompany,
                decoration: const InputDecoration(
                  labelText: 'Infrastructure source venue',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _semail,
                decoration: const InputDecoration(
                  labelText: 'Infrastructure coordinator',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sexperience,
                decoration: const InputDecoration(
                  labelText: 'Extra Infrastructure',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
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
              // TextFormField(
              //   controller: _personphno,
              //   decoration: const InputDecoration(
              //     labelText: 'Person Incharge Phone number',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'This field is mandatory';
              //     }
              //     return null;
              //   },
              // ),
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
    