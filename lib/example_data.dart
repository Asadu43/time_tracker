import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

final defaultInitialReaction = Reaction(
  icon: Container(
      height: 5,child: Icon(Icons.thumb_up, size: 10.0,)),
);

final reactions = [
  Reaction(
    title: _buildTitle('Happy'),
    previewIcon: _buildReactionsPreviewIcon('images/happy.png'),
    icon: _buildReactionsIcon(
      'images/happy.png',
      Text(
        'Happy',
        style: TextStyle(
          color: Color(0XFF3b5998),
        ),
      ),
    ),
  ),
  Reaction(
    title: _buildTitle('Angry'),
    previewIcon: _buildReactionsPreviewIcon('images/angry.png'),
    icon: _buildReactionsIcon(
      'images/angry.png',
      Text(
        'Angry',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
  Reaction(
    title: _buildTitle('In love'),
    previewIcon: _buildReactionsPreviewIcon('images/in-love.png'),
    icon: _buildReactionsIcon(
      'images/in-love.png',
      Text(
        'In love',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction(
    title: _buildTitle('Sad'),
    previewIcon: _buildReactionsPreviewIcon('images/sad.png'),
    icon: _buildReactionsIcon(
      'images/sad.png',
      Text(
        'Sad',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction(
    title: _buildTitle('Surprised'),
    previewIcon: _buildReactionsPreviewIcon('images/surprised.png'),
    icon: _buildReactionsIcon(
      'images/surprised.png',
      Text(
        'Surprised',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction(
    title: _buildTitle('Mad'),
    previewIcon: _buildReactionsPreviewIcon('images/mad.png'),
    icon: _buildReactionsIcon(
      'images/mad.png',
      Text(
        'Mad',
        style: TextStyle(
          color: Color(0XFFf05766),
        ),
      ),
    ),
  ),
];

// Widget _builFlagsdPreviewIcon(String path, String text) => Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//   child: Column(
//     children: [
//       Text(
//         text,
//         style: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w300,
//           color: Colors.white,
//         ),
//       ),
//       const SizedBox(height: 7.5),
//       Image.asset(path, height: 30),
//     ],
//   ),
// );

Widget _buildTitle(String title) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
  decoration: BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(15),
  ),
  child: Text(
    title,
    style: TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  ),
);

Widget _buildReactionsPreviewIcon(String path) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
  child: Image.asset(path, height: 40),
);

// Widget _buildIcon(String path) => Image.asset(
//   path,
//   height: 30,
//   width: 30,
// );

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
