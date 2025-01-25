import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/item_model.dart';

final mockApiProvider = Provider((_) => MockApi());

class MockApi {
  Future<PaginatedResponse> fetchItems({required int id, required String direction}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network latency

    final List<ItemModel> data = List.generate(20, (index) {
      final itemId = direction == 'up' ? id - index - 1 : id + index + 1;
      return ItemModel(id: itemId, title: 'Item $itemId');
    });

    final bool hasMore = direction == 'up' ? id > 0 : id < 2000;

    return PaginatedResponse(data: data, hasMore: hasMore);
  }
}

class PaginatedResponse {
  final List<ItemModel> data;
  final bool hasMore;

  PaginatedResponse({required this.data, required this.hasMore});
}
