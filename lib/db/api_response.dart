enum ApiResponseEnum {
  ERROR,
  STATUS,
  NETWORK_STATUS,
}

class ApiResponse {
  final Map<String, dynamic> finalData;
//  final ApiResponseEnum apiResponseEnum;
  final String error;
  final bool status;
  final bool networkStatus;

  ApiResponse(
      {required this.finalData,
      required this.error,
      required this.status,
      required this.networkStatus});
}
