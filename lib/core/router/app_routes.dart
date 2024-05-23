enum AppRoutes {
  createAccount('createAccount', '/createAccount'),
  projects('projects', '/projects'),
  profile('profile', '/profile'),
  splash('splash', '/splash');

  final String name;
  final String path;

  const AppRoutes(this.name, this.path);
}
