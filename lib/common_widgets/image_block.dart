import 'package:flutter/material.dart';

class ImageBlock extends StatelessWidget {
  const ImageBlock(
      {Key key,
      this.photoUrl,
      @required this.radius,
      this.color = Colors.black54})
      : super(key: key);

  final String photoUrl;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, border: Border.all(color: color, width: 3)),
      child: Image.network(photoUrl,),
      // child: CircleAvatar(
      //   radius: radius,
      //   backgroundColor: Colors.black12,
      //   backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      //   child: photoUrl == null ? Icon(Icons.camera_alt, size: radius) : null,
      // ),
    );
  }
}
