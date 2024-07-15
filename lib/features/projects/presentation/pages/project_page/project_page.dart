// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/extensions/date_extension.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/core/widgets/buttons.dart';
import 'package:tg_freelance/core/widgets/card.dart';
import 'package:tg_freelance/core/widgets/text_field.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_state.dart';
import 'package:tg_freelance/features/projects/presentation/widgets/proposal_tile.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';
import 'package:tg_freelance/features/ton/presentation/wallets_bottom_sheet.dart';
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
                    _MainData(project: project),
                    const SizedBox(height: 16),
                    _SecondaryData(project: project),
                    const SizedBox(height: 16),
                    DescriptionWidget(text: project.description),
                    const SizedBox(height: 16),
                    if (!data.isMe)
                      _AuthorAndMakeProposal(author: author, project: project),
                    if (data.isMe) _EditAndProposals(project: project)
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

class _MainData extends StatelessWidget {
  final ProjectEntity project;
  const _MainData({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PulseCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            project.projectName,
            style: context.styles.title3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: [
              ...project.skills.map((skill) {
                return Chip(label: Text(skill));
              }).toList()
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            project.proposals != null && project.proposals!.isNotEmpty
                ? '${project.date.timeAgo()} • ${project.proposals?.length} Applicants'
                : project.date.timeAgo(),
            style: context.styles.subheadline2
                .copyWith(color: const Color(0xff8E8E93)),
          ),
        ],
      ),
    );
  }
}

class _SecondaryData extends StatelessWidget {
  final ProjectEntity project;
  const _SecondaryData({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallDisplay(context,
                    title: 'Budget',
                    subtitle: project.budget.uiString(),
                    iconColor: const Color(0xff34C759).withOpacity(0.1),
                    icon: const Icon(
                      Icons.payment,
                      color: Color(0xff34C759),
                    )),
                const SizedBox(
                  width: 6,
                ),
                smallDisplay(context,
                    title: 'Skill',
                    subtitle: project.expertiseLevel.getName(),
                    iconColor: const Color(0xffFF9500).withOpacity(0.1),
                    icon: const Icon(
                      Icons.star_outline,
                      color: Color(0xffFF9500),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallDisplay(context,
                    title: 'Project Status',
                    subtitle: 'Active',
                    iconColor: const Color(0xff32ADE6).withOpacity(0.1),
                    icon: const Icon(
                      Icons.file_copy,
                      color: Color(0xff32ADE6),
                    )),
                const SizedBox(
                  width: 6,
                ),
                smallDisplay(context,
                    title: 'Location',
                    subtitle: 'Worldwide',
                    iconColor: const Color(0xff5856D6).withOpacity(0.1),
                    icon: const Icon(
                      Icons.star_outline,
                      color: Color(0xff5856D6),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget smallDisplay(BuildContext context,
      {required String title,
      required String subtitle,
      required Color iconColor,
      required Icon icon}) {
    return Expanded(
      child: PulseCard(
          child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: iconColor, borderRadius: BorderRadius.circular(10)),
            child: icon,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.styles.caption1,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                subtitle,
                style: context.styles.headline,
              )
            ],
          )
        ],
      )),
    );
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

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

class BudgetWidget extends StatelessWidget {
  final BudgetClass budget;
  const BudgetWidget({
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
          style: context.styles.body,
        ),
      )),
    );
  }
}

class DescriptionWidget extends StatefulWidget {
  final String text;
  final String? title;
  const DescriptionWidget({
    Key? key,
    required this.text,
    this.title,
  }) : super(key: key);

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool isExpanded = false;
//   final String desc = '''
// Индекс kP (или K-индекс) является логарифмической шкалой для оценки геомагнитной активности. Он измеряет возмущения горизонтальной компоненты магнитного поля Земли и варьируется от 0 до 9, где 0 соответствует спокойной геомагнитной активности, а 9 — экстремально сильной буре. Для преобразования амплитуды геомагнитной возмущенности, измеренной в нанотеслах (нТл), в kP индекс, существуют эмпирические соотношения, но точное преобразование не всегда однозначно из-за логарифмической природы kP индекса. Событие Кэррингтона в 1859 году является самой мощной зарегистрированной геомагнитной бурей. Согласно оценкам, K-индекс для этой бури достигал 9, что является максимальным значением на шкале kP. Этот индекс соответствует экстремально сильной геомагнитной активности.
// ''';

