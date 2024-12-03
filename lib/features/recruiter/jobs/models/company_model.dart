class Company {
  final String companyAddress;
  final String companyID;
  final String companyName;
  final String createdBy;
  final String description;
  final String industry;
  final String logoURL;
  final List<String> recruiters;

  Company({
    required this.companyAddress,
    required this.companyID,
    required this.companyName,
    required this.createdBy,
    required this.description,
    required this.industry,
    required this.logoURL,
    required this.recruiters,
  });

  // Factory constructor to create a Company from a JSON map
  factory Company.fromMap(Map<String, dynamic> data) {
    return Company(
      companyID: data['companyID'] ?? '',
      companyAddress: data['companyAddress'] ?? '',
      companyName: data['companyName'] ?? '',
      createdBy: data['createdBy'] ?? '',
      description: data['description'] ?? '',
      logoURL: data['logoURL'] ?? '',
      recruiters: List<String>.from(data['recruiters'] ?? []),
      industry: data['industry'] ?? '',
    );
  }

  // Method to convert the Company object into a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'companyID': companyID,
      'companyAddress': companyAddress,
      'companyName': companyName,
      'createdBy': createdBy,
      'description': description,
      'logoURL': logoURL,
      'recruiters': recruiters,
      'industry': industry,
    };
  }
}
