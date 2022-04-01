class Secret {
  final String baseUrl, host;

  Secret({
    this.baseUrl = "",
    this.host = "",
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      baseUrl: jsonMap["base_url"],
      host: jsonMap["host"],
    );
  }
}
