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
  final List<Map<String, dynamic>> applicants;
  final String? jobImageUrl;
  final String companyLogoUrl;
  final String companyIndustry;
  final String companyName;
  final String? title_lower;
  // final String companyField;
  // final String companyDescription;
  // final String companyLogo;

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
    required this.companyLogoUrl,
    required this.companyIndustry,
    required this.companyName,
    this.title_lower,
  });

factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobID: map['jobID'] ?? '', // Handle null or missing values
      companyID: map['companyID'] ?? '',
      category: map['category'] is Map<String, dynamic>
          ? map['category']['name'] // Extract nested value
          : map['category'] ?? '', // Default to an empty string
      title: map['title'] ?? '',
      title_lower: map['title_lower'] ?? '',
      description: map['description'] ?? '',
      requirements: map['requirements'] is List
          ? List<String>.from(map['requirements'])
          : [], // Default to empty list
      location: map['location'] ?? '',
      employmentType: map['employmentType'] ?? '',
      salaryRange: map['salaryRange'],
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ??
          DateTime.now(), // Fallback to current time
      expiresAt: DateTime.tryParse(map['expiresAt'] ?? '') ??
          DateTime.now()
              .add(const Duration(days: 30)), // Default to 30 days from now
      postedBy: map['postedBy'] ?? '',
      applicants: map['applicants'] is List
          ? List<Map<String, dynamic>>.from(map['applicants'])
          : [],
      jobImageUrl: map['jobImageUrl'],
      companyLogoUrl: map['companyLogoUrl'] ?? '',
      companyIndustry: map['companyIndustry'] ?? '',
      companyName: map['companyName'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'jobID': jobID,
      'companyID': companyID,
      'category': category,
      'title': title,
'title_lower': title.toLowerCase(),
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
      'companyLogoUrl': companyLogoUrl,
      'companyIndustry': companyIndustry,
      'companyName': companyName,
    };
  }
}
