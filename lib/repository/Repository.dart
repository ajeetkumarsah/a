import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salessimplify/constants/casetype.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/ActivityData.dart';
import 'package:salessimplify/models/ActivitySymbol.dart';
import 'package:salessimplify/models/CustomSelectModel.dart';
import 'package:salessimplify/models/DealCategory.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/models/LoggedProfile.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/models/Profile.dart';
import 'package:salessimplify/models/ProfileDropDownModel.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/models/activity_details_model.dart';
import 'package:salessimplify/models/activity_lost_reason_settings.dart';
import 'package:salessimplify/models/activity_lost_reasons.dart';
import 'package:salessimplify/models/addformfields.dart';
import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/models/current_user.dart';
import 'package:salessimplify/models/deal_product.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/models/errormodel.dart';
import 'package:salessimplify/models/global_search.dart';
import 'package:salessimplify/models/lead_details.list.dart';
import 'package:salessimplify/models/lead_lost_reason.dart';
import 'package:salessimplify/models/location_model.dart';
import 'package:salessimplify/models/lost_reason.dart';
import 'package:salessimplify/models/notes.dart';
import 'package:salessimplify/models/popupdetails.dart';
import 'package:salessimplify/models/roles_wise_userL_lst.dart';
import 'package:salessimplify/models/search_product.dart';
import 'package:salessimplify/models/short_activity_model.dart';
import 'package:salessimplify/models/tag.dart';
import 'package:salessimplify/secrets/SecretLoader.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/tabs/activity/CreateActivity.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

import 'error_handler.dart';

class Repository with ChangeNotifier, DiagnosticableTreeMixin {
  static Repository? _instance;
  bool isOtpSent = false;
  bool isDataReloaded = false;
  CustomSelectModel? selectedOrg;
  CustomSelectModel? selectedPerson;
  ActivitySymbol? selectedActivitySymbol;
  SearchResult? selectedSearchResult;
  Leads? selectedPeopleSearch;
  Leads? selectedLeadSearch;
  Company? selectedCompanySearch;
  DateTimeRange? selectedDateTimeRange;
  List<DropDownModel> profiles = [];
  List<RoleWiseUser> roleWiseUser = [];
  List<LostReasonModel> activityLostReason = [];
  DropDownModel? selectedDropDown;
  bool isActiveLeadConverted = false,
      isJunkLeadConverted = false,
      isPersonDeleted = false;
  int totalByteLength = 0;

  List<Stage> stages = [];

  Repository();

  static getInstance() {
    if (_instance == null) {
      _instance = Repository();
    }
    return _instance;
  }

  getSecrets() async {
    var secret = await SecretLoader(secretPath: "secrets.json").load();
    return secret.baseUrl;
  }

  static getSecretHost() async {
    var secret = await SecretLoader(secretPath: "secrets.json").load();
    return secret.host;
  }

