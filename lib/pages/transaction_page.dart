import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  final String userToId;
  final String userToName;
  final String userName;

  const TransactionPage(
      {Key? key,
      required this.userToId,
      required this.userToName,
      required this.userName})
      : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late String balance;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  void _fetchBalance() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
          balance =
              (snapshot.data() as Map<String, dynamic>)['balance'].toString();
        });
      } else {
        setState(() {
          balance = 'No data available';
        });
      }
    } catch (e) {
      setState(() {
        balance = 'Error occurred';
      });
      print(e.toString());
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> sendTransaction() async {
    String authenticatedUserId = FirebaseAuth.instance.currentUser!.uid;

    List<Future<void>> storeTransactionsFrom = [];
    List<Future<void>> storeTransactionsTo = [];

    print('To: $widget.userToId, From: $widget.userToName, Balance: 50');
    Future<void> storeTransactionFrom = FirebaseFirestore.instance
        .collection('TransactionHistory')
        .doc(authenticatedUserId)
        .collection('transactions')
        .add({
      'to': widget.userToId,
      'from': authenticatedUserId,
      'balance': 50,
      'status': 0,
    }).then((value) {
      print('Transaction stored successfully in Firestore!');
    }).catchError((error) {
      print('Error storing transaction in Firestore: $error');
    });

    Future<void> storeTransactionTo = FirebaseFirestore.instance
        .collection('TransactionHistory')
        .doc(widget.userToId)
        .collection('transactions')
        .add({
      'to': widget.userToId,
      'from': authenticatedUserId,
      'balance': 50,
      'status': 1,
    }).then((value) {
      print('Transaction stored successfully in Firestore!');
    }).catchError((error) {
      print('Error storing transaction in Firestore: $error');
    });

    storeTransactionsFrom.add(storeTransactionFrom);
    storeTransactionsTo.add(storeTransactionTo);
    try {
      await Future.wait(storeTransactionsFrom);
      print('All transactions stored successfully!');
    } catch (error) {
      print('Error storing transactions in Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
//        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  size: 32,
                  color: Colors.deepOrange,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  size: 32,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Money",
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Column(
                children: [
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Enter the amount",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                _showSnackbar(
                                    "Please fill the amount correctly");
                                return "";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                          )
                        ],
                      )),
                  SizedBox(
                    height: height * 0.3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Send to " + widget.userToName,
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey[800]),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            sendTransaction();
                          } else {
                            _showSnackbar("Please fill the amount correctly");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder(),
                          ),
                          maximumSize:
                              MaterialStateProperty.all<Size>(Size(64, 64)),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(64, 64)),
                        ),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
