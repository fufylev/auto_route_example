extension LocalizationExtension<T> on T? {
  T checkLocalization() {
    final localization = this as T;
    if (localization == null) {
      throw Exception('local of instance $T not found');
    } else {
      return localization;
    }
  }
}
