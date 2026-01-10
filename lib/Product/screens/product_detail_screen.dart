// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../../shared/icons.dart';
import '../../shared/app_colors.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider).products.firstWhere(
          (p) => p.id.toString() == productId,
    );

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: AppColors.surface,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.onSurface,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      product.rating.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.string(starIcon),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: AppColors.background,
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            'Información',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                      ),  
                      const SizedBox(height: 12),              
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Stock: ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onBackground,
                              ),
                            ),
                            Text(
                              '${product.stock} disponibles',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Categoría: ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onBackground,
                              ),
                            ),
                            Text(
                              product.category,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Marca: ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onBackground,
                              ),
                            ),
                            Text(
                              product.brand,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'SKU: ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onBackground,
                              ),
                            ),
                            Text(
                              product.sku,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: 48,
                          decoration: BoxDecoration(
                            color: product.price < 50
                              ? AppColors.error
                              : AppColors.background,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: SvgPicture.string(
                            heartIcon,
                            colorFilter: ColorFilter.mode(
                              product.price < 50
                                ? AppColors.accent
                                : AppColors.background,
                              BlendMode.srcIn),
                            height: 16,
                          ),
                        ),
                      ),
                    ],                    
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    super.key,
    required this.color,
    required this.child,
  });

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(widget.product.images[selectedImage]),
          ),
        ),
        // SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              widget.product.images.length,
              (index) => SmallProductImage(
                isSelected: index == selectedImage,
                press: () {
                  setState(() {
                    selectedImage = index;
                  });
                },
                image: widget.product.images[index],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.isSelected ? AppColors.primary : AppColors.surface),
        ),
        child: Image.network(widget.image),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.product,
    this.pressOnSeeMore,
  });

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product.description,
            maxLines: 10,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.onSurface,
            ),
          ),
        )
      ],
    );
  }
}
