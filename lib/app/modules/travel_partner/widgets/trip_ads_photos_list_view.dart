// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sharek/core/widgets/network_image.dart';

class AdsPhotosListView extends StatelessWidget {
  const AdsPhotosListView({
    Key? key,
    required this.photos,
  }) : super(key: key);
  final List<String> photos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصور (${photos.length})'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: photos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          var image = photos[index];
          return AppCachedNetworkImage(
            imageUrl: image,
            radius: 0,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 3,
          );
        },
      ),
    );
  }
}