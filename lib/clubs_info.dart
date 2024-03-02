import 'package:club_hub/membership_form.dart';
import 'package:flutter/material.dart';

class ClubsInfo extends StatefulWidget {
  const ClubsInfo({super.key});

  @override
  State<ClubsInfo> createState() => _ClubsInfoState();
}

class _ClubsInfoState extends State<ClubsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClubsInfo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset('assets/images/aidllogo.jpg',
                  width: 100, height: 100),
            ),
            const Center(
              child: Text(
                'Artificial Intelligence and Deep Learning Club',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                  'AIDL Clus is a group of Staff and Students of Fr. C. Rodrigues Institute of Technology,'
                  'focusing mainly on activities related to Artificial Intelligence and Deep Learning.'),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                  'The Idea is to spread awareness, encourage students, staff and idustry professional,'
                  'inculcate enthusiasm to take up projects in this domain and solve real life problems of our society.'),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text('CC members, staffs, community links'),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MembershipForm(clubId: "225643")));
                  },
                  child: const Text('Apply for membership')),
            ),
            const SizedBox(height: 25),
            Center(
              child: Image.asset('assets/images/nsslogo.png',
                  width: 125, height: 125),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                  'The National Service Scheme (NSS), a Central Sector Scheme under the Ministry of Youth Affairs & Sports,'
                  'offers students in Indian technical institutions, colleges, and universities the opportunity to engage in'
                  'government-led community service activities. Since its inception in 1969, NSS has seen significant growth,'
                  'with over 3.8 million students participating by March 2018. The NSS unit at Fr C. Rodrigues Institute of Technology,'
                  ' active since the academic year 2019-2020, comprises 50 student members under Mumbai University, with the motto "NOT ME BUT YOU."'),
            ),
          ],
        ),
      ),
    );
  }
}
