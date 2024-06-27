// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/core/widgets/buttons.dart';
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
          style: context.styles.header2,
        ),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: true,
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
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TonBloc, TonState>(
          bloc: tonBloc,
          builder: (context, tonState) {
            return Container(
              child: userbloc.state.isClientFilled
                  ? tonState.account != null || !kDebugMode
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              'Project name:',
                              style: context.styles.body1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              maxLength: 150,
                              controller: nameController,
                              decoration: const InputDecoration(
                                  hintText: 'Develop an app, e.g.'),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Project type',
                              style: context.styles.body1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              runSpacing: 8,
                              spacing: 8,
                              children: ProjectType.values.map((typ) {
                                return FilterChip(
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
                            const SizedBox(
                              height: 16,
                            ),
                            if (type != null) ...[
                              Text(
                                'Required skills',
                                style: context.styles.body1,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: type!.skills.map((skill) {
                                    return FilterChip(
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
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                            Text(
                              'Required exprtise level',
                              style: context.styles.body1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              runSpacing: 8,
                              spacing: 8,
                              children: ExpertiseLevel.values.map((exp) {
                                return FilterChip(
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
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Project budget',
                              style: context.styles.body1,
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: MediaQuery.sizeOf(context).width - 200,
                                  child: TextField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                                const Text('\$\$\$')
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Project description',
                              style: context.styles.body1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'There is an app, waiting to be done...',
                              ),
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              maxLength: 1000,
                              // controller: widget.aboutController,
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
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Before creating new project, you should be connected to TON. Please, tap below.',
                              style: context.styles.body1,
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
                      style: context.styles.body1,
                    )),
            );
          },
        ),
      ),
    );
  }
}
