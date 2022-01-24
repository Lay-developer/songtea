class Category {
  late int _id;
  late String _categoryName;
  late String _description;

  Category({
    int id = 0,
    String categoryName = '',
    String description = '',
  }) {
    _id = id;
    _categoryName = categoryName;
    _description = description;
  }

  ///////
  ///getter
  int get id => _id;
  String get categoryName => _categoryName;
  String get description => _description;

  ///////
  ///setter
  set id(int value) => _id = id;
  set categoryName(String value) => _categoryName = categoryName;
  set description(String value) => _description = description;

  Category.map(dynamic obj) {
    _id = (obj['id'] == null ? 0 : int.parse(obj['id'].toString()));
    _categoryName =
        (obj['category_name'] == null ? '' : obj['category_name'].toString());
    _description =
        (obj['description'] == null ? '' : obj['description'].toString());
  }
}
