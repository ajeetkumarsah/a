enum FieldInputType {
  INPUT,
  OWNER_SELECT,
  SELECT,
  TAG_MULTI_SELECT,
  MULTI_PHONE_INPUT,
  MULTI_EMAIL_INPUT,
  ORG_SELECT,
  PERSON_SELECT,
  DATE_TIME,
  COMPANY_SELECT,
  PEOPLE_SELECT,
  LEAD_SELECT,
  DEAL_SELECT,
  NUMBER,
  CURRENCY_SELECT,
  TIMEZONE_SELECT,
  PIPELINE_SELECT,
  PIPELINE_STAGE_SELECT,
  ACTIVITY_TYPE_SELECT,
  ACTIVITY_LOST_REASONS_SELECT,
  DEAL_PRODUCT_INPUT,
  ACTIVITY_SHOW,
  CHECKBOX,
  RADIO,
  TOGGLE_BUTTON,
  DATE,
  DATE_RANGE,
  DATE_TIME_RANGE,
  TEXTAREA,
}

extension FieldInputTypeToString on FieldInputType {
  String getType() {
    switch (this) {
      case FieldInputType.TIMEZONE_SELECT:
        return "TIMEZONE_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.DATE_TIME_RANGE:
        return "DATE_TIME_RANGE";
        // ignore: dead_code
        break;
      case FieldInputType.TEXTAREA:
        return "TEXTAREA";
        // ignore: dead_code
        break;
      case FieldInputType.DATE_RANGE:
        return "DATE_RANGE";
        // ignore: dead_code
        break;
      case FieldInputType.DATE:
        return "DATE";
        // ignore: dead_code
        break;
      case FieldInputType.TOGGLE_BUTTON:
        return "TOGGLE_BUTTON";
        // ignore: dead_code
        break;
      case FieldInputType.RADIO:
        return "RADIO";
        // ignore: dead_code
        break;
      case FieldInputType.CHECKBOX:
        return "CHECKBOX";
        // ignore: dead_code
        break;
      case FieldInputType.ACTIVITY_SHOW:
        return "ACTIVITY_SHOW";
        // ignore: dead_code
        break;
      case FieldInputType.DEAL_PRODUCT_INPUT:
        return "DEAL_PRODUCT_INPUT";
        // ignore: dead_code
        break;
      case FieldInputType.ACTIVITY_LOST_REASONS_SELECT:
        return "ACTIVITY_LOST_REASONS_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.ACTIVITY_TYPE_SELECT:
        return "ACTIVITY_TYPE_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.PIPELINE_SELECT:
        return "PIPELINE_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.PIPELINE_STAGE_SELECT:
        return "PIPELINE_STAGE_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.INPUT:
        return "INPUT";
        // ignore: dead_code
        break;
      case FieldInputType.COMPANY_SELECT:
        return "COMPANY_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.NUMBER:
        return "NUMBER";
        // ignore: dead_code
        break;
      case FieldInputType.CURRENCY_SELECT:
        return "CURRENCY_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.OWNER_SELECT:
        return "OWNER_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.SELECT:
        return "SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.TAG_MULTI_SELECT:
        return "TAG_MULTI_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.MULTI_PHONE_INPUT:
        return "MULTI_PHONE_INPUT";
        // ignore: dead_code
        break;
      case FieldInputType.MULTI_EMAIL_INPUT:
        return "MULTI_EMAIL_INPUT";
        // ignore: dead_code
        break;
      case FieldInputType.ORG_SELECT:
        return "ORG_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.PERSON_SELECT:
        return "PERSON_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.PEOPLE_SELECT:
        return "PEOPLE_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.DEAL_SELECT:
        return "DEAL_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.LEAD_SELECT:
        return "LEAD_SELECT";
        // ignore: dead_code
        break;
      case FieldInputType.DATE_TIME:
        return 'DATE_TIME';
        // ignore: dead_code
        break;
    }
  }
}

enum FieldGroupType {
  CUSTOM,
  SYSTEM,
}

extension FieldGroupTypeToString on FieldGroupType {
  String getType() {
    switch (this) {
      case FieldGroupType.CUSTOM:
        return "CUSTOM";
        // ignore: dead_code
        break;
      case FieldGroupType.SYSTEM:
        return "SYSTEM";
        // ignore: dead_code
        break;
    }
  }
}

enum PageNavigatedFrom {
  LEAD,
  PEOPLE,
  COMPANY,
}

extension NavigateFrom on PageNavigatedFrom {
  String getType() {
    switch (this) {
      case PageNavigatedFrom.LEAD:
        return "LEAD";
        // ignore: dead_code
        break;
      case PageNavigatedFrom.PEOPLE:
        return "PEOPLE";
        // ignore: dead_code
        break;
      case PageNavigatedFrom.COMPANY:
        return "COMPANY";
        // ignore: dead_code
        break;
    }
  }
}
