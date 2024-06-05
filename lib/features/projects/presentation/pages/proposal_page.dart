import 'package:flutter/material.dart';
import 'package:tg_freelance/core/constants/directus_collections.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';
import 'package:tg_freelance/features/projects/presentation/pages/project_page/project_page.dart';
import 'package:tg_freelance/features/projects/presentation/widgets/proposal_tile.dart';
import 'package:tg_freelance/features/user/domain/user_entity.dart';

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
              Row(
                children: [
                  Text(
                    '${project.date.day}.${project.date.month}.${project.date.year}',
                    style: context.styles.body1,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const StatusWidget(),
                  const Spacer(),
                  Text(
                    '${project.proposals?.length ?? 0} proposals',
                    style: context.styles.body1,
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                project.projectName,
                style: context.styles.header2,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                project.projectType.getName(),
                style: context.styles.body1
                    .copyWith(color: context.theme.highlightColor),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('Budget:', style: context.styles.body1),
                  const SizedBox(
                    width: 8,
                  ),
                  BudgetWidget(budget: project.budget)
                ],
              ),
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: directus.readOne(
          collection: DirectusCollections.usersCollection,
          id: widget.prop.authorId.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FreelancerProfile author =
              UserEntity.fromMap(snapshot.data!).freelancerProfile!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Freelancer profile',
                style: context.styles.header2,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                author.occupation.getOccupation(),
                style: context.styles.body1,
              ),
              const SizedBox(
                height: 16,
              ),
              if (author.aboutMeFreelancer.isNotEmpty) ...[
                DescriptionWidget(text: author.aboutMeFreelancer),
                const SizedBox(
                  height: 16,
                ),
              ],
              Text(
                'Skills',
                style: context.styles.header2,
              ),
              const SizedBox(
                height: 16,
              ),
              SkillsDisplay(
                  expert: author.expertiseLevel, skills: author.skills),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Show contacts',
                      style: context.styles.body2,
                    )),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
