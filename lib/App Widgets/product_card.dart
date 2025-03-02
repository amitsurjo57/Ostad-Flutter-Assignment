import 'package:e_commerce_project/Main%20Body/product_details.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productImage;
  final String productName;
  final num productPrice;
  final double rating;

  const ProductCard({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.rating,
  });

  final TextStyle textStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ProductDetails.route);
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: productImage.startsWith("https")
                    ? Image.network(productImage)
                    : Image.asset(productImage),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 4,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Text(
                            "\$$productPrice",
                            style: textStyle.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.orangeAccent,
                              ),
                              Text(
                                "$rating",
                                style: textStyle.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            alignment: Alignment.center,
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
