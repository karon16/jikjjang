import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/common/widgets/appbar/appbar.dart';
import 'package:jikjjang_app/common/widgets/cards/job_card.dart';
import 'package:jikjjang_app/data/models/job_model.dart';
import 'package:jikjjang_app/data/providers/job_providers.dart';
import 'package:jikjjang_app/features/job_seeker/jobs/views/job_details.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  String _searchQuery = '';
  bool _isSearching = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final jobsAsyncValue = _searchQuery.isEmpty
        ? ref.watch(jobSeekersProvider)
        : ref.watch(searchJobsProvider(_searchQuery));

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: JAppBar(
          showBackArrow: false,
          title: _isSearching
              ? SizedBox(
                  height: 30, // Height for the container
                  child: Center(
                    child: TextField(
                      focusNode: _focusNode,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Search jobs by title...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none, // Remove all borders
                        focusedBorder: InputBorder.none, // Remove focus border
                        enabledBorder:
                            InputBorder.none, // Remove enabled border
                        disabledBorder:
                            InputBorder.none, // Remove disabled border
                      ),
                      style: const TextStyle(color: Colors.black),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                )
              : const Text("Jobs"),
          actions: [
            if (_isSearching)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                    _isSearching = false;
                  });
                  _focusNode.unfocus();
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                  _focusNode.requestFocus();
                },
              ),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50), // Adjust height for TabBar
            child: TabBar(
              isScrollable: true,
              indicatorColor: JAppColors.primary,
              unselectedLabelColor: JAppColors.textSecondary,
              labelColor: JAppColors.primary,
              tabs: [
                Tab(child: Text("AI Suggestion")),
                Tab(child: Text("Region")),
                Tab(child: Text("Job")),
                Tab(child: Text("My search")),
                Tab(child: Text("Top100")),
              ],
            ),
          ),
          onLeadingPressed: () {
            if (_isSearching) {
              setState(() {
                _isSearching = false;
                _searchQuery = '';
              });
              _focusNode.unfocus();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: TabBarView(
          children: [
            JobScrollView(jobsAsyncValue: jobsAsyncValue),
            JobScrollView(jobsAsyncValue: jobsAsyncValue),
            JobScrollView(jobsAsyncValue: jobsAsyncValue),
            JobScrollView(jobsAsyncValue: jobsAsyncValue),
            JobScrollView(jobsAsyncValue: jobsAsyncValue),
          ],
        ),
      ),
    );
  }
}

class JobScrollView extends StatelessWidget {
  const JobScrollView({
    super.key,
    required this.jobsAsyncValue,
  });

  final AsyncValue<List<Job>> jobsAsyncValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: JSizes.paddingMD),
        child: jobsAsyncValue.when(
          data: (jobs) {
            if (jobs.isEmpty) {
              return const Center(child: Text("No jobs found."));
            }
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
          error: (err, _) => Center(
            child: Text(
              'An error occurred: $err',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
