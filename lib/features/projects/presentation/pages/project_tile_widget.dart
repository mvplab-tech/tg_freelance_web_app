import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';

class ProjectTile extends StatelessWidget {
  final ProjectEntity entity;
  const ProjectTile({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          projectBloc.add(ProjectOpenProject(entity: entity));
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            // color: context.theme.colorScheme.onPrimaryFixedVariant,
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: SvgPicture.asset(
                    entity.projectType.getAsset(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          // desc,
                          entity.projectName,
                          style: context.styles.header2,
                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entity.description,
                          style: context.styles.body2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          // softWrap: false,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  entity.budget.amount.toString().length >= 5
                      // ? ''
                      ? '${entity.budget.uiString().substring(0, 7)}...'
                      : entity.budget.uiString(),
                  style: context.styles.header2,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
