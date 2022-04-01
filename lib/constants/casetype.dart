enum CaseType { REGISTER, INVITE, LOGIN }

extension CaseTypeToString on CaseType {
  String getCaseType() {
    switch (this) {
      case CaseType.REGISTER:
        return "REGISTER";
      case CaseType.INVITE:
        return "INVITE";
      case CaseType.LOGIN:
        return "LOGIN";
    }
  }
}
