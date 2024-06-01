import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_state.dart';
import 'package:tg_freelance/features/projects/presentation/pages/project_tile_widget.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    int length = projectBloc.state.tabs.length + 1;
    tabController = TabController(length: length, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
        onPressed: () {
          context.push(AppRoutes.createProject.path);
        },
        child: Text(
          '+',
          style: context.styles.header2,
        ),
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        bloc: projectBloc,
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 16),
            child: Column(
              children: [
                if (state.tabs.isNotEmpty)
                  TabBar(
                    controller: tabController,
                    tabs: [
                      const Tab(
                        text: 'All Projects',
                      ),
                      ...state.tabs
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _AllProjects(
                        prs: state.available,
                      ),
                      if (state.usersProjects.isNotEmpty)
                        ListView.builder(
                          itemCount: state.usersProjects.length,
                          itemBuilder: (context, index) {
                            return ProjectTile(
                                entity: state.usersProjects[index]);
                          },
                        ),
                      if (state.userResponses.isNotEmpty)
                        Container(
                          color: Colors.pink,
                          child: Text('my responses'),
                        ),
                    ],
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

class _AllProjects extends StatelessWidget {
  final List<ProjectEntity> prs;
  const _AllProjects({
    Key? key,
    required this.prs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<ProjectType> prs = ;
    return ListView.builder(
      itemCount: prs.length,
      itemBuilder: (context, index) {
        return ProjectTile(entity: prs[index]);
      },
    );
  }
}
