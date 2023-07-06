class Success{
  final Object? body;
  final int statusCode;

  Success({this.body, this.statusCode = 200});
}

class Failure {
  final Object? body;
  final int statusCode;
  final String message;

  Failure({this.body, this.statusCode = 404, this.message = ''});
}