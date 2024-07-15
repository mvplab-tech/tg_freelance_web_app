import 'package:flutter/material.dart';
import 'package:tg_freelance/core/constants/directus_collections.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart';
import 'package:tg_freelance/core/widgets/buttons.dart';
import 'package:tg_freelance/core/widgets/card.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';
import 'package:tg_freelance/features/projects/presentation/pages/project_page/project_page.dart';
import 'package:tg_freelance/features/projects/presentation/widgets/proposal_tile.dart';
import 'package:tg_freelance/features/user/domain/user_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class ProposalPage extends StatelessWidget {
  final ProposalPageData data;
  const ProposalPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProjectEntity project = data.project;
    // final
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       '${project.date.day}.${project.date.month}.${project.date.year}',
              //       style: context.styles.body,
              //     ),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     const StatusWidget(),
              //     const Spacer(),
              //     Text(
              //       '${project.proposals?.length ?? 0} proposals',
              //       style: context.styles.body,
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              Text(
                project.projectName,
                style: context.styles.title3,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                project.projectType.getName(),
                style: context.styles.headline
                    .copyWith(color: const Color(0xff007AFF)),
              ),
              // const SizedBox(
              //   height: 4,
              // ),
              // Row(
              //   children: [
              //     Text('Budget:', style: context.styles.body),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     BudgetWidget(budget: project.budget)
              //   ],
              // ),
              const SizedBox(
                height: 16,
              ),
              ProposalTile(
                prop: data.proposal,
                project: data.project,
                needsOnPress: false,
                showWholeText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              _FreelancerDisplay(
                prop: data.proposal,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FreelancerDisplay extends StatefulWidget {
  final ProposalEntity prop;
  const _FreelancerDisplay({
    Key? key,
    required this.prop,
  }) : super(key: key);

  @override
  State<_FreelancerDisplay> createState() => __FreelancerDisplayState();
}

class __FreelancerDisplayState extends State<_FreelancerDisplay> {
  bool contactShown = false;
  late String link;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: directus.readOne(
          collection: DirectusCollections.usersCollection,
          id: widget.prop.authorId.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserEntity user = UserEntity.fromMap(snapshot.data!);
          FreelancerProfile author = user.freelancerProfile!;
          link = 'https://t.me/${user.tgNickname}';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Freelancer profile',
                style: context.styles.headline,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                author.occupation.getOccupation(),
                style: context.styles.body.copyWith(color: Color(0xff007AFF)),
              ),
              const SizedBox(
                height: 16,
              ),
              if (author.aboutMeFreelancer.isNotEmpty) ...[
                DescriptionWidget(
                  text: author.aboutMeFreelancer,
                  title: 'About ${user.userName}',
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
              SkillsDisplay(
                  expert: author.expertiseLevel, skills: author.skills),
              const SizedBox(
                height: 16,
              ),
              if (!contactShown)
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: PulseButton(
                    isLoading: false,
                    enabled: true,
                    text: 'Show contacts',
                    action: () {
                      setState(() {
                        contactShown = true;
                      });
                    },
                  ),
                ),
              if (contactShown)
                SizedBox(
                  height: 60,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (await canLaunchUrl(Uri.parse(link))) {
                          launchUrl(Uri.parse(link));
                        }
                      },
                      child: Text(
                        link,
                        textAlign: TextAlign.center,
                        style: context.styles.headline.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                )
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class SkillsDisplay extends StatelessWidget {
  final ExpertiseLevel expert;
  final List<String> skills;
  const SkillsDisplay({
    Key? key,
    required this.expert,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PulseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: context.styles.headline,
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 4,
            children: [
              ...skills.map((skill) {
                return Chip(label: Text(skill));
              }).toList()
            ],
          ),
        ],
      ),
    );
  }
}
