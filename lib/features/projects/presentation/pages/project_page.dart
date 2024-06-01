// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_state.dart';
import 'package:tg_freelance/features/user/domain/lite_user_entity.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_state.dart';

class ProjectPage extends StatelessWidget {
  final ProjectPageData data;
  const ProjectPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProjectEntity project = data.entity;
    LiteUserEntity author = data.author;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        bloc: projectBloc,
        builder: (context, state) {
          if (state.status != Status.loading) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        const _StatusWidget(),
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
                        _BudgetWidget(budget: project.budget)
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _DescriptionWidget(text: project.description),
                    const SizedBox(
                      height: 16,
                    ),
                    _SkillsDisplay(
                        expert: project.expertiseLevel, skills: project.skills),
                    const SizedBox(
                      height: 16,
                    ),
                    if (!data.isMe) ...[
                      _AuthorAndMakeProposal(
                        projectId: project.dirId,
                        author: author,
                        props: data.entity.proposals,
                      )
                    ],
                    if (data.isMe) ...[_EditAndProposals(project: data.entity)]
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _StatusWidget extends StatelessWidget {
  const _StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          'active',
          style: context.styles.caption1,
        ),
      )),
    );
  }
}

class _BudgetWidget extends StatelessWidget {
  final BudgetClass budget;
  const _BudgetWidget({
    Key? key,
    required this.budget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.colorScheme.onPrimary),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          budget.uiString(),
          style: context.styles.body1,
        ),
      )),
    );
  }
}

class _DescriptionWidget extends StatefulWidget {
  final String text;
  const _DescriptionWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<_DescriptionWidget> createState() => __DescriptionWidgetState();
}

class __DescriptionWidgetState extends State<_DescriptionWidget> {
  bool isExpanded = false;
//   final String desc = '''
// Индекс kP (или K-индекс) является логарифмической шкалой для оценки геомагнитной активности. Он измеряет возмущения горизонтальной компоненты магнитного поля Земли и варьируется от 0 до 9, где 0 соответствует спокойной геомагнитной активности, а 9 — экстремально сильной буре. Для преобразования амплитуды геомагнитной возмущенности, измеренной в нанотеслах (нТл), в kP индекс, существуют эмпирические соотношения, но точное преобразование не всегда однозначно из-за логарифмической природы kP индекса. Событие Кэррингтона в 1859 году является самой мощной зарегистрированной геомагнитной бурей. Согласно оценкам, K-индекс для этой бури достигал 9, что является максимальным значением на шкале kP. Этот индекс соответствует экстремально сильной геомагнитной активности.
// ''';

  @override
  Widget build(BuildContext context) {
    final String _text = widget.text.length >= 300
        ? '${widget.text.substring(0, 301)}...'
        : widget.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          !isExpanded ? _text : widget.text,
          // widget.text.substring(0),
          style: context.styles.body1,
        ),
        if (widget.text.length >= 300) ...[
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Less' : 'Read more...',
              style: context.styles.body2
                  .copyWith(decoration: TextDecoration.underline),
            ),
          )
        ]
      ],
    );
  }
}

class _SkillsDisplay extends StatelessWidget {
  final ExpertiseLevel expert;
  final List<String> skills;
  const _SkillsDisplay({
    Key? key,
    required this.expert,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        Chip(
          backgroundColor: context.theme.colorScheme.onPrimary,
          label: Text(
            expert.getName(),
            style: context.styles.caption1,
          ),
        ),
        ...skills.map((skill) {
          return Chip(
              // backgroundColor: Colors.transparent,
              label: Text(
            skill,
            style: context.styles.caption1,
          ));
        })
      ],
    );
  }
}

class _AuthorAndMakeProposal extends StatefulWidget {
  final LiteUserEntity author;
  final String projectId;
  final List<ProposalEntity>? props;
  const _AuthorAndMakeProposal({
    Key? key,
    required this.author,
    required this.projectId,
    required this.props,
  }) : super(key: key);

  @override
  State<_AuthorAndMakeProposal> createState() => _AuthorAndMakeProposalState();
}

class _AuthorAndMakeProposalState extends State<_AuthorAndMakeProposal> {
  late TextEditingController proposal;
  bool isButtonAvailable = false;
  bool didIRespond = false;
  ProposalEntity? prop;

  @override
  void initState() {
    proposal = TextEditingController()..addListener(listener);
    if (widget.props?.isNotEmpty ?? false) {
      for (ProposalEntity projProp in widget.props!) {
        if (projProp.authorId == userbloc.state.authorizedUser.dirId) {
          setState(() {
            didIRespond = true;
            prop = projProp;
          });
          break;
        } else {
          setState(() {
            didIRespond = true;
          });
          break;
        }
      }
    }
    super.initState();
  }

  void listener() {
    setState(() {
      isButtonAvailable = proposal.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    proposal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Client',
                  style: context.styles.caption1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.author.userName,
                  style: context.styles.body2,
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${widget.author.amountOfProjects} projects posted',
          style: context.styles.body2,
        ),
        const SizedBox(
          height: 32,
        ),
        if (didIRespond) ...[
          Text(
            'Your proposal',
            style: context.styles.header2,
          ),
          const SizedBox(
            height: 8,
          ),
          _ProposalTile(prop: prop!)
        ],
        if (!didIRespond) ...[
          Text(
            'Make proposal',
            style: context.styles.header2,
          ),
          if (userbloc.state.isFreelancerFilled) ...[
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 150,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Im great for this job because...'),
                  maxLines: 4,
                  maxLength: 500,
                  controller: proposal,
                )),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonAvailable
                    ? () {
                        projectBloc.add(
                          ProjectSubmitProposal(
                            coverLetter: proposal.text.trim(),
                            projectId: int.parse(widget.projectId),
                          ),
                        );
                      }
                    : () {},
                child: Text(
                  'Submit',
                  style: context.styles.header2,
                ),
                style: ButtonStyle(
                  // padding: WidgetStatePropertyAll(value),
                  backgroundColor: isButtonAvailable
                      ? WidgetStatePropertyAll(Colors.green)
                      : WidgetStatePropertyAll(Colors.grey),
                ),
              ),
            ),
          ]
        ],
        if (!userbloc.state.isFreelancerFilled) ...[
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Before making any proposals, you should fill out your freelancer profile',
              style: context.styles.body2,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ],
    );
  }
}

class _EditAndProposals extends StatelessWidget {
  final ProjectEntity project;
  const _EditAndProposals({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.grey)),
              onPressed: () {},
              child: Text(
                'Edit',
                style: context.styles.body1,
              )),
        ),
        if (project.proposals?.isNotEmpty ?? false) ...[
          const SizedBox(
            height: 16,
          ),
          Text(
            'Proposals',
            style: context.styles.header2,
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: project.proposals!.length,
            itemBuilder: (context, index) {
              return _ProposalTile(
                prop: project.proposals![index],
              );
            },
          )
        ],
      ],
    );
  }
}

class _ProposalTile extends StatelessWidget {
  final ProposalEntity prop;
  const _ProposalTile({
    Key? key,
    required this.prop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Container(
        // color: Colors.amber,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    prop.authorName,
                    style: context.styles.body1,
                  ),
                  const Spacer(),
                  Text(
                    '${prop.date.day}.${prop.date.month}.${prop.date.year}',
                    style: context.styles.body1,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      prop.coverLetter,
                      style: context.styles.body2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
