class Heap {
  final List<int> _heap = [];
  final bool isMinHeap;

  Heap({this.isMinHeap = true});

  void insert(int value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  int? extract() {
    if (_heap.isEmpty) return null;
    final root = _heap.first;
    _heap[0] = _heap.removeLast();
    if (_heap.isNotEmpty) _bubbleDown(0);
    return root;
  }

  void _bubbleUp(int index) {
    while (index > 0) {
      final parent = (index - 1) ~/ 2;
      if (_compare(_heap[index], _heap[parent])) {
        _swap(index, parent);
        index = parent;
      } else {
        break;
      }
    }
  }

  void _bubbleDown(int index) {
    final size = _heap.length;

    while (true) {
      final left = 2 * index + 1;
      final right = 2 * index + 2;
      var target = index;

      if (left < size && _compare(_heap[left], _heap[target])) target = left;
      if (right < size && _compare(_heap[right], _heap[target])) target = right;

      if (target != index) {
        _swap(index, target);
        index = target;
      } else {
        break;
      }
    }
  }

  bool _compare(int a, int b) => isMinHeap ? a < b : a > b;

  void _swap(int i, int j) {
    final temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  List<int> get values => List.unmodifiable(_heap);
}