  postEmailOtp(String emailId) async {
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();

      var response = await client.post(
        Uri.parse('${baseUrl}user-service/api/email/send-otp'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(
          {
            "email": emailId,
            "caseType": CaseType.REGISTER.getCaseType(),
          },
        ),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["otpId"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  postAccount(
    String fullName,
    String email,
    String password,
    String otp,
    String otpId,
  ) async {
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();

      var response = await client.post(
        Uri.parse('${baseUrl}user-service/api/account'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(
          {
            "fullName": fullName,
            "email": email,
            "password": password,
            "otp": otp,
            "otpId": otpId
          },
        ),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["success"];
    } catch (exception) {
      return false;
    } finally {
      client.close();
    }
  }

  postLogin(String email, String password, String otp, String ip,
      String location) async {
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();

      var response = await client.post(
        Uri.parse('${baseUrl}user-service/api/login'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(
          otp.isEmpty
              ? {
                  "email": email,
                  "password": password,
                  "location": location,
                  "device": "mobile",
                  "platform": "Android",
                  "IPAddr": ip,
                  "rememberLogin": true,
                  "loginMethod": "any",
                  "isGoogleAttempt": false
                }
              : {
                  "email": email,
                  "password": password,
                  "otp": otp.toString(),
                  "location": location,
                  "device": "string",
                  "platform": "Android",
                  "IPAddr": ip,
                  "rememberLogin": true,
                  "loginMethod": "any",
                  "isGoogleAttempt": false
                },
        ),
      );
      var jsonResponse = json.decode(response.body);
      if (jsonResponse["success"]) {
        if (jsonResponse["is2FAEnabled"] != null &&
            (jsonResponse["is2FAEnabled"] as bool)) {
          isOtpSent = true;
          notifyListeners();
          return null;
        } else if (jsonResponse["token"] != null) {
          return jsonResponse["token"];
        } else {
          return "Invalid";
        }
      } else
        return "Invalid";
    } catch (exception) {
      return "Invalid";
    } finally {
      client.close();
    }
  }

  getLocation() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse('https://ipapi.co/json'));
      // print('body============>${response.body}');
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      if (response.statusCode == 200) {
        return compute(parseLocation, response.body);
      }
      return 'Error';
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getLead(bool isActive, int page, int pageSize) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "$page",
        "limit": "$pageSize",
        "type": isActive ? "active_lead" : "junk_lead",
        "fields": "name,phone,company,email",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/lead/get', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      return compute(parseLeads, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getPeople(int page, int pageSize) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "$page",
        "limit": "$pageSize",
        "type": "people",
        "fields": "name,phone,company,email",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/people/get', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      return compute(parseLeads, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getCompany(int page, int pageSize) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "$page",
        "limit": "$pageSize",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/company/get', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });

      // print(response.body);
      return compute(parseCompany, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getLeadsDetails(String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "id": "$id",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/lead/get-selected-details',
              queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      return compute(parsePopupDetails, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getProducts(String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {"id": "$id"};
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://dev10.salessimplify.com/api/crm/product/categories'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }

      // var response = await client.get(
      //     Uri.https('$baseUrl', '/api/crm/product/categories', queryParameters),
      //     headers: {
      //       "Authorization": "${_token}",
      //     });
      // print('Body:-~~~~~~~~~~~~${response.body}');
      // return compute(parsePopupDetails, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getCurrentUserDetails(String token) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "email": "",
      };
      var baseUrl = await getSecretHost();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/profile', queryParameters),
          headers: {
            "Authorization": "Bearer ${token}",
          });
      // print(response.body);

      return compute(parseCurrentUserDetails, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getLeadsDetailsList(String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "id": "$id",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https(
              '$baseUrl', '/api/crm/lead/load-more-data/$id', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      print('API response==================>' + response.body);
      return compute(parseLeadDetailsList, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getPeopleDetails(String id, bool company) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "id": "$id",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https(
              '$baseUrl',
              company
                  ? '/api/crm/company/load-more-data/$id'
                  : '/api/crm/people/load-more-data/$id',
              queryParameters),
          headers: {
            "Authorization": "${_token}",
          });

      return compute(parsePopupDetailsList, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getActivityDetails(String id, bool isDeal) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "id": "$id",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https(
              '$baseUrl',
              isDeal == true
                  ? '/api/crm/deals/load-more-data/$id'
                  : '/api/crm/activity-list/load-more-data/$id',
              queryParameters),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "${_token}",
          });
      print('~~~~~~~~~~get deal data id' + response.body.toString());
      return compute(parseActivityDetailsList, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getAddFormField(String fieldType) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "fieldType": "$fieldType",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/data-fields/v2/add-form-fields',
              queryParameters),
          headers: {
            "Authorization": "$_token",
          });
      return compute(parseFormFields, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  createCompany(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/company/create'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return AppErrorHandler()
          .error(response: response, jsonResponse: jsonResponse);
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isDataReloaded = true;
      notifyListeners();
    }
  }

  createCompanyByName(String name) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/company/create-by-name'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode({"name": name}),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["id"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isDataReloaded = true;
      notifyListeners();
    }
  }

  createPeople(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();
      print('=================>Create people:' + params.toString());
      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/People/create'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      print('=================>Body:' + response.body.toString());

      var jsonResponse = json.decode(response.body);
      return AppErrorHandler()
          .error(response: response, jsonResponse: jsonResponse);
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isDataReloaded = true;
      notifyListeners();
    }
  }

  createLead(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/Lead/create'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return AppErrorHandler()
          .error(response: response, jsonResponse: jsonResponse);
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isDataReloaded = true;
      notifyListeners();
    }
  }

  createActivity(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/activity-list/create'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );

      var jsonResponse = json.decode(response.body);
      return AppErrorHandler()
          .error(response: response, jsonResponse: jsonResponse);
      // if (response.statusCode == 200) {
      //   //success
      //   toastHelper.toastWithTitleAndColor(
      //       jsonResponse["message"].toString(), greenColor);
      //   return true;
      // } else if (response.statusCode == 400) {
      //   //Error
      //   toastHelper.toastWithTitleAndColor(
      //       jsonResponse["message"].toString(), redColor);
      //   return false;
      // } else {
      //   //Something went wrong
      //   toastHelper.toastWithTitleAndColor('Something went wrong!', redColor);
      //   return false;
      // }
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isDataReloaded = true;
      notifyListeners();
    }
  }

  createDeal(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();
      // print('BaseUrl :- ' + baseUrl.toString());
      // print('Token :- ' + _token.toString());
      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/deals'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return AppErrorHandler()
          .error(response: response, jsonResponse: jsonResponse);
    } catch (exception) {
      return "";
    } finally {
      client.close();
      notifyListeners();
    }
  }

  createNote(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/activity/notes'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      notifyListeners();
    }
  }

