// ignore_for_file: annotate_overrides, unnecessary_overrides, unnecessary_this

class AppLanguage {
  final String name;
  final String languageCode;

  AppLanguage(this.name, this.languageCode);

  static List<AppLanguage> languages() {
    return <AppLanguage>[
      AppLanguage('English', 'en'),
      AppLanguage('ไทย', 'th'),
      AppLanguage('ລາວ', 'lo'),
    ];
  }

  bool operator == (dynamic other) => other != null && other is AppLanguage && this.name == other.name;

  @override
  int get hashCode => super.hashCode;
}