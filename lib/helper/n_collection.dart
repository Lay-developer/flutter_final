import 'package:scoped_model/scoped_model.dart';

class NCollection<T> extends Model {
  List<T> _collections = [];

  NCollection({required List<T> collections}) {
    _collections = collections;
  }

  /////////////////////
  ///Get report by index
  T? item(int idx) {
    if (idx < 0) return null;
    if (idx > _collections.length) return null;
    return _collections[idx];
  }

  /////////////////////
  ///Return all items
  List<T> items() {
    return _collections;
  }

  ////////////////////
  ///Count item
  int get length => _collections.length;

  List<T> get allItems => _collections;

  void notifyDecendant() {
    notifyListeners();
  }

  ////////////////////
  ///If an item exist
  bool contains(var item) {
    return _collections.contains(item);
  }

  void replaceAll(List<T> newItem) {
    _collections.clear();
    _collections.addAll(newItem);
    notifyDecendant();
  }

  void replaceLastIfNew(int count, List<T> itemUpdate) {
    //if(count == reportUpdate.length) return null;
    _collections.removeRange(_collections.length - count,
        _collections.length); //Remove item before add new
    _collections.addAll(itemUpdate);
    notifyDecendant();
  }

  ////////////////////
  ///Add item(s)
  void add(var item) {
    _collections.add(item);
    notifyDecendant();
  }

  ////////////////////
  /// Insert Item
  void insert(int index, var item) {
    _collections.insert(index, item);
    notifyDecendant();
  }

  void addAll(List<T> items) {
    _collections.addAll(items);
    notifyDecendant();
  }

  ////////////////////
  ///Replace item(s)
  void replace(int idx, var item) {
    _collections.replaceRange(idx, idx + 1, [item]);
    _collections.add(item);
    notifyDecendant();
  }

  ////////////////////
  ///replace item with no index
  void replaceItem(var item) {
    for (var i = 0; i < _collections.length; i++) {
      dynamic tmp1 = (_collections[i] as dynamic);
      dynamic tmp2 = (item as dynamic);
      if (tmp1.id == tmp2.id) {
        _collections[i] = item;
        notifyDecendant();
        return;
      }
    }
  }

  ////////////////////
  /// find index of item
  int getItemIndex(T item) {
    for (var i = 0; i < _collections.length; i++) {
      dynamic tmp1 = (_collections[i] as dynamic);
      dynamic tmp2 = (item as dynamic);
      if (tmp1.id == tmp2.id) {
        return i;
      }
    }
    return -1;
  }

  ////////////////////
  ///Remove item(s)
  bool remove(T item) {
    bool removed = _collections.remove(item);
    notifyDecendant();
    return removed;
  }

  void removeLast() {
    _collections.removeLast();
    notifyDecendant();
  }

  void removeRange(int start, int end) {
    _collections.removeRange(start, end);
    notifyDecendant();
  }

  void removeAt(int index) {
    _collections.removeAt(index);
    notifyDecendant();
  }

  void removeAll() {
    _collections.clear();
    notifyDecendant();
  }
}
