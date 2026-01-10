import 'package:flutter/material.dart';
import 'package:flutter_project/Product/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/product_card.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/product_banner.dart';
import '../../shared/app_colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(productProvider.notifier).loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SearchBarWidget(
              onSearch: (query) => ref.read(productProvider.notifier).searchProducts(query),
            ),
            const SizedBox(height: 16),
            const ProductoBanner(),
            _buildCategoryFilter(),
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.products.length + (state.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.products.length) {
                    final product = state.products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: product,
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'name': 'all', 'icon': Icons.apps},
      {'name': 'smartphones', 'icon': Icons.smartphone},
      {'name': 'laptops', 'icon': Icons.laptop_mac},
      {'name': 'fragrances', 'icon': Icons.spa},
    ];
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ChoiceChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(cat['icon'] as IconData, size: 20, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(cat['name'] as String, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            selected: false, 
            backgroundColor: AppColors.surface,
            selectedColor: AppColors.primary,
            labelStyle: const TextStyle(color: AppColors.onSurface),
            onSelected: (_) => ref.read(productProvider.notifier).filterByCategory((cat['name'] as String).toLowerCase()),
            elevation: 2,
            shadowColor: AppColors.primary.withValues(alpha: 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          );
        },
      ),
    );
  }
}
