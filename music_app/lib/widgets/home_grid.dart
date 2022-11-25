import 'package:flutter/material.dart';
import 'package:music_app/providers/albums.dart';
import 'package:music_app/widgets/home_gird_item.dart';
import 'package:provider/provider.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var albums = Provider.of<Albums>(context).items;
    String link =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ86rvPTRCjbQvjLoTZPS7G6vCGcjIWTIm_gA&usqp=CAU';
    return Container(
      height: 178,
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 168 / 50,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: albums!.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: albums[i],
                child: HomeGridItem(),
              )),
    );
  }
}
