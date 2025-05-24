class Offer {
  final int id;
  final String title;
  final String description;
  final String link;
  final String discount;
  final String? image;
  final String date;

  final String userEmail;
  final String? company;

  const Offer(
      {required this.id,
      required this.title,
      required this.link,
      required this.description,
      required this.discount,
      this.image,
      required this.date,
      required this.userEmail,
      this.company});

  factory Offer.fromMap(Map<dynamic, dynamic> data) {
    return Offer(
        id: data['id'] as dynamic,
        title: data['title'] as dynamic,
        link: data['link'] as dynamic,
        description: data['description'] as dynamic,
        discount: data['discount'] as dynamic,
        image: data['image'] as dynamic,
        date: data['date'] as dynamic,
        userEmail: data['userEmail'] as dynamic,
        company: data['company'] as dynamic);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "description": description,
        "discount": discount,
        "image": image,
        "date": date,
        "userEmail": userEmail,
        "company": company
      };

  factory Offer.fromJson(Map<dynamic, dynamic> data) {
    return Offer(
        id: data['id'] as dynamic,
        title: data['title'] as dynamic,
        link: data['link'] as dynamic,
        description: data['description'] as dynamic,
        discount: data['discount'] as dynamic,
        image: data['image'] as dynamic,
        date: data['date'] as dynamic,
        userEmail: data['userEmail'] as dynamic,
        company: data['company'] as dynamic);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "description": description,
        "discount": discount,
        "image": image,
        "date": date,
        "userEmail": userEmail,
        "company": company
      };
}
