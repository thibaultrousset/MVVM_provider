class TVShow {
  int? id;
  String? title;
  String? year;
  String? director;
  int? duration;
  int? rate;
  String? type;
  String? description;
  String? thumbUrl;
  String? bannerUrl;

  TVShow(
      {this.id,
      this.title,
      this.year,
      this.director,
      this.duration,
      this.rate,
      this.type,
      this.description,
      this.thumbUrl,
      this.bannerUrl});

  TVShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    director = json['director'];
    duration = json['duration'];
    rate = json['rate'];
    type = json['type'];
    description = json['description'];
    thumbUrl = json['thumb_url'];
    bannerUrl = json['banner_url'];
  }
}
