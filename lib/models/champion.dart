class Champion {
  int id;
  String name;
  String feName;
  String title;
  String role;
  String feRole;
  String image;
  String latest;

  Champion(
      {this.id,
      this.name,
      this.feName,
      this.title,
      this.role,
      this.feRole,
      this.image,
      this.latest});

  Champion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feName = json['feName'];
    title = json['title'];
    role = json['role'];
    feRole = json['feRole'];
    image = json['image'];
    latest = json['latest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['feName'] = this.feName;
    data['title'] = this.title;
    data['role'] = this.role;
    data['feRole'] = this.feRole;
    data['image'] = this.image;
    data['latest'] = this.latest;
    return data;
  }
}