  @override
  Widget build(BuildContext context) {
    final String _text = widget.text.length >= 300
        ? '${widget.text.substring(0, 301)}...'
        : widget.text;
    return PulseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? 'Job description',
            style: context.styles.headline,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            !isExpanded ? _text : widget.text,
            // widget.text.substring(0),
            style: context.styles.body.copyWith(color: const Color(0xff8E8E93)),
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
                style: context.styles.body
                    .copyWith(decoration: TextDecoration.underline),
              ),
            )
          ]
        ],
      ),
    );
  }
}

class _AuthorAndMakeProposal extends StatefulWidget {
  final LiteUserEntity author;
  final ProjectEntity project;
  // final List<ProposalEntity>? props;
  const _AuthorAndMakeProposal({
    Key? key,
    required this.author,
    required this.project,
    // required this.props,
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
    if (widget.project.proposals?.isNotEmpty ?? false) {
      for (ProposalEntity projProp in widget.project.proposals!) {
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
    return BlocBuilder<TonBloc, TonState>(
      bloc: tonBloc,
      builder: (context, tonState) {
        return PulseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     const CircleAvatar(
              //       backgroundColor: Colors.grey,
              //       child: Icon(Icons.person),
              //     ),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Client',
              //           style: context.styles.caption1,
              //         ),
              //         const SizedBox(
              //           height: 4,
              //         ),
              //         Text(
              //           widget.author.userName,
              //           style: context.styles.body,
              //         )
              //       ],
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Text(
              //   '${widget.author.amountOfProjects} projects posted',
              //   style: context.styles.body,
              // ),
              // const SizedBox(
              //   height: 32,
              // ),
              if (didIRespond) ...[
                Text(
                  'Your proposal',
                  style: context.styles.headline,
                ),
                const SizedBox(
                  height: 8,
                ),
                ProposalTile(
                  prop: prop!,
                  project: null,
                  needsOnPress: false,
                )
              ],
              if (!didIRespond) ...[
                Text(
                  'Make proposal',
                  style: context.styles.headline,
                ),
                if (userbloc.state.isFreelancerFilled &&
                    tonState.account != null &&
                    tonState.connector != null) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  PulseTextField(
                      hintText: 'Im great for this job because...',
                      controller: proposal),
                  // SizedBox(
                  //     height: 150,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           color: const Color(0xffF2F2F7),
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: TextField(
                  //         keyboardType: TextInputType.text,
                  //         decoration: const InputDecoration(
                  //             // fillColor: ,
                  //             border: OutlineInputBorder(
                  //                 borderSide: BorderSide.none,
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10))),
                  //             hintText: ),
                  //         maxLines: 6,
                  //         maxLength: 1000,
                  //         controller: proposal,
                  //         buildCounter: (context,
                  //             {required currentLength,
                  //             required isFocused,
                  //             required maxLength}) {
                  //           return const SizedBox.shrink();
                  //         },
                  //       ),
                  //     )),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 50,
                        child: PulseButton(
                            isLoading:
                                projectBloc.state.status == Status.loading,
                            enabled: isButtonAvailable,
                            text: 'Submit',
                            action: () {
                              projectBloc.add(
                                ProjectSubmitProposal(
                                  coverLetter: proposal.text.trim(),
                                  entity: widget.project,
                                  // projectId: int.parse(widget.projectId),
                                ),
                              );
                            })),
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
                    style: context.styles.footnote,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
              if (userbloc.state.isFreelancerFilled)
                BlocBuilder<TonBloc, TonState>(
                  bloc: tonBloc,
                  builder: (context, state) {
                    if (state.account != null &&
                        state.connector != null &&
                        state.connector!.connected) {
                      return const SizedBox.shrink();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Before creating new project, you should be connected to TON. Please, tap below.',
                            style: context.styles.body,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          PulseButton(
                              isLoading: false,
                              enabled: true,
                              text: 'Connect',
                              action: () {
                                showWalletsBottomSheet(
                                    context, 'Connect to TON:');
                              })
                        ],
                      );
                    }
                  },
                )
            ],
          ),
        );
      },
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
            child: PulseButton(
                isLoading: false,
                enabled: true,
                text: 'Edit',
                action: () {
                  context.push(AppRoutes.createProject.path,
                      extra: EditProjectData(project: project));
                })),
        if (project.proposals?.isNotEmpty ?? false) ...[
          const SizedBox(
            height: 16,
          ),
          Text(
            'Proposals',
            style: context.styles.headline,
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: project.proposals!.length,
            itemBuilder: (context, index) {
              return ProposalTile(
                prop: project.proposals![index],
                project: project,
                needsOnPress: true,
              );
            },
          )
        ],
      ],
    );
  }
}
