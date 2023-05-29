import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app_ui/resources/auth_methods.dart';
import 'package:wallet_app_ui/widgets/user_tile_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Map<String, dynamic> userData = {};
  void _fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          userData = Map.fromIterable(
            snapshot.docs,
            key: (doc) => doc.id,
            value: (doc) => doc.data(),
          );
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: userData.isEmpty
          ? Center(child: CircularProgressIndicator())
           : groupListFromAdmin()
    );
  }

  groupListFromAdmin() {
    Size size = MediaQuery.of(context).size;
    // return Column(
    //   children: [
    //     Container(
    //       width: size.width - 90,
    //       height: size.height * 0.01,
    //     ),
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userData.length,
      itemBuilder: (context, index) {
        String userId = userData.keys.elementAt(index);
        Map<String, dynamic> user = userData[userId];
        String username = user['name'];
        String email = user['email'];
        return UserTileWidget(userToId: userId, userToName: username, userName: AuthMethods().giveUserName().toString());
      },
    );
  }
}
