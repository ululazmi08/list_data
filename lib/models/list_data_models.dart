class ListData {
  ListData({
    required this.id,
    required this.title,
    required this.description,
  });
  late final int id;
  late final String title;
  late final String description;

  ListData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    return _data;
  }
}