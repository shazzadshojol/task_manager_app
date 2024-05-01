validatorChecker(String? value, String errorMessage) {
  if (value?.trim().isEmpty ?? true) {
    return errorMessage;
  }
  return null;
}