  createShortActivity(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/activity-list/create-short-activity'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      notifyListeners();
    }
  }

  markAsDone(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/activity-list/mark-as-done'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();

      notifyListeners();
    }
  }

  markAsUnDone(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/activity-list/mark-as-un-done'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      notifyListeners();
    }
  }

  convertLeadToDeal(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/deals'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      // print('~~~~~~~~~~~~~json Body before : ' + response.body);
      var jsonResponse = json.decode(response.body);
      // print('~~~~~~~~~~~~~json Body after : ' + response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return exception;
    } finally {
      client.close();

      notifyListeners();
    }
  }

  convertDealToLead(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/pipeline/deal/deal-to-lead'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return '$exception';
    } finally {
      client.close();

      notifyListeners();
    }
  }

  convertActiveToJunk(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/lead/convert-active-to-junk'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isActiveLeadConverted = true;
      notifyListeners();
    }
  }

  convertJunkToActive(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/lead/convert-junk-to-active'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isJunkLeadConverted = true;
      notifyListeners();
    }
  }

  deleteActivity(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/activity-list/bulk-delete'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  deleteCompany(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/company/delete'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  deletePeople(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/people/delete'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  deleteLead(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/lead/delete'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  deleteDeal(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/deals/delete'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );

      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  deleteNote(String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.delete(
        Uri.parse('${baseUrl}api/crm/activity/notes/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
      );
      // print('~~~~~~~~~~~~~~~~delete note' + response.body);
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateUserProfilePicture(String path) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var request = http.MultipartRequest(
          'PATCH', Uri.parse('${baseUrl}api/crm/profile/avatar'));
      request.files.add(await http.MultipartFile.fromPath('file', path));
      request.headers.addAll({
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$_token",
      });

      http.StreamedResponse response = await request.send();
      var totalByteLength = response.contentLength;

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());
        return jsonResponse["message"];
      } else {
        return '${response.reasonPhrase}';
      }
    } catch (exception) {
      return "Something went wrong!";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateDeal(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/pipeline/stage/move-deal-in-stages'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updatePeopleDetails(Map<String, dynamic> params, String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();
      print('Sending data =========>$params');
      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/people/load-more-data/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateCompanyDetails(Map<String, dynamic> params, String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/company/load-more-data/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      // print(response.body);
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  activityFilter(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();
      var response = await client.post(
        Uri.parse('${baseUrl}api/crm/saved-filters/apply'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );

      var jsonResponse = json.decode(response.body);
      print(jsonResponse["status"]);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateLeadDetails(Map<String, dynamic> params, String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/lead/load-more-data/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateActivityDetails(Map<String, dynamic> params, String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/activity-list/load-more-data/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateDealDetails(
      Map<String, dynamic> params, String id, String? product) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/deals/load-more-data/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );
      var jsonResponse = json.decode(response.body);
      if (product == 'Delete' || product == 'Linked' || product == 'Updated') {
        if (product == 'Delete') {
          toastHelper.toastWithTitleAndColor(
              'Deleted successfully!', greenColor);
          return true;
        }
        if (product == 'Linked') {
          toastHelper.toastWithTitleAndColor(
              'Linked successfully!', greenColor);
          return true;
        }
        if (product == 'Updated') {
          toastHelper.toastWithTitleAndColor(
              'Updated successfully!', greenColor);
          return true;
        }
      } else {
        return AppErrorHandler()
            .error(response: response, jsonResponse: jsonResponse);
      }
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  getLeadLostReasons(FieldInputType inputType, String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": "$query",
      };

      var request = http.Request(
          'GET', Uri.parse('{{base_url}}/api/crm/lost-reason/lead'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
      } else {
        // print(response.reasonPhrase);
      }
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getSearchResult(FieldInputType inputType, String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": "$query",
      };

      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https(
              '$baseUrl',
              '/api/crm/${inputType == FieldInputType.ORG_SELECT ? "company" : "people"}/search',
              queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      return compute(parseSearch, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getGlobalSearchResult(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": "$query",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
        Uri.https('$baseUrl', '/api/crm/lead/search-all', queryParameters),
        headers: {
          "Authorization": "${_token}",
        },
      );
      print('body~~~~~~~~~~~ ' + response.body);
      return compute(parseGlobalSearch, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getLeadsLostReasons() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      var response = await client.get(
        Uri.https('$baseUrl', '/api/crm/lost-reason/lead'),
        headers: {
          "Authorization": "${_token}",
        },
      );
      if (response.statusCode == 200) {
        return compute(parseLeadsLostReason, response.body);
      } else {
        // print(response.reasonPhrase);
        return response.statusCode;
      }
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getActivityLostReasons() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      var response = await client.get(
        Uri.https('$baseUrl', '/api/crm/lost-reason/activity'),
        headers: {
          "Authorization": "${_token}",
        },
      );
      if (response.statusCode == 200) {
        return compute(parseActivityLostReason, response.body);
      } else {
        // print(response.reasonPhrase);
        return response.statusCode;
      }
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getActivityLostReasonSettings() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl',
              '/api/crm/account-settings/activity-lost-reason-settings'),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      return compute(parseActivityLostReasonSettings, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  updateActivityLostReasonSettings(bool value) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse(
            '${baseUrl}api/crm/account-settings/activity-lost-reason-settings'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode({"isActivityLostReasonEnabled": value}),
      );
      // print(response.body);
      var jsonResponse = json.decode(response.body);
      return jsonResponse["status"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  updateNote(Map<String, dynamic> params) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecrets();
      var _token = await sessionManager.getToken();

      var response = await client.patch(
        Uri.parse('${baseUrl}api/crm/activity/notes/update'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$_token",
        },
        body: jsonEncode(params),
      );

      var jsonResponse = json.decode(response.body);
      return jsonResponse["message"];
    } catch (exception) {
      return "";
    } finally {
      client.close();
      isPersonDeleted = true;
      notifyListeners();
    }
  }

  getActivityData(String type, int page, int pageSize) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "$page",
        "limit": "$pageSize",
        "type": "$type",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https(
              '$baseUrl', '/api/crm/activity-list/mobile/get', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      return compute(parseActivity, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  // getActivityDataSearch(String type) async {
  //   var sessionManager = SessionManager.getInstance();
  //   var client = http.Client();
  //   try {
  //     final filter = {
  //       "type": "$type",
  //     };
  //     var baseUrl = await getSecretHost();
  //     var _token = await sessionManager.getToken();
  //     /*var response = await Dio().get(
  //       "$baseUrl', '/api/crm/activity-list/mobile/get",
  //       queryParameters: {"filter": filter},
  //     );*/

  //     var response = await client.get(
  //         Uri.https('$baseUrl', '/api/crm/activity-list/mobile/get', filter),
  //         headers: {
  //           "Authorization": "${_token}",
  //         });

  //     var list = json
  //         .decode(response.body)['title']
  //         .map((data) => ActivityGet.fromJson(data))
  //         .toList();

  //     return list;
  //   } catch (exception) {
  //     return "";
  //   } finally {
  //     client.close();
  //   }
  // }

  List<ActivitySymbol> activitySymbols = [];

  getActivitySymbol() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "1",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/activity/active', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var data = await compute(parseActivitySymbol, response.body);
      if (data is List<ActivitySymbol>) {
        activitySymbols = data;
        notifyListeners();
      }
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getProfile() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "1",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/profile/list', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var list = await compute(parseProfile, response.body);
      if (list is List<ProfileDropDownModel>) {
        profiles.clear();
        list.forEach((element) {
          if (element.email != null && element.email.isNotEmpty)
            profiles.add(DropDownModel(element.email, element.userId));
        });
        notifyListeners();
      }
      return list;
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getRolesWiseUserList() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pageNo": "1",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/profile/roles-wise-user-list',
              queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var list = await compute(parseRolesWiseUserList, response.body);

      if (list is List<RoleWiseUser>) {
        roleWiseUser.clear();
        roleWiseUser.addAll(list);
        notifyListeners();
      }
      return list;
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getActivityLostReasonList() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/lost-reason/activity'),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var list = await compute(parseLostReasonList, response.body);

      if (list is List<LostReasonModel>) {
        activityLostReason.clear();
        activityLostReason.addAll(list);
        notifyListeners();
      }
      return list;
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  userProfile(String id) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "id": "$id",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/profile', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });

      return compute(parseProfile, response.body);
    } catch (exception) {
      // print('~~~~~~~~~~~~~~~~~~~~exception ${exception}');
      return "";
    } finally {
      client.close();
    }
  }

  curentUserProfile() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var id = await SessionManager.getInstance().getId();

      final queryParameters = {
        "id": "$id",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/profile', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });

      return compute(parseUserProfile, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  static Future<List<SearchProduct>> getProductNewSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/product/search', queryParameters),
          headers: {"Authorization": "${_token}"});
      print('Search Body~~~~~~~~~~~~~~:' + response.body);
      var data = json.decode(response.body);
      final parsed = data["data"] as List<dynamic>;
      return parsed.map((status) => SearchProduct.fromJson(status)).toList();
    } catch (exception) {
      return [];
    } finally {
      client.close();
    }
  }

  List<SearchResult> searchResult = [];

  getDealSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/deals/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var data = await compute(parseSearchResult, response.body);
      searchResult.clear();
      searchResult.addAll(data);
      notifyListeners();
      return data;
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  static Future<List<SearchResult>> getDealNewSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/deals/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });

      var data = json.decode(response.body);
      final parsed = data["data"] as List<dynamic>;
      return parsed.map((status) => SearchResult.fromJson(status)).toList();
    } catch (exception) {
      return [];
    } finally {
      client.close();
    }
  }

  static Future<List<SearchLeadNew>> getLeadNewSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/lead/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      // print(response.body);
      var data = json.decode(response.body);
      final parsed = data["data"] as List<dynamic>;
      return parsed
          .map(
            (status) => SearchLeadNew.fromJson(status),
          )
          .toList();
    } catch (exception) {
      return [];
    } finally {
      client.close();
    }
  }

  static Future<List<SearchCompanyNew>> getCompanyNewSearch(
      String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/company/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      // print("Response~~~~~~~~~~~~~~" + response.body);
      var data = json.decode(response.body);
      final parsed = data["data"] as List<dynamic>;
      return parsed
          .map(
            (status) => SearchCompanyNew.fromJson(status),
          )
          .toList();
    } catch (exception) {
      return [];
    } finally {
      client.close();
    }
  }

  static Future<List<SearchPeopleNew>> getPeopleNewSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/people/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });

      var data = json.decode(response.body);
      final parsed = data["data"] as List<dynamic>;
      return parsed
          .map(
            (status) => SearchPeopleNew.fromJson(status),
          )
          .toList();
    } catch (exception) {
      return [];
    } finally {
      client.close();
    }
  }

  List<Leads> searchPeopleResult = [];

  getPeopleSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/people/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var data = await compute(parseLeads, response.body);
      searchPeopleResult.clear();
      searchPeopleResult.addAll(data);
      notifyListeners();
      return data;
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  List<Leads> searchLeadsResult = [];
  bool isSearchLeadProcessing = false;

  getLeadSearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    isSearchLeadProcessing = true;
    notifyListeners();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/lead/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var data = await compute(parseLeads, response.body);
      searchLeadsResult.clear();
      searchLeadsResult.addAll(data);
      notifyListeners();
      return data;
    } catch (exception) {
      searchLeadsResult.clear();
      notifyListeners();
      return "";
    } finally {
      isSearchLeadProcessing = false;
      notifyListeners();
      client.close();
    }
  }

  List<Company> searchCompanyResult = [];
  bool isSearchCompanyProcessing = false;

  getCompanySearch(String query) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    isSearchCompanyProcessing = true;
    notifyListeners();
    try {
      final queryParameters = {
        "searchText": query,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/company/search', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var data = await compute(parseCompany, response.body);
      searchCompanyResult.clear();
      searchCompanyResult.addAll(data);
      notifyListeners();
      return data;
    } catch (exception) {
      searchCompanyResult.clear();
      notifyListeners();
      return "";
    } finally {
      client.close();
      isSearchCompanyProcessing = false;
      notifyListeners();
    }
  }

  List<DealCategory> deals = [];
  bool isDealLoading = true;
  String selectedPipelineId = "";

  getDeals(String pipelineId) async {
    isDealLoading = true;
    selectedPipelineId = pipelineId;
    notifyListeners();
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pipelineId": pipelineId,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https(
              '$baseUrl', '/api/crm/pipeline/stage/deals', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var data = await compute(parseDealsResult, response.body);
      print("getDeals body===============> " + response.body);
      deals.clear();
      deals.addAll(data);
      isDealLoading = false;
      notifyListeners();
      return data;
    } catch (exception) {
      isDealLoading = false;
      notifyListeners();
      return "";
    } finally {
      client.close();
    }
  }

  List<PipelineModel> pipelines = [];

  getPipelines() async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "pipelineId": "_",
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/pipeline', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      print('Token:-$_token');
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      var list = await compute(parsePipelines, response.body);
      pipelines.clear();
      notifyListeners();

      pipelines.addAll(list);
      notifyListeners();
      return pipelines;
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getNotes({required Map<String, String> params}) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      final queryParameters = params;
      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/activity/notes', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      // print('Notes~~~~~~~~~~~~~~~~~~~~' + response.body);
      return compute(parseNotes, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getLinkedActivities({required Map<String, dynamic> params}) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();

    try {
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();
      final queryParameters = params;
      var response = await client.get(
          Uri.https('$baseUrl', 'api/crm/activity-list/linked-activities',
              queryParameters),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "$_token",
          });

      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }

      return compute(parseshortActivity, response.body);
    } catch (exception) {
      print(exception);
      return "exception";
    } finally {
      client.close();
    }
  }

  getTags({required String type}) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "type": type,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/tag/get', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      return compute(parseTags, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  getNewTags({required String type}) async {
    var sessionManager = SessionManager.getInstance();
    var client = http.Client();
    try {
      final queryParameters = {
        "type": type,
      };
      var baseUrl = await getSecretHost();
      var _token = await sessionManager.getToken();

      var response = await client.get(
          Uri.https('$baseUrl', '/api/crm/tag/get', queryParameters),
          headers: {
            "Authorization": "${_token}",
          });
      print(response.body.toString);
      if (response.statusCode == 401) {
        return ErrorModel(errorCode: 401, message: "unauthorized");
      }
      return compute(parseNewTags, response.body);
    } catch (exception) {
      return "";
    } finally {
      client.close();
    }
  }

  setOrg(CustomSelectModel org) {
    selectedOrg = org;
    notifyListeners();
  }

  setPerson(CustomSelectModel org) {
    selectedPerson = org;
    notifyListeners();
  }

  setActivitySymbol(ActivitySymbol? activitySymbol) {
    selectedActivitySymbol = activitySymbol;
    notifyListeners();
  }

  setSearchResult(SearchResult? result) {
    selectedSearchResult = result;
    notifyListeners();
  }

  setSearchPeopleResult(SearchResult? result) {
    selectedSearchResult = result;
    notifyListeners();
  }

  setSelectedPeopleSearch(Leads? result) {
    selectedPeopleSearch = result;
    notifyListeners();
  }

  setSelectedLeadSearch(Leads? result) {
    selectedLeadSearch = result;
    notifyListeners();
  }

  setSelectedCompanySearch(Company? result) {
    selectedCompanySearch = result;
    notifyListeners();
  }

  setDateRange(DateTimeRange? dateTimeRange) {
    selectedDateTimeRange = dateTimeRange;
    notifyListeners();
  }

  setSelectedDropDown(DropDownModel? dropDownModel) {
    selectedDropDown = dropDownModel;
    notifyListeners();
  }

  setPipelineStages(List<Stage> stages) {
    this.stages.clear();
    this.stages.addAll(stages);
    notifyListeners();
  }

  invalidateLeadFlag() {
    isActiveLeadConverted = false;
    notifyListeners();
  }

  invalidateJunkFlag() {
    isJunkLeadConverted = false;
    notifyListeners();
  }

  invalidatePersonFlag() {
    isPersonDeleted = false;
    notifyListeners();
  }
}

