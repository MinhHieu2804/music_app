import 'package:flutter/material.dart';
import 'package:music_app/widgets/home_gird_item.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String link =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ86rvPTRCjbQvjLoTZPS7G6vCGcjIWTIm_gA&usqp=CAU';
    return Container(
      height: 178,
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 168 / 50,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: [
          HomeGridItem(link, 'Pop'),
          HomeGridItem(link, 'Ballad'),
          HomeGridItem(link, 'Country'),
          HomeGridItem(link, 'Folks'),
          HomeGridItem(link, 'Rock'),
          HomeGridItem(link, 'Soul'),
        ],
      ),
    );
  }
}
