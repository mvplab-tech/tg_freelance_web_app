// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/core/widgets/buttons.dart';
import 'package:tg_freelance/core/widgets/card.dart';
import 'package:tg_freelance/core/widgets/text_field.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'My profile',
          style: context.styles.title2,
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userbloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                DisplayWidget(
                  label: 'My name',
                  child: PulseTextField(
                    height: 50,
                    maxLength: 100,
                    showCounter: false,
                    maxLines: 1,
                    hintText: 'Current: ${state.authorizedUser.userName}',
                    controller: nameController,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DisplayWidget(
                    label: 'TON connection',
                    child: BlocBuilder<TonBloc, TonState>(
                      bloc: tonBloc,
                      builder: (context, state) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Text(
                                'Status:',
                                style: context.styles.body,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  tonBloc.add(TonDisconnect());
                                },
                                child: Text(
                                  state.connector?.connected ?? false
                                      ? 'Connected with ${state.connector!.wallet?.device!.appName}'
                                      : "Disconnected ",
                                  style: context.styles.body.copyWith(
                                      color: state.connector?.connected ?? false
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
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
                SizedBox(
                  height: 50,
                  child: PulseButton(
                    isLoading: state.status == Status.loading,
                    enabled: isButtonAvailable,
                    text: 'Update',
                    action: buttonAction,
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
            DisplayWidget(
                label: 'I am',
                child: DropdownMenu(
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
                )),
            const SizedBox(
              height: 16,
            ),
            DisplayWidget(
                label: 'Experience',
                child: DropdownMenu(
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
                )),
            const SizedBox(
              height: 16,
            ),
            if (profession != null) ...[
              DisplayWidget(
                label: 'Skills',
                height: profession != null ? 8 : 16,
                child: Wrap(
                  runSpacing: 8,
                  spacing: 9,
                  children: profession!.skills.map((item) {
                    return ChoiceChip(
                      selectedColor: const Color(0xff007AFF).withOpacity(0.3),
                      label: Text(
                        item,
                        style: context.styles.body,
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
              ),
              const SizedBox(
                height: 16,
              )
            ],
            DisplayWidget(
              label: 'About me',
              child: PulseTextField(
                hintText: fr == null
                    ? 'Few words about you...'
                    : fr!.aboutMeFreelancer,
                controller: widget.aboutController,
                maxLines: 4,
                maxLength: 500,
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
          height: 8,
        ),
        DisplayWidget(
          label: 'About me',
          child: PulseTextField(
            hintText: client == null
                ? 'Few words about you...'
                : client!.aboutMeClient,
            controller: widget.aboutController,
            maxLines: 4,
            maxLength: 500,
          ),
        )
      ],
    );
  }
}
