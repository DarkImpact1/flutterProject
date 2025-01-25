import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/pagination_view_model.dart';
import '../widgets/item_tile.dart';
import '../widgets/shimmer_loader.dart';

class PaginatedListView extends ConsumerWidget {
  const PaginatedListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(paginationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Two-Way Paginated List')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          final items = ref.read(paginationProvider);  // Ensure to get the list here
          if (items.isEmpty) return true; // Early exit if list is empty
          
          if (scrollNotification is ScrollEndNotification) {
            final metrics = scrollNotification.metrics;
            final viewModel = ref.read(paginationProvider.notifier);

            if (metrics.pixels == 0 && viewModel.canFetchUp) {
              viewModel.fetchItems(id: items.first.id, direction: 'up');
            } else if (metrics.pixels == metrics.maxScrollExtent && viewModel.canFetchDown) {
              viewModel.fetchItems(id: items.last.id, direction: 'down');
            }
          }
          return true;
        },
        child: ListView.builder(
          itemCount: items.length + 2, // Adjust shimmer loaders
          itemBuilder: (context, index) {
            if (index == 0) {
              return ref.read(paginationProvider.notifier).canFetchUp
                  ? const ShimmerLoader()
                  : const SizedBox.shrink();
            }
            if (index == items.length + 1) {
              return ref.read(paginationProvider.notifier).canFetchDown
                  ? const ShimmerLoader()
                  : const SizedBox.shrink();
            }

            return ItemTile(item: items[index - 1]);
          },
        ),
      ),
    );
  }
}
