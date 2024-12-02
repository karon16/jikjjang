import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';

class JobCard extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String jobType;
  final String level;
  final String location;
  final String daysLeft;
  final VoidCallback onBookmarkPressed;
  final String companyDescription;

  const JobCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.jobType,
    required this.level,
    required this.location,
    required this.daysLeft,
    required this.companyDescription,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(JSizes.borderRadiusSM),
                    child: Image.asset(
                      companyLogo,
                      width: 36,
                      height: 36,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(companyName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: JAppColors.textPrimary)),
                        Text(companyDescription,
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: onBookmarkPressed,
                      icon: const Icon(Icons.bookmark_outline))
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                jobTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: JAppColors.secondary,
                        borderRadius:
                            BorderRadius.circular(JSizes.borderRadiusSM)),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      jobType,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: JAppColors.textPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: JAppColors.secondary,
                        borderRadius:
                            BorderRadius.circular(JSizes.borderRadiusSM)),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      level,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: JAppColors.textPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: JAppColors.secondary,
                        borderRadius:
                            BorderRadius.circular(JSizes.borderRadiusSM)),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      location,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: JAppColors.textPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    daysLeft,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              // const SizedBox(
              //   height: 8,
              // ),
            ],
          )),
    );
  }
}
