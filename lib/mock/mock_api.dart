import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/item_model.dart';

final mockApiProvider = Provider((_) => MockApi());

class MockApi {
  Future<PaginatedResponse> fetchItems({
    required int id,
    required String direction,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network latency

    // Generate items based on direction
    List<ItemModel> data = [];
    if (direction == 'up') {
      if (id > 1) {
        data = List.generate(20, (index) {
          final itemId = id - index - 1;
          return itemId >= 1
              ? ItemModel(id: itemId, title: 'Item $itemId')
              : null;
        }).whereType<ItemModel>().toList();
      }
    } else if (direction == 'down') {
      if (id < 2000) {
        data = List.generate(20, (index) {
          final itemId = id + index + 1;
          return itemId <= 2000
              ? ItemModel(id: itemId, title: 'Item $itemId')
              : null;
        }).whereType<ItemModel>().toList();
      }
    }

    // Check if there are more items to load
    final bool hasMore = direction == 'up' ? id > 1 : id < 2000;

    return PaginatedResponse(data: data, hasMore: hasMore);
  }
}

class PaginatedResponse {
  final List<ItemModel> data;
  final bool hasMore;

  PaginatedResponse({required this.data, required this.hasMore});
}
