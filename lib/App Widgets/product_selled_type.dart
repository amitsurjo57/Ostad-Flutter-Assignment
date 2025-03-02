import 'package:flutter/material.dart';

class ProductSelledType extends StatelessWidget {
  final Widget widget;
  final String productSelledType;
  final void Function() onSeeAll;

  const ProductSelledType({
    super.key,
    required this.widget,
    required this.productSelledType,
    required this.onSeeAll,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productSelledType,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 24),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: const Text(
                "See All",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        widget,
      ],
    );
  }
}
