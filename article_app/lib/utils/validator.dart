String? mandatoryValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mandatory';
  }
  return null;
}
