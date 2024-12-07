import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/common/widgets/appbar/appbar.dart';
import 'package:jikjjang_app/common/widgets/cards/category_card.dart';
import 'package:jikjjang_app/common/widgets/cards/job_card.dart';
import 'package:jikjjang_app/common/widgets/images/j_rounded_image.dart';
import 'package:jikjjang_app/common/widgets/sectionheader.dart';
import 'package:jikjjang_app/data/providers/categories_providers.dart';

import 'package:jikjjang_app/data/providers/job_providers.dart';
import 'package:jikjjang_app/features/job_seeker/jobs/views/job_details.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';

import 'package:jikjjang_app/utils/constants/image_strings.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';
import 'package:jikjjang_app/utils/constants/text_strings.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoriesProviderFull);
    // final user = ref.watch(authControllerProvider);
    final jobsAsyncValue = ref.watch(jobSeekersProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
              child: JAppBar(
                showBackArrow: false,
                leadingWidget: Image.asset(
                  JImage_strings.jikjjangLogo,
                  fit: BoxFit.contain,
                  height: 30,
                  // width: 24,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: JSizes.paddingLG), // Space below AppBar

            // Welcome Message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    JTextStrings.homeMessage,
                    style: TextStyle(
                      fontSize: JSizes.font20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    JTextStrings.korea,
                    style: TextStyle(
                      color: JAppColors.primary,
                      fontSize: JSizes.font20,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Search Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: JTextStrings.searchPlaceholder,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(JSizes.borderRadiusSM),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width:
                          JSizes.paddingSM), // Space between input and button
                  SizedBox(
                    height: 52,
                    width: 52,
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JAppColors.primary, // Purple color
                        padding:
                            EdgeInsets.zero, // Ensure no additional padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(JSizes.borderRadiusSM),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 24, // Set an appropriate size for the icon
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
              child: Text(JTextStrings.topRecommendations,
                  style: TextStyle(
                      fontSize: JSizes.font16,
                      fontWeight: FontWeight.bold,
                      color: JAppColors.textPrimary)),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
              child: RoundedImage(
                fit: BoxFit.cover,
                borderRadius: JSizes.borderRadiusMD,
                width: double.infinity,
                height: 210,
                applyImageRadius: true,
                imageUrl: JImage_strings.jobfairImage,
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 25),

            // ----------- CAtegories Section -----------
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
                child: Sectionheader(
                    sectionTextButton: JTextStrings.showAllButton,
                    sectionHeader: JTextStrings.exploreCollection,
                    callback: () {})),
            const SizedBox(height: 25),

            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
                child: categoriesAsyncValue.when(
                  data: (categories) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: categories.take(4).map((category) {
                        return CategoryCard(
                            iconPath: category.icon,
                            title: category.name,
                            onTap: () {});
                      }).toList(),
                    );
                  },
                  error: (err, _) => Text('An error occured: $err'),
                  loading: () => const CircularProgressIndicator(),
                )),
            const SizedBox(
              height: 25,
            ),

            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
                child: Sectionheader(
                    sectionTextButton: JTextStrings.showAllButton,
                    sectionHeader: JTextStrings.newPostedJpbs,
                    callback: () {})),

            const SizedBox(
              height: 25,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
              child: jobsAsyncValue.when(
                data: (jobs) {

                  return Column(
                    children: jobs.map((job) {
                      return Column(
                        children: [
                          JobCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailPage(job: job),
                                ),
                              );
                            },
                            companyLogo: job.companyLogoUrl,
                            companyName: job.companyName,
                            jobTitle: job.title,
                            jobType: job.employmentType,
                            level: 'Entry Level',
                            location: job.location,
                            daysLeft:
                                'D${DateTime.now().difference(job.expiresAt).inDays}',
                            onBookmarkPressed: () {
                              // Handle bookmark action
                            },
                            companyDescription: job.companyIndustry,
                          ),
                          const SizedBox(height: 16), // Add vertical spacing
                        ],
                      );
                    }).toList(),
                  );
                },
                error: (err, _) => Text('An error occurred: $err'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),

            // Add more JobCards as needed
          ],
        ),
      ),
    );
  }
}
