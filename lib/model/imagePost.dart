// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'dart:async';
// // import 'profile_page.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'comment_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class WorkOrder extends StatefulWidget {
// const WorkOrder(
//   {
//     this.workOrderId,
//     this.customerRef,
//    this.author,
//    this.serviceItems,
//    this.isDone,
//    this.status,
//    this.color,
//  this.fbId,
//  } );

//   factory WorkOrder.fromDocument(DocumentSnapshot document) {
//     return new WorkOrder(
//       workOrderId: document.documentID,
//       customerRef: document['customerRef'],
//       author: document['author'],
//       serviceItems: document['serviceItems'],
//       isDone: document['isDone'],
//       status: document['status'],
//       color: document['color'],
//       fbId: document['fbId'],
//     );
//   }

//   factory WorkOrder.fromJSON(Map data) {
//     return new WorkOrder(
//     workOrderId : data['id'],
//     author: data['author'], 
//     customerRef: data['customerRef'], 
//     serviceItems: data['serviceItems'], 
//     isDone:data['isDone'],  
//     fbId: data['fbId'],
//     status: data['status'],
//     color: data['color'],
//     );
//   }

//   int getLikeCount(var likes) {
//     if (likes == null) {
//       return 0;
//     }
// // issue is below
//     var vals = likes.values;
//     int count = 0;
//     for (var val in vals) {
//       if (val == true) {
//         count = count + 1;
//       }
//     }

//     return count;
//   }

//   final String workOrderId;
//   final customerRef;
//   final String author;
//   final serviceItems;
//   final bool isDone;
//   final String status;
//   final Color color;
//   final String fbId;

//   _WorkOrder createState() => new _WorkOrder(
//         workOrderId: this.workOrderId,
//         customerRef: this.customerRef,
//         author: this.author,
//         serviceItems: this.serviceItems,
//     isDone:this.isDone,  
//     fbId:this.fbId,
//     status: this.status,
//     color: this.color,
//         // likes: this.likes,
//         // likeCount: getLikeCount(this.likes),
//         // ownerId: this.ownerId,
//         // postId: this.postId,
//       );
// }

// class _WorkOrder extends State<WorkOrder> {
//     final String workOrderId;
//   final customerRef;
//   final String author;
//   final serviceItems;
//   final bool isDone;
//   final String status;
//   final Color color;
//   final String fbId;
  
//   // final String mediaUrl;
//   // final String username;
//   // final String location;
//   // final String description;
//   // Map likes;
//   // int likeCount;
//   // final String postId;
//   // bool liked;
//   // final String ownerId;

//   // bool showHeart = false;

//   TextStyle boldStyle = new TextStyle(
//     color: Colors.black,
//     fontWeight: FontWeight.bold,
//   );

//   var reference = Firestore.instance.collection('insta_posts');

//   _WorkOrder(
//       {
//         this.workOrderId,
//     this.customerRef,
//    this.author,
//    this.serviceItems,
//    this.isDone,
//    this.status,
//    this.color,
//  this.fbId,
//      });

//   // GestureDetector buildLikeIcon() {
//   //   Color color;
//   //   IconData icon;

//   //   // if (liked) {
//   //   //   color = Colors.pink;
//   //   //   icon = FontAwesomeIcons.solidHeart;
//   //   // } else {
//   //   //   icon = FontAwesomeIcons.heart;
//   //   // }

//   //   return new GestureDetector(
//   //       child: new Icon(
//   //         icon,
//   //         size: 25.0,
//   //         color: color,
//   //       ),
//   //       onTap: () {
//   //         _likePost(postId);
//   //       });
//   // }

// //   GestureDetector buildLikeableImage() {
// //     return new GestureDetector(
// //       // onDoubleTap: () => _likePost(postId),
// //       child: new Stack(
// //         alignment: Alignment.center,
// //         children: <Widget>[
// // //          new FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: mediaUrl),
// //           new CachedNetworkImage(
// //             imageUrl: mediaUrl,
// //             fit: BoxFit.fitWidth,
// //             placeholder: loadingPlaceHolder,
// //             errorWidget: new Icon(Icons.error),
// //           ),
// //           showHeart
// //               ? new Positioned(
// //                   child: new Opacity(
// //                       opacity: 0.85,
// //                       child: new Icon(
// //                         FontAwesomeIcons.solidHeart,
// //                         size: 80.0,
// //                         color: Colors.white,
// //                       )),
// //                 )
// //               : new Container()
// //         ],
// //       ),
// //     );
// //   }

//   buildPostHeader({String ownerId}) {
//     if (ownerId == null) {
//       return new Text("owner error");
//     }

//     return new FutureBuilder(
//         future: Firestore.instance
//             .collection('insta_users')
//             .document(ownerId)
//             .get(),
//         builder: (context, snapshot) {
//           String imageUrl = " ";
//           String username = "  ";

