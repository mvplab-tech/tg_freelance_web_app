part of 'edit_profile.dart';

mixin EditProfileMixin on State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController aboutFreelancerController;
  late TextEditingController aboutClientController;
  UserEntity user = userbloc.state.authorizedUser;
  bool isButtonAvailable = false;
  ProjectType? profession;
  ExpertiseLevel? expertiseLevel;
  List<String> skills = [];

  @override
  void initState() {
    nameController = TextEditingController();
    aboutClientController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    aboutFreelancerController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutClientController.dispose();
    aboutFreelancerController.dispose();
    super.dispose();
  }

  void isButtonOk() {
    if ((profession != null || user.freelancerProfile?.occupation != null) &&
        (expertiseLevel != null ||
            user.freelancerProfile?.expertiseLevel != null)) {
      setState(() {
        isButtonAvailable = true;
      });
    } else if (aboutClientController.text.isNotEmpty) {
      setState(() {
        isButtonAvailable = true;
      });
    } else {
      setState(() {
        isButtonAvailable = false;
      });
    }
  }

  bool isFormChanged() {
    bool nameChanged = nameController.text.isNotEmpty &&
        nameController.text != userbloc.state.authorizedUser.userName;

    bool aboutFrChanged = aboutFreelancerController.text.isNotEmpty &&
        aboutFreelancerController.text !=
            user.freelancerProfile?.aboutMeFreelancer;

    bool occupationChanged =
        profession != null && profession != user.freelancerProfile?.occupation;

    bool expertiseChanged = expertiseLevel != null &&
        expertiseLevel != user.freelancerProfile?.expertiseLevel;

    bool skillsChnaged =
        skills.isNotEmpty && skills != user.freelancerProfile?.skills;

    return (nameChanged ||
        aboutFrChanged ||
        occupationChanged ||
        expertiseChanged ||
        skillsChnaged);
  }

  void onProfession(ProjectType occupation) {
    setState(() {
      profession = occupation;
    });
  }

  void onExpertise(ExpertiseLevel lvl) {
    setState(() {
      expertiseLevel = lvl;
    });
  }

  void onSkills(List<String> incSkills) {
    setState(() {
      skills = incSkills;
    });
  }

  void buttonAction() {
    userbloc.add(
      UserUpdateData(
        updName: nameController.text.isNotEmpty
            ? nameController.text.trim()
            : user.userName,
        freelancer: profession != null && expertiseLevel != null
            ? FreelancerProfile(
                aboutMeFreelancer: nameController.text.isNotEmpty
                    ? aboutFreelancerController.text.trim()
                    : user.freelancerProfile?.aboutMeFreelancer ?? '',
                occupation: profession ?? user.freelancerProfile!.occupation,
                expertiseLevel:
                    expertiseLevel ?? user.freelancerProfile!.expertiseLevel,
                skills:
                    skills.isNotEmpty ? skills : user.freelancerProfile!.skills,
              )
            : null,
        client: ClientProfile(
          aboutMeClient: aboutClientController.text.isNotEmpty
              ? aboutClientController.text.trim()
              : user.clientProfile?.aboutMeClient ?? '',
        ),
      ),
    );
    // print(
    //     'name: ${nameController.text}, about freelancer: ${aboutFreelancerController.text}, profession: $profession, expertise: $expertiseLevel, skills: $skills');
  }
}
