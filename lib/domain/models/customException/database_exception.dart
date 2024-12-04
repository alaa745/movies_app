class DatabaseCustomException implements Exception {
  String? errorMessage;
  DatabaseCustomException(this.errorMessage);

  @override
  String toString() {
    // TODO: implement toString
    return 'DatabaseException: $errorMessage';
  }
}
