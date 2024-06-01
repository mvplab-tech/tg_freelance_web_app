import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_state.dart';

part 'new_project_mixin.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> with NewProjectMixin {
  @override
  Widget build(BuildContext context) {
    bool butisok = isButtonAvailable();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New project',
            style: context.styles.header2,
          ),
          centerTitle: false,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: userbloc.state.isClientFilled
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
                          hintText: 'There is an app, waiting to be done...',
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        maxLength: 500,
                        // controller: widget.aboutController,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      if (butisok)
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                projectBloc.add(
                                  ProjectCreateNew(
                                    project: ProjectEntity(
                                      authorId: userbloc
                                          .state.authorizedUser.dirId
                                          .toString(),
                                      projectName: nameController.text.trim(),
                                      date: DateTime.now(),
                                      budget: BudgetClass(
                                        amount: int.parse(
                                            amountController.text.trim()),
                                        currency: '\$',
                                      ),
                                      projectType: type!,
                                      description:
                                          descriptionController.text.trim(),
                                      expertiseLevel: lvl!,
                                      dirId: '0',
                                      skills: skills,
                                    ),
                                  ),
                                );
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.green)),
                              child: Text(
                                'done',
                                style: context.styles.body1,
                              )),
                        )
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     FilePickerResult? result =
                      //         await FilePicker.platform.pickFiles();
                      //     // print(result?.files);
                      //     await directus.uploadFile(file: result!.files.first);
                      //   },
                      //   child: const Text('Open file'),
                      // )
                    ],
                  )
                : Center(
                    child: Text(
                      'Before creating new project, you should fill out your client profile.',
                      style: context.styles.body1,
                    ),
                  ),
          ),
        ));
  }
}
