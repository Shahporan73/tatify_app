import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowFullScreenImageDialog extends StatelessWidget {
  final String imageUrl;

  const ShowFullScreenImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Stack(
        children: [
          Positioned.fill(
            child: imageUrl == ''
                ? Center(
              child: CircularProgressIndicator(),
            )
                : InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl.isNotEmpty ? imageUrl : '',
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                child: Icon(Icons.close, color: Colors.white, size: 24),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}