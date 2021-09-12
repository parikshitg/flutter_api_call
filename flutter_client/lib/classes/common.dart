class Status{
  final bool success;
  final String errorMessage;

  Status({this.success, this.errorMessage});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      success: json['success'],
      errorMessage: json['error_message']
    );
  }
}

class Response{
  final Status status;

  Response({this.status});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      status: Status.fromJson(json['status']),
    );
  }
}