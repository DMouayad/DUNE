abstract class BaseModelFactory<T extends Object> {
  T create();

  List<T> createCount(int count) {
    return List.generate(count, (index) => create());
  }

  List<T> createCountFromCustomBuilder(int count, T Function() builder) {
    return List.generate(count, (index) => builder());
  }
}
