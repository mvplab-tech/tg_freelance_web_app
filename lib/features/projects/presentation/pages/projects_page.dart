import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/app_routes.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Projects',
          style: context.styles.header2,
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                context.push(AppRoutes.profile.path);
              },
              icon: const Icon(Icons.person_4)),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text(
          '+',
          style: context.styles.header2,
        ),
      ),
      body: Center(),
    );
  }
}
