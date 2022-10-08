import 'package:advanced_answer_2/add_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advance Exercise 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  //問２　FirestoreのドキュメントデータをBookとして扱える。
  final CollectionReference<Book> userRef = FirebaseFirestore.instance.collection('books')
      .withConverter<Book>(
    fromFirestore: (snapshots, _) => Book.fromJson(snapshots.data()!),
    toFirestore: (book, _) => book.toJson(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<Book>>(
              stream:  userRef.orderBy('date').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index){
                          return BookCard(book: data.docs[index].data());
                        }
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddBook())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({Key? key, required this.book}) : super(key: key);

  //問２　Bookのインスタンスを受け取る。
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(book.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(book.author, style: const TextStyle(fontSize: 16, color: Color(0xff555555)),)
            ],
          )
        ),
      ),
    );
  }
}


