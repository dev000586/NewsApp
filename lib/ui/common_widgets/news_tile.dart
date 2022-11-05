
import 'package:flutter/material.dart';

import '../../helper/constants/images_constants.dart';

Widget NewsTile ({
  required String image,
  required String sourceName,
  required String published,
  required String title,
  required String description,
  required double width
}){
  return Row(
    children: [
      SizedBox(
        width: width*0.4-10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image == "" ?
            Image.asset(ImageConst.placeholder, height: 60, width: width*0.4-10, fit: BoxFit.fitHeight,)
                : Image.network(image, height: 60, width: width*0.4-10, fit: BoxFit.fitWidth,),
            const SizedBox(height: 10,),
            Text(
              sourceName,
              style: const TextStyle(
                  fontSize: 12
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              published,
              style: const TextStyle(
                  fontSize: 12
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 10,),
      SizedBox(
        width: width*0.6-20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12
              ),
            )
          ],
        ),
      )
    ],
  );

}