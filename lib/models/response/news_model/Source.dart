class Source {
    String? id;
    String? name;

    Source({this.id, this.name});

    factory Source.fromJson(Map<String, dynamic> json) {
        return Source(
            id: json['id'],
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['name'] = name;
        data['id'] = id;
        return data;
    }
}