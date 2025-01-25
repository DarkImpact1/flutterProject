import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../mock/mock_api.dart';
import '../models/item_model.dart';

final paginationProvider = StateNotifierProvider<PaginationViewModel, List<ItemModel>>((ref) {
  return PaginationViewModel(ref)..loadInitialItems();
});

class PaginationViewModel extends StateNotifier<List<ItemModel>> {
  final Ref ref;
  bool _isFetching = false;
  bool _hasMoreUp = true;
  bool _hasMoreDown = true;

  PaginationViewModel(this.ref) : super([]);

  // Initial loading of items
  Future<void> loadInitialItems() async {
    await fetchItems(id: 0, direction: 'down'); // Load initial data starting from ID 0
  }

  Future<void> fetchItems({required int id, required String direction}) async {
    if (_isFetching) return;

    _isFetching = true;

    try {
      final result = await ref.read(mockApiProvider).fetchItems(id: id, direction: direction);

      if (direction == 'up') {
        _hasMoreUp = result.hasMore;
        state = [...result.data, ...state];
      } else {
        _hasMoreDown = result.hasMore;
        state = [...state, ...result.data];
      }
    } catch (e) {
      print('Error fetching items: $e');
    } finally {
      _isFetching = false;
    }
  }

  bool get canFetchUp => _hasMoreUp && !_isFetching;
  bool get canFetchDown => _hasMoreDown && !_isFetching;
}
