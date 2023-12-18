import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';

class DashCardView extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color background;
  final VoidCallback onTap;
  final String image;

  const DashCardView(
      {@required this.title,
      this.iconData,
      this.background,
      @required this.onTap,
      @required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          // height: SizeConfig.blockSizeHorizontal,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: ImageConfig.fromAsset(imagePath: image, size: 60)),
              const SizedBox(height: 8),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
