class Flower {
  String? flowerId;
  String? name;
  bool? isFavorite;
  Flower({
    this.name,
    this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flower_id'] = flowerId;
    data['name'] = name;
    data['is_fav'] = isFavorite;

    return data;
  }

  Flower.fromJson(json) {
    name = json['name'];
    isFavorite = json['is_fav'];
    flowerId = json['flower_id'];
  }
}
