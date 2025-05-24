class Job {
  final int id;
  final String title;
  final String description;
  final String type;
  final String location;
  final String salary;
  final String deadline;
  final String userEmail;
  final String? company;

  const Job(
      {required this.id,
      required this.title,
      required this.type,
      required this.description,
      required this.location,
      required this.salary,
      required this.deadline,
      required this.userEmail,
      this.company});

  factory Job.fromMap(Map<dynamic, dynamic> data) {
    return Job(
        id: data['id'] as dynamic,
        title: data['title'] as dynamic,
        type: data['type'] as dynamic,
        description: data['description'] as dynamic,
        location: data['location'] as dynamic,
        salary: data['salary'] as dynamic,
        deadline: data['deadline'] as dynamic,
        userEmail: data['userEmail'] as dynamic,
        company: data['company'] as dynamic);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "type": type,
        "description": description,
        "location": location,
        "salary": salary,
        "deadline": deadline,
        "userEmail": userEmail,
        "company": company
      };

  factory Job.fromJson(Map<dynamic, dynamic> data) {
    return Job(
        id: data['id'] as dynamic,
        title: data['title'] as dynamic,
        type: data['type'] as dynamic,
        description: data['description'] as dynamic,
        location: data['location'] as dynamic,
        salary: data['salary'] as dynamic,
        deadline: data['deadline'] as dynamic,
        userEmail: data['userEmail'] as dynamic,
        company: data['company'] as dynamic);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "description": description,
        "location": location,
        "salary": salary,
        "deadline": deadline,
        "userEmail": userEmail,
        "company": company
      };
}
