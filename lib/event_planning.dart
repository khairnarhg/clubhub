import 'package:club_hub/event_coordinators_info.dart';
import 'package:club_hub/general_event_info.dart';
import 'package:club_hub/infrastructure_event_info.dart';
import 'package:club_hub/speaker_event_info.dart';
import 'package:club_hub/sponsorship_event_info.dart';
import 'package:flutter/material.dart';

class EventPlanningPage extends StatefulWidget {
  final String clubId;
  const EventPlanningPage({Key? key, required this.clubId}) : super(key: key);

  @override
  _EventPlanningPageState createState() => _EventPlanningPageState();
}

class _EventPlanningPageState extends State<EventPlanningPage> {
  // List to track completion status of each subheading
  // List<bool> _subheadingsCompleted = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Planning'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('General Info'),
            // trailing: _subheadingsCompleted[0]
            //     ? Icon(Icons.check_circle, color: Colors.green)
            //     : null,
            onTap: () {
              // Navigate to General Info page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneralInfo(
                    clubid: widget.clubId,
                      // Pass callback to update completion status
                      // onCompletionChanged: (completed) {
                      //   setState(() {
                      //     _subheadingsCompleted[0] = completed;
                      //   });
                      //},
                      ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Sponsorship Info'),
            // trailing: _subheadingsCompleted[1]
            //     ? Icon(Icons.check_circle, color: Colors.green)
            //     : null,
            onTap: () {
              // Navigate to Sponsorship Info page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SponsorshipInfo(
                    clubid: widget.clubId,
                    eventid: '123456',
                      // Pass callback to update completion status
                      // onCompletionChanged: (completed) {
                      //   setState(() {
                      //     _subheadingsCompleted[1] = completed;
                      //   }
                      //);
                      //},
                      ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Infrastructure Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfrastructureInfo(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Speaker Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpeakerInfo(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Event Coordinators Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventCoordinatorsInfo(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
