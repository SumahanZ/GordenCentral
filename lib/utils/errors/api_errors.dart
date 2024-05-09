sealed class ApiError {
  final String message;
  ApiError({required this.message});
}

class ResponseAPIError implements ApiError {
  final int responseStatusCode;
  final String errorMessage;
  ResponseAPIError(
      {required this.responseStatusCode, required this.errorMessage});

  @override
  String get message =>
      errorMessage;
}

class RequestError implements ApiError {
  final String errorMessage;

  RequestError({required this.errorMessage});
  @override
  String get message => errorMessage;
}

class NetworkError implements ApiError {
  @override
  String get message => "Request Error has occured";
}

sealed class ApiMessage {
  final String message;
  ApiMessage({required this.message});
}

class PopupMessage implements ApiMessage {
  final String popupMessage;
  final bool shouldBeHandled;
  PopupMessage({required this.popupMessage, required this.shouldBeHandled});
  
  @override
  String get message => popupMessage;
}