//           if (snapshot.data != null) {
//             imageUrl = snapshot.data.data['photoUrl'];
//             username = snapshot.data.data['username'];
//           }

//           return new ListTile(
//             leading: new CircleAvatar(
//               backgroundImage: new CachedNetworkImageProvider(imageUrl),
//               backgroundColor: Colors.grey,
//             ),
//             title: new GestureDetector(
//               child: new Text(username, style: boldStyle),
//               onTap: () {
//                 openProfile(context, ownerId);
//               },
//             ),
//             subtitle: new Text(this.location),
//             trailing: const Icon(Icons.more_vert),
//           );
//         });
//   }

//   Container loadingPlaceHolder = Container(
//     height: 400.0,
//     child: new Center(child: new CircularProgressIndicator()),
//   );

//   @override
//   Widget build(BuildContext context) {
//     liked = (likes[googleSignIn.currentUser.id.toString()] == true);

//     return new Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         buildPostHeader(ownerId: ownerId),
//         buildLikeableImage(),
//         new Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             new Padding(padding: const EdgeInsets.only(left: 20.0, top: 40.0)),
//             buildLikeIcon(),
//             new Padding(padding: const EdgeInsets.only(right: 20.0)),
//             new GestureDetector(
//                 child: const Icon(
//                   FontAwesomeIcons.comment,
//                   size: 25.0,
//                 ),
//                 onTap: () {
//                   goToComments(
//                       context: context,
//                       postId: postId,
//                       ownerId: ownerId,
//                       mediaUrl: mediaUrl);
//                 }),
//           ],
//         ),
//         new Row(
//           children: <Widget>[
//             new Container(
//               margin: const EdgeInsets.only(left: 20.0),
//               child: new Text(
//                 "$likeCount likes",
//                 style: boldStyle,
//               ),
//             )
//           ],
//         ),
//         new Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Container(
//                 margin: const EdgeInsets.only(left: 20.0),
//                 child: new Text(
//                   "$username ",
//                   style: boldStyle,
//                 )),
//             new Expanded(child: new Text(description)),
//           ],
//         )
//       ],
//     );
//   }

//   void _likePost(String postId2) {
//     var userId = googleSignIn.currentUser.id;
//     bool _liked = likes[userId] == true;

//     if (_liked) {
//       print('removing like');
//       reference.document(postId).updateData({
//         'likes.$userId': false
//         //firestore plugin doesnt support deleting, so it must be nulled / falsed
//       });

//       setState(() {
//         likeCount = likeCount - 1;
//         liked = false;
//         likes[userId] = false;
//       });

//       removeActivityFeedItem();
//     }

//     if (!_liked) {
//       print('liking');
//       reference.document(postId).updateData({'likes.$userId': true});

//       addActivityFeedItem();

//       setState(() {
//         likeCount = likeCount + 1;
//         liked = true;
//         likes[userId] = true;
//         showHeart = true;
//       });
//       new Timer(const Duration(milliseconds: 500), () {
//         setState(() {
//           showHeart = false;
//         });
//       });
//     }
//   }

//   void addActivityFeedItem() {
//     Firestore.instance
//         .collection("insta_a_feed")
//         .document(ownerId)
//         .collection("items")
//         .document(postId)
//         .setData({
//       "username": currentUserModel.username,
//       "userId": currentUserModel.id,
//       "type": "like",
//       "userProfileImg": currentUserModel.photoUrl,
//       "mediaUrl": mediaUrl,
//       "timestamp": new DateTime.now().toString(),
//       "postId": postId,
//     });
//   }

//   void removeActivityFeedItem() {
//     Firestore.instance
//         .collection("insta_a_feed")
//         .document(ownerId)
//         .collection("items")
//         .document(postId)
//         .delete();
//   }
// }

// class WorkOrderFromId extends StatelessWidget {
//   final String id;

//   const WorkOrderFromId({this.id});

//   getWorkOrder() async {
//     var document =
//         await Firestore.instance.collection('workorders').document(id).get();
//     return new WorkOrder.fromDocument(document);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new FutureBuilder(
//         future: getWorkOrder(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData)
//             return new Container(
//                 alignment: FractionalOffset.center,
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: new CircularProgressIndicator());
//           return snapshot.data;
//         });
//   }
// }

// // void goToComments(
// //     {BuildContext context, String postId, String ownerId, String mediaUrl}) {
// //   Navigator.of(context)
// //       .push(new MaterialPageRoute<bool>(builder: (BuildContext context) {
// //     return new CommentScreen(
// //       postId: postId,
// //       postOwner: ownerId,
// //       postMediaUrl: mediaUrl,
// //     );
// //   }));
// // }