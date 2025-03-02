import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final int id;
  final String? title;
  final String shortDes;
  final String? price;
  final String image;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final Function() onTapBuyNow;

  const SliderWidget({
    super.key,
    this.id = 0,
    this.title,
    this.shortDes = '',
    this.price,
    required this.image,
    this.productId = 0,
    this.createdAt = '',
    this.updatedAt = '',
    required this.onTapBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(image),
        Positioned(
          top: 80,
          left: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 40,
            children: [
              Text(
                title ?? " ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 70,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                price ?? " ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 70,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: 300,
        //   left: 600,
        //   child: InkWell(
        //     onTap: onTapBuyNow,
        //     child: Container(
        //       width: 350,
        //       height: 150,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         color: Theme.of(context).colorScheme.primary,
        //         borderRadius: BorderRadius.circular(25),
        //       ),
        //       child: Text(
        //         "Buy Now",
        //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //               fontSize: 70,
        //               color: Colors.white,
        //             ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
