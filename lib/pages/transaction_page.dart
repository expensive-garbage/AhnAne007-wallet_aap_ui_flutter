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
  Future<void> sendTransaction() async {
    String authenticatedUserId = FirebaseAuth.instance.currentUser!.uid;

    List<Future<void>> storeTransactionsFrom = [];
    List<Future<void>> storeTransactionsTo = [];


    print('To: $widget.userToId, From: $widget.userToName, Balance: 50');
    Future<void> storeTransactionFrom =
        FirebaseFirestore.instance.collection('TransactionHistory').doc(authenticatedUserId).collection('transactions').add({
      'to': widget.userToId,
      'from': authenticatedUserId ,
      'balance': 50,
    }).then((value) {
      print('Transaction stored successfully in Firestore!');
    }).catchError((error) {
      print('Error storing transaction in Firestore: $error');
    });

    Future<void> storeTransactionTo =
    FirebaseFirestore.instance.collection('TransactionHistory').doc(widget.userToId).collection('transactions').add({
      'to': widget.userToId,
      'from': authenticatedUserId,
      'balance': 50,
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
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: sendTransaction,
          child: Text('Send Transaction'),
        ),
      ),
    );
  }
}
