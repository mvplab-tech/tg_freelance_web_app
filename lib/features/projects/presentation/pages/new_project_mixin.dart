part of 'new_project_page.dart';

mixin NewProjectMixin on State<CreateProject> {
  ProjectType? type;
  List<String> skills = [];
  ExpertiseLevel? lvl;
  bool isEdit = false;

  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    isEdit = widget.editData?.project != null;

    nameController =
        TextEditingController(text: widget.editData?.project.projectName)
          ..addListener(listener);
    amountController = TextEditingController(
        text: widget.editData?.project.budget.amount.toString())
      ..addListener(listener);
    descriptionController =
        TextEditingController(text: widget.editData?.project.description)
          ..addListener(listener);

    if (isEdit) {
      type = widget.editData!.project.projectType;
      lvl = widget.editData!.project.expertiseLevel;
      skills = widget.editData!.project.skills;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void listener() {
    setState(() {});
    // isButtonAvailable();
  }

  bool isButtonAvailable() {
    return type != null &&
        nameController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        skills.isNotEmpty &&
        lvl != null;
  }

  void buttonAction() {
    ProjectEntity en = ProjectEntity(
      author: LiteUserEntity(
        dirId: userbloc.state.authorizedUser.dirId,
        userName: userbloc.state.authorizedUser.userName,
        userPicUrl: '',
        amountOfProjects: projectBloc.state.usersProjects.length,
      ),
      // authorId: userbloc.state.authorizedUser.dirId.toString(),
      projectName: nameController.text.trim(),
      date: DateTime.now(),
      budget: BudgetClass(
        amount: int.parse(amountController.text.trim()),
        currency: '\$',
      ),
      projectType: type!,
      description: descriptionController.text.trim(),
      expertiseLevel: lvl!,
      dirId: '0',
      skills: skills,
    );
    if (!isEdit) {
      projectBloc.add(ProjectCreateNew(project: en));
    } else {
      projectBloc.add(EditProjectEvent(
          projectEntity: en.copyWith(dirId: widget.editData!.project.dirId)));
    }
  }
}
