mixin DefState<S> {
  S rebuild(Function(dynamic) updates);

  bool get isLoading;

  bool get isError => errorMessage?.isNotEmpty ?? false;

  String? get errorMessage;

  S setLoading(bool isLoading) {
    return rebuild((b) => b..isLoading = isLoading);
  }

  S failure(String? message) {
    return rebuild((b) => b..errorMessage = message);
  }

  S invalidateErrorMessage() {
    return rebuild((b) => b..errorMessage = null);
  }
}
