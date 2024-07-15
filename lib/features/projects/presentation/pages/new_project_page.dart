// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/core/widgets/buttons.dart';
import 'package:tg_freelance/core/widgets/card.dart';
import 'package:tg_freelance/core/widgets/text_field.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_state.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';
import 'package:tg_freelance/features/ton/presentation/wallets_bottom_sheet.dart';
import 'package:tg_freelance/features/user/domain/lite_user_entity.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_state.dart';

part 'new_project_mixin.dart';

class CreateProject extends StatefulWidget {
  final EditProjectData? editData;
  const CreateProject({
    Key? key,
    this.editData,
  }) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> with NewProjectMixin {
  @override
  Widget build(BuildContext context) {
    bool butisok = isButtonAvailable();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit project' : 'New project',
          style: context.styles.title3,
        ),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        // color
        actions: isEdit
            ? [
                IconButton(
                    onPressed: () {
                      projectBloc.add(DeleteProject(
                          projectEntity: widget.editData!.project));
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    )),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<TonBloc, TonState>(
          bloc: tonBloc,
          builder: (context, tonState) {
            return Container(
              child: userbloc.state.isClientFilled
                  ? tonState.account != null || !kDebugMode
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            DisplayWidget(
                              label: 'Project name:',
                              child: PulseTextField(
                                hintText: 'Develop an app, e.g.',
                                controller: nameController,
                                height: 50,
                                showCounter: false,
                                maxLength: 150,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DisplayWidget(
                              label: 'Project Type',
                              child: Wrap(
                                runSpacing: 8,
                                spacing: 8,
                                children: ProjectType.values.map((typ) {
                                  return FilterChip(
                                    selectedColor: const Color(0xff007AFF)
                                        .withOpacity(0.3),
                                    label: Text(
                                      typ.getName(),
                                      style: context.styles.caption1,
                                    ),
                                    selected: type == typ,
                                    onSelected: (v) {
                                      setState(() {
                                        type = typ;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (type != null) ...[
                              DisplayWidget(
                                label: 'Required skills',
                                child: Wrap(
                                    runSpacing: 8,
                                    spacing: 8,
                                    children: type!.skills.map((skill) {
                                      return FilterChip(
                                        selectedColor: const Color(0xff007AFF)
                                            .withOpacity(0.3),
                                        label: Text(
                                          skill,
                                          style: context.styles.caption1,
                                        ),
                                        selected: skills.contains(skill),
                                        onSelected: (v) {
                                          setState(() {
                                            skills.contains(skill)
                                                ? skills.remove(skill)
                                                : skills.add(skill);
                                          });
                                        },
                                      );
                                    }).toList()),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                            DisplayWidget(
                              label: 'Required exprtise level',
                              child: Wrap(
                                runSpacing: 8,
                                spacing: 8,
                                children: ExpertiseLevel.values.map((exp) {
                                  return FilterChip(
                                    selectedColor: const Color(0xff007AFF)
                                        .withOpacity(0.3),
                                    label: Text(
                                      exp.getName(),
                                      style: context.styles.caption1,
                                    ),
                                    selected: lvl == exp,
                                    onSelected: (v) {
                                      setState(() {
                                        lvl = exp;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DisplayWidget(
                              label: 'Project budget',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.sizeOf(context).width - 200,
                                    child: PulseTextField(
                                      hintText: '',
                                      controller: amountController,
                                      inputType: TextInputType.number,
                                      height: 40,
                                      showCounter: false,
                                      maxLength: 150,
                                      maxLines: 1,
                                      formatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '\$\$\$',
                                    style: context.styles.title2,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DisplayWidget(
                              label: 'Project description',
                              child: PulseTextField(
                                  inputType: TextInputType.text,
                                  maxLines: 4,
                                  maxLength: 1000,
                                  hintText:
                                      'There is an app, waiting to be done...',
                                  controller: descriptionController),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            BlocBuilder<ProjectBloc, ProjectState>(
                              bloc: projectBloc,
                              builder: (context, state) {
                                return SizedBox(
                                  height: 50,
                                  child: PulseButton(
                                    isLoading: state.status == Status.loading,
                                    enabled: butisok,
                                    text: isEdit ? 'Update' : 'Post',
                                    action: buttonAction,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        )
                      : Column(
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
                        )
                  : Center(
                      child: Text(
                      'Before creating new project, you should fill out your client profile.',
                      style: context.styles.body,
                    )),
            );
          },
        ),
      ),
    );
  }
}
