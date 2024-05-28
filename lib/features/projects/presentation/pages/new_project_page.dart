import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_state.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  ProjectType? type;

  @override
  Widget build(BuildContext context) {
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
                      const TextField(
                        maxLength: 150,
                        decoration:
                            InputDecoration(hintText: 'Develop an app, e.g.'),
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
                      Text(
                        'Project budget',
                        style: context.styles.body1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                            width: MediaQuery.sizeOf(context).width - 200,
                            child: TextField(),
                          ),
                          Text('\$\$\$')
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
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'There is an app, waiting to be done...',
                        ),
                        maxLines: 4,
                        maxLength: 500,
                        // controller: widget.aboutController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          print(result?.files.first);
                        },
                        child: const Text('Open file'),
                      )
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
