import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;

  File selectedImage;
  bool _isLoading = false;

  final user = FirebaseAuth.instance.currentUser;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await  ( await task.whenComplete(() => print("Uploading"))).ref.getDownloadURL();
      print("this is url $downloadUrl");
      final String guestAvatar = 'https://th.bing.com/th/id/OIP.zRTBu_XDzjhuLGZNlXgzOwAAAA?pid=ImgDet&rs=1';

      Map<String, dynamic> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": user.uid,
        "avatar": user.isAnonymous ? guestAvatar : user.photoURL,
        "title": user.displayName?? "Guest",
        "desc": desc
      };
      DocumentReference users = FirebaseFirestore.instance.collection('posts').doc();
      users.set(blogMap);
      Navigator.of(context).pop();

    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),

        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
            : Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: selectedImage != null
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: InteractiveViewer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          selectedImage,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  )
                      : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    width: MediaQuery.of(context).size.width,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black45,
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    // TextField(
                    //   decoration: InputDecoration(hintText: "Author Name"),
                    //   onChanged: (val) {
                    //     authorName = val;
                    //   },
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(hintText: "Title"),
                    //   onChanged: (val) {
                    //     title = val;
                    //   },
                    // ),
                    TextField(
                      decoration: InputDecoration(hintText: "Desc"),
                      onChanged: (val) {
                        desc = val;
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}