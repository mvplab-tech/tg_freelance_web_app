// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';
import 'package:tg_freelance/features/user/domain/user_entity.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_state.dart';

part 'edit_profile_mixin.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin, EditProfileMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isButtonOk();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My profile',
          style: context.styles.header2,
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userbloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: 'as Freelancer',
                    ),
                    Tab(
                      text: 'as client',
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // OutlinedButton(
                //     onPressed: () {
                //       context.push(AppRoutes.wallets.path);
                //     },
                //     child: Text('wallets')),

                Text(
                  'My name',
                  style: context.styles.body1,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Current: ${state.authorizedUser.userName}'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'TON connection:',
                  style: context.styles.body1,
                ),
                BlocBuilder<TonBloc, TonState>(
                  bloc: tonBloc,
                  builder: (context, state) {
                    return SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Text(
                            'Status:',
                            style: context.styles.body2,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (state.connector != null &&
                                  state.connector!.connected) {
                                state.connector!.disconnect();
                              }
                            },
                            child: Text(
                              state.connector!.connected
                                  ? 'Connected with: ${state.connector!.wallet?.device!.appName}'
                                  : "Disconnected",
                              style: context.styles.body2.copyWith(
                                  color: state.connector!.connected
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _FreelanceTab(
                        state: state,
                        aboutController: aboutFreelancerController,
                        onProfession: onProfession,
                        onExpertise: onExpertise,
                        onSkills: onSkills,
                      ),
                      _ClientTab(
                        aboutController: aboutClientController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (isButtonAvailable)
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                        Colors.green,
                      )),
                      onPressed: state.status != Status.loading
                          ? () {
                              buttonAction();
                            }
                          : () {},
                      child: state.status != Status.loading
                          ? Text(
                              'update',
                              style: context.styles.body1,
                            )
                          : const CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FreelanceTab extends StatefulWidget {
  final UserState state;

  final TextEditingController aboutController;
  final Function(ProjectType) onProfession;
  final Function(ExpertiseLevel) onExpertise;
  final Function(List<String>) onSkills;

  const _FreelanceTab({
    Key? key,
    required this.state,
    required this.aboutController,
    required this.onProfession,
    required this.onExpertise,
    required this.onSkills,
  }) : super(key: key);
  @override
  State<_FreelanceTab> createState() => __FreelanceTabState();
}

class __FreelanceTabState extends State<_FreelanceTab> {
  FreelancerProfile? fr = userbloc.state.authorizedUser.freelancerProfile;

  ProjectType? profession;
  ExpertiseLevel? expertiseLevel;
  List<String> skills = [];

  @override
  void initState() {
    profession = fr?.occupation;
    expertiseLevel = fr?.expertiseLevel;
    skills = fr?.skills ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: userbloc,
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Text(
              'I am',
              style: context.styles.body1,
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownMenu(
              enableSearch: false,
              expandedInsets: const EdgeInsets.all(0),
              initialSelection: profession?.name,
              menuHeight: 300,
              onSelected: (value) {
                setState(() {
                  profession = ProjectType.values.byName(value as String);
                });
                widget.onProfession(profession!);
              },
              dropdownMenuEntries: ProjectType.values
                  .map((item) {
                    return DropdownMenuEntry(
                        value: item.name, label: item.getOccupation());
                  })
                  .toList()
                  .cast<DropdownMenuEntry<String>>(),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Experience',
              style: context.styles.body1,
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownMenu(
              enableSearch: false,
              expandedInsets: const EdgeInsets.all(0),
              menuHeight: 300,
              enabled: profession != null,
              initialSelection: expertiseLevel?.name,
              onSelected: (value) {
                setState(() {
                  expertiseLevel =
                      ExpertiseLevel.values.byName(value as String);
                });
                widget.onExpertise(expertiseLevel!);
              },
              dropdownMenuEntries: ExpertiseLevel.values
                  .map((item) {
                    return DropdownMenuEntry(
                      value: item.name,
                      label: item.getDescription(),
                    );
                  })
                  .toList()
                  .cast<DropdownMenuEntry<String>>(),
            ),
            const SizedBox(
              height: 16,
            ),
            if (profession != null) ...[
              Text(
                'Skills',
                style: context.styles.body1,
              ),
              SizedBox(height: profession != null ? 8 : 16),
              Wrap(
                runSpacing: 8,
                spacing: 9,
                children: profession!.skills.map((item) {
                  return ChoiceChip(
                    label: Text(
                      item,
                      style: context.styles.body2,
                    ),
                    selected: skills.contains(item),
                    onSelected: (value) {
                      setState(() {
                        skills.contains(item)
                            ? skills.remove(item)
                            : skills.add(item);
                      });
                      widget.onSkills(skills);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              )
            ],
            Text(
              'About me',
              style: context.styles.body1,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: fr == null
                      ? 'Few words about you...'
                      : fr!.aboutMeFreelancer,
                ),
                maxLines: 4,
                maxLength: 500,
                controller: widget.aboutController,
              ),
            )
          ],
        );
      },
    );
  }
}

class _ClientTab extends StatefulWidget {
  final TextEditingController aboutController;
  const _ClientTab({
    Key? key,
    required this.aboutController,
  }) : super(key: key);

  @override
  State<_ClientTab> createState() => __ClientTabState();
}

class __ClientTabState extends State<_ClientTab> {
  ClientProfile? client = userbloc.state.authorizedUser.clientProfile;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'About me',
          style: context.styles.body1,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 300,
          child: TextField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: client == null
                    ? 'Few words about you...'
                    : client!.aboutMeClient),
            maxLines: 4,
            maxLength: 500,
            controller: widget.aboutController,
          ),
        )
      ],
    );
  }
}
