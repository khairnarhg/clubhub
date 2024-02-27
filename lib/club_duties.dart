import 'package:club_hub/dynamic_reg_form.dart';
import 'package:club_hub/event_planning.dart';
import 'package:club_hub/post_invitation.dart';
import 'package:club_hub/release_p_r.dart';
import 'package:club_hub/upload_meeting_doc.dart';
import 'package:club_hub/user_search_screen.dart';
import 'package:flutter/material.dart';

class ClubDuties extends StatelessWidget {
  final String clubId;
  const ClubDuties({super.key, required this.clubId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duties'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Add Position'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserSearchScreen()),
            ),
          ),
          ListTile(
            title: const Text('Post Invitation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostInvitation(clubId: clubId)),
            ),
          ),
          ListTile(
            title: const Text('Release PR'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReleasePR()),
            ),
          ),
          ListTile(
            title: const Text('Event Planning'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventPlanning()),
            ),
          ),
          ListTile(
            title: const Text('Upload Meeting Documents'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadMeetingDocs(clubId: clubId)),
            ),
          ),
          ListTile(
            title: const Text('Make Registration Form'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DynamicRegistrationForm()),
            ),
          ),
        ],
      ),
    );
  }
}
