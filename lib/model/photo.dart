class Photo {
  final String id;
  final String url;
  final String username;
  final String description;

  Photo({this.id, this.url, this.username, this.description});

  factory Photo.fromJson(json) {
    // print(json['desciption']);
    // print(json['alt_description']);
    return Photo(
        id: json['id'],
        url: json['urls']['regular'],
        username: json['user']['name'] ?? "anonymous",
        description:
            json['description'] ?? json['alt_description'] ?? "No info :(");
  }
}
