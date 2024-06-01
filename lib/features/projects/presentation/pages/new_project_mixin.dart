part of 'new_project_page.dart';

mixin NewProjectMixin on State<CreateProject> {
  ProjectType? type;
  List<String> skills = [];
  ExpertiseLevel? lvl;

  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    nameController = TextEditingController()..addListener(listener);
    amountController = TextEditingController()..addListener(listener);
    descriptionController = TextEditingController()..addListener(listener);
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
}
