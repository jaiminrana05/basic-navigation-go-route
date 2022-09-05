import 'dart:math';

import 'package:basic_navigation_go_route/pages/profile/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ProfileStore>(context);
    final profileStoreList = store.profileList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Dynamic Profile!'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              var randomInt = Random().nextInt(10000);
              store.onCreate(randomInt.toString());
            },
            child: const Text('Create Profile'),
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                return ListView.builder(
                  itemCount: profileStoreList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text('profileId ${i + 1}'),
                      subtitle: Text(profileStoreList[i].id),
                      onTap: () => context.goNamed(
                        'SingleProfile',
                        queryParams: {
                          'id': profileStoreList[i].id,
                        },
                        params: {'tab': 'profile'},
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class NewProfile {
  NewProfile(this.id);
  final String id;
}
