// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/extensions/date_extension.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/widgets/card.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';

class ProposalTile extends StatelessWidget {
  final ProposalEntity prop;
  final ProjectEntity? project;
  final bool needsOnPress;

  final bool? showWholeText;
  const ProposalTile({
    Key? key,
    required this.prop,
    required this.project,
    required this.needsOnPress,
    this.showWholeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: needsOnPress
            ? () {
                context.push(
                  AppRoutes.proposalPage.path,
                  extra: ProposalPageData(
                    project: project!,
                    proposal: prop,
                  ),
                );
              }
            : null,
        child: PulseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox.square(
                    dimension: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    prop.authorName,
                    style: context.styles.body,
                  ),
                  const Spacer(),
                  Text('${prop.date.day} ${prop.date.monthName()}',
                      style: context.styles.subheadline1
                          .copyWith(color: const Color(0xff8E8E93)))
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    prop.coverLetter,
                    // 'sl;dfkklsadjfkl;asjdfb samd,hf klash ,ajsdv luhr,mancv kjgherluh kxjv,zxfjv,mzbnvla kreubleiwuvzkxjvndslkjrghweriugh34oop asd ;lkfajds lkds f;lkas,dlasjfd asjeif 23ksjfnv v,mxcnb vrluhg ih',
                    style: context.styles.footnote,
                    maxLines: showWholeText ?? false ? 100 : 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