parseLeads(String responseBody) {
  try {
    var data = json.decode(responseBody);
    final parsed = data["data"] as List<dynamic>;
    return parsed.map((status) => Leads.fromJson(status)).toList();
  } catch (e) {
    print(e);
  }
}

parseLocation(String responseBody) {
  try {
    var data = json.decode(responseBody);
    return LocationModel.fromJson(data);
  } catch (e) {
    print(e);
  }
}

parseLeadLostReasons(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => LeadLostReasons.fromJson(status)).toList();
}

parseSearch(String responseBody) {
  try {
    var data = json.decode(responseBody);
    final parsed = data["data"] as List<dynamic>;
    return parsed.map((status) => CustomSelectModel.fromJson(status)).toList();
  } catch (e) {
    print(e);
  }
}

parseGlobalSearch(String responseBody) {
  try {
    var data = json.decode(responseBody);
    return GlobalSearchModel.fromJson(data["data"]);
  } catch (e) {
    print(e);
  }
}

parseCompany(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => Company.fromJson(status)).toList();
}

parsePopupDetails(String responseBody) {
  var data = json.decode(responseBody);
  return PopupDetails.fromJson(data["data"]);
}

parseProducts(String responseBody) {
  var data = json.decode(responseBody);

  return PopupDetails.fromJson(data["data"]);
}

