import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tracking_app/Screens/create_blog.dart';
import 'package:time_tracking_app/Screens/image_placeholder/image_place_holder.dart';
import 'package:time_tracking_app/Services/auth.dart';


class HomePage extends StatefulWidget {
  final AuthBase auth;

  const HomePage({Key key, this.auth}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> _onSignOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
      ),
      body: PostsView(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName ?? "unknown"),
              accountEmail: Text(user.email ?? user.uid ),
              currentAccountPicture: CircleAvatar(
                child: Image.network(user.photoURL ?? ""),
              ),
            ),
            ListTile(
              title: Text("Home",style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),),
              leading: Icon(Icons.home,color: Colors.black),
            ),
            Divider(height: 20.0,color: Colors.black,thickness: 2.0,),
            ListTile(
              title: Text("Profile",style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),),
              leading: Icon(Icons.person,color: Colors.black),
            ),
            Divider(height: 20.0,color: Colors.black,thickness: 2.0,),
            ListTile(
              title: Text("Product",style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),),
              leading: Icon(Icons.auto_awesome_mosaic,color: Colors.black),
            ),
            Divider(height: 20.0,color: Colors.black,thickness: 2.0,),
            ListTile(
              title: Text("Setting",style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),),
              leading: Icon(Icons.settings,color: Colors.black),
            ),
            Divider(height: 20.0,color: Colors.black,thickness: 2.0,),
            ListTile(
              title: Text("About us",style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),),
              leading: Icon(Icons.supervisor_account_sharp,color: Colors.black,),
            ),
            Divider(height: 20.0,color: Colors.black,thickness: 2.0,),
            ListTile(
              onTap: _onSignOut,
              title: Text("Logout",style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),),
              leading: Icon(Icons.home,color: Colors.black),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostsView extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  PostsView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data.docs[index];

                return BlogsTile(
                  avatar: '${document["avatar"]}',
                  imgUrl: "${document["imgUrl"]}",
                  description: "${document["desc"]}",
                  title: "${document["title"]}",
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class BlogsTile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  final String imgUrl, description, title, avatar;

  BlogsTile({@required this.imgUrl, @required this.description, @required this.title, @required this.avatar});

  Widget _buildReactionsPreviewIcon(String path) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
    child: Image.asset(path, height: 40),
  );
  Widget _buildReactionsIcon(String path, Text text) => Container(
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        Image.asset(path, height: 20),
        const SizedBox(width: 5),
        text,
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              child: ListTile(
                leading: ImagePlaceholderNetwork(
                  avatar,
                  circular: true,
                  text: title.substring(0, 1),
                  height: 40.0,
                  width: 40.0,
                ),
                title: Text(title),
              ),
            ),
            Container(
              decoration: BoxDecoration(),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(description),
              ),
            ),
            InteractiveViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterReactionButtonCheck(
                      onReactionChanged: (reaction, index, isChecked) {
                        print('reaction selected index: $index');
                      },
                      reactions: <Reaction>[
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                            'images/angry.png',
                          ),
                          icon: _buildReactionsIcon(
                              'images/angry.png', Text('Angry')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/happy.png'
                          ),
                          icon: _buildReactionsIcon('images/happy.png', Text('Happy')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/smile.png'
                          ),
                          icon: _buildReactionsIcon('images/smile.png', Text('Smile')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/mad.png'
                          ),
                          icon: _buildReactionsIcon('images/mad.png', Text('Mad')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/surprised.png'
                          ),
                          icon: _buildReactionsIcon('images/surprised.png', Text('Surprised')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/in-love.png'
                          ),
                          icon: _buildReactionsIcon('images/in-love.png', Text('Love')
                          ),
                        ),

                      ],
                      initialReaction: Reaction(
                        icon: Icon(Icons.thumb_up_alt_outlined,size: 30.0,),
                      ),

                    ),
                    FlutterReactionButtonCheck(
                      onReactionChanged: (reaction, index, isChecked) {
                        print('reaction selected index: $index');
                      },
                      reactions: <Reaction>[
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                            'images/angry.png',
                          ),
                          icon: _buildReactionsIcon(
                              'images/angry.png', Text('Angry')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/happy.png'
                          ),
                          icon: _buildReactionsIcon('images/happy.png', Text('Happy')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/smile.png'
                          ),
                          icon: _buildReactionsIcon('images/smile.png', Text('Smile')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/mad.png'
                          ),
                          icon: _buildReactionsIcon('images/mad.png', Text('Mad')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/surprised.png'
                          ),
                          icon: _buildReactionsIcon('images/surprised.png', Text('Surprised')
                          ),
                        ),
                        Reaction(
                          previewIcon: _buildReactionsPreviewIcon(
                              'images/in-love.png'
                          ),
                          icon: _buildReactionsIcon('images/in-love.png', Text('Love')
                          ),
                        ),

                      ],
                      initialReaction: Reaction(
                        icon: _buildReactionsIcon('images/sad.png', Text('Sad')
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
