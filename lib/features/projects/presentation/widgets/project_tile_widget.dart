import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/extensions/date_extension.dart';
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
          height: 140,
          decoration: BoxDecoration(
            // color: context.theme.colorScheme.onPrimaryFixedVariant,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              // desc,
                              entity.projectName,
                              style: context.styles.headline,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${entity.date.day} ${entity.date.monthName()}',
                            style: context.styles.subheadline1
                                .copyWith(color: const Color(0xff8E8E93)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                          text: TextSpan(
                        text: entity.budget.uiString(),
                        style: context.styles.subheadline1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff007AFF)),
                        //  children: [
                        // TextSpan(
                        //     text: '',
                        //     style: context.styles.footnote
                        //         .copyWith(color: const Color(0xff007AFF)))
                        //]
                      )),
                      // Text('', style: ),
                      const SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        child: Text(
                          entity.description,
                          style: context.styles.body,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                        ),
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   width: 8,
                // ),
                // Text(
                //   entity.budget.amount.toString().length >= 5
                //       ? '${entity.budget.uiString().substring(0, 7)}...'
                //       : entity.budget.uiString(),
                //   style: context.styles.headline,
                // ),
                // const SizedBox(
                //   width: 4,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