parseCurrentUserDetails(String responseBody) {
  var data = json.decode(responseBody);
  return LoggedProfile.fromJson(data["data"]);
}

parsePopupDetailsList(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => PopupDetailsList.fromJson(status)).toList();
}

parseActivityDetailsList(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ActivityDetailsModel.fromJson(status)).toList();
}

parseLeadDetailsList(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => LeadDetailsList.fromJson(status)).toList();
}

parseFormFields(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => AddFormFields.fromJson(status)).toList();
}

parseActivity(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ActivityData.fromJson(status)).toList();
}

parseActivityLostReasonSettings(String responseBody) {
  var data = json.decode(responseBody);
  return ActivityLostReasonSettings.fromJson(data);
}

parseLeadsLostReason(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ActivityLostReasons.fromJson(status)).toList();
}

parseActivityLostReason(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ActivityLostReasons.fromJson(status)).toList();
}

parseActivitySymbol(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ActivitySymbol.fromJson(status)).toList();
}

parseProfile(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ProfileDropDownModel.fromJson(status)).toList();
}

parseRolesWiseUserList(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"]["users"] as List<dynamic>;
  return parsed.map((status) => RoleWiseUser.fromJson(status)).toList();
}

parseLostReasonList(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => LostReasonModel.fromJson(status)).toList();
}

parseUserProfile(String responseBody) {
  var data = json.decode(responseBody);
  return Profile.fromJson(data["data"]);
}

parseSearchResult(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => SearchResult.fromJson(status)).toList();
}

parseDealsResult(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => DealCategory.fromJson(status)).toList();
}

parsePipelines(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => PipelineModel.fromJson(status)).toList();
}

parseTags(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => Tag.fromJson(status)).toList();
}

parseNewTags(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => Option.fromJson(status)).toList();
}

parseNotes(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => Notes.fromJson(status)).toList();
}

parseshortActivity(String responseBody) {
  var data = json.decode(responseBody);
  final parsed = data["data"] as List<dynamic>;
  return parsed.map((status) => ShortActivityModel.fromJson(status)).toList();
}
