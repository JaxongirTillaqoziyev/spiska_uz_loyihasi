class AllValidators {
  static final AllValidators _instance = AllValidators.init();
  static AllValidators get instance => _instance;
  AllValidators.init();

  String? phoneNumberValidator(String? content) {
    if (content!.isEmpty) {
      return 'iltimos raqam kiriting';
    } else if (content.length < 12) {
      return 'raqamni to\'liq kiriting';
    } else {
      return null;
    }
  }
}
