class Job {
  final String jobID;
  final String companyID;
  final String category;
  final String title;
  final String description;
  final List<String> requirements;
  final String location;
  final String employmentType;
  final String? salaryRange;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String postedBy;
  final List<String> applicants;
  final String? jobImageUrl;

  Job({
    required this.jobID,
    required this.companyID,
    required this.category,
    required this.title,
    required this.description,
    required this.requirements,
    required this.location,
    required this.employmentType,
    this.salaryRange,
    required this.createdAt,
    required this.expiresAt,
    required this.postedBy,
    required this.applicants,
    this.jobImageUrl,
  });

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobID: map['jobID'],
      companyID: map['companyID'],
      category: map['category'],
      title: map['title'],
      description: map['description'],
      requirements: List<String>.from(map['requirements']),
      location: map['location'],
      employmentType: map['employmentType'],
      salaryRange: map['salaryRange'],
      createdAt: DateTime.parse(map['createdAt']),
      expiresAt: DateTime.parse(map['expiresAt']),
      postedBy: map['postedBy'],
      applicants: List<String>.from(map['applicants']),
      jobImageUrl: map['jobImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobID': jobID,
      'companyID': companyID,
      'category': category,
      'title': title,
      'description': description,
      'requirements': requirements,
      'location': location,
      'employmentType': employmentType,
      'salaryRange': salaryRange,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'postedBy': postedBy,
      'applicants': applicants,
      'jobImageUrl': jobImageUrl,
    };
  }
}
