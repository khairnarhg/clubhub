import 'package:club_hub/event_planning.dart';
import 'package:club_hub/post_invitation.dart';
import 'package:club_hub/release_p_r.dart';
import 'package:club_hub/user_search_screen.dart';
import 'package:flutter/material.dart';

class clubDuties extends StatelessWidget {
  const clubDuties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duties'),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('Add Position'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSearchScreen()),
                ),
              ),
              ListTile(
                title: Text('Post Invitation'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostInvitation()),
                ),
              ),
              ListTile(
                title: Text('Release PR'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReleasePR()),
                ),
              ),
              ListTile(
                title: Text('Event Planning'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventPlanning()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
