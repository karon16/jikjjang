import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/recruiter/jobs/models/company_model.dart';
import 'package:jikjjang_app/features/recruiter/jobs/services/company_service.dart';

final companyProvider =
    FutureProvider.family<Company?, String>((ref, companyID) {
  final companyService = CompanyService();
  return companyService.getCompanyById(companyID);
});
