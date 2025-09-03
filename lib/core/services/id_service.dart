class IdService {
  int smallestMissingNumber(List<int> list) {
    int i = 1;
    for (; i <= list.length; i++) {
      if (!list.contains(i)) {
        break;
      }
    }
    return i;
  }
}
