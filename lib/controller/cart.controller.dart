import 'package:get/get.dart';

import '../class/list_tab_item.dart';

class CartController extends GetxController {
  final RxList<ListTabItem> _lists = <ListTabItem>[].obs;
  final RxBool _isLoading = true.obs;

  List<ListTabItem> get lists => _lists;
  RxBool get isLoading => _isLoading;

  addItem(ListTabItem item) {
    _lists.add(item);
  }

  updateItem(ListTabItem item) {
    int index = _lists.indexWhere((element) => element.id == item.id);
    _lists[index] = item;
  }

  deleteItem(int id) {
    int index = _lists.indexWhere((element) => element.id == id);
    _lists.removeAt(index);

    _lists.refresh();

    print(_lists);
  }

  setLists(List<ListTabItem> newLists) {
    _lists.clear();
    _lists.addAll(newLists);
  }

  initLists(List<ListTabItem> newLists) {
    _isLoading.value = false;

    setLists(newLists);
  }
}
