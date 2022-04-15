class AddMembershipModel {
  AddMembershipModel({
    this.userId,
    this.name,
    this.email,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.targetWeight,
    this.targetDuration,
    this.location,
    this.lat,
    this.long,
    this.bodyType,
    this.existingDisease,
    this.isSmoking,
    this.isDrinking,
    this.nToken,
    this.deviceId,
    this.howactive,
    this.type1,
    this.type2,
  });

  String? userId;
  String? name;
  String? email;
  String? age;
  String? gender;
  String? height;
  String? weight;
  String? targetWeight;
  String? targetDuration;
  String? location;
  String? lat;
  String? long;
  String? bodyType;
  String? existingDisease;
  String? isSmoking;
  String? isDrinking;
  String? nToken;
  String? deviceId;
  String? howactive;
  String? type1;
  String? type2;

  factory AddMembershipModel.fromJson(Map<String, dynamic> json) =>
      AddMembershipModel(
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        age: json["age"] == null ? null : json["age"],
        gender: json["gender"] == null ? null : json["gender"],
        height: json["height"] == null ? null : json["height"],
        weight: json["weight"] == null ? null : json["weight"],
        targetWeight:
            json["target_weight"] == null ? null : json["target_weight"],
        targetDuration:
            json["target_duration"] == null ? null : json["target_duration"],
        location: json["location"] == null ? null : json["location"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
        bodyType: json["body_type"] == null ? null : json["body_type"],
        existingDisease:
            json["existing_disease"] == null ? null : json["existing_disease"],
        isSmoking: json["is_smoking"] == null ? null : json["is_smoking"],
        isDrinking: json["is_drinking"] == null ? null : json["is_drinking"],
        nToken: json["n_token"] == null ? null : json["n_token"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        howactive: json["howactive"] == null ? null : json["howactive"],
        type1: json["type1"] == null ? null : json["type1"],
        type2: json["type2"] == null ? null : json["type2"],
      );

  Map<String, dynamic> toJson(AddMembershipModel data) => {
        "user_id": data.userId == null ? null : userId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "age": age == null ? null : age,
        "gender": gender == null ? null : gender,
        "height": height == null ? null : height,
        "weight": weight == null ? null : weight,
        "target_weight": targetWeight == null ? null : targetWeight,
        "target_duration": targetDuration == null ? null : targetDuration,
        "location": location == null ? null : location,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "body_type": bodyType == null ? null : bodyType,
        "existing_disease": existingDisease == null ? null : existingDisease,
        "is_smoking": isSmoking == null ? null : isSmoking,
        "is_drinking": isDrinking == null ? null : isDrinking,
        "n_token": data.nToken == null ? null : data.nToken,
        "device_id": data.deviceId == null ? null : data.deviceId,
        "howactive": data.howactive == null ? null : data.howactive,
        "type1": data.type1 == null ? "type1" : data.type1,
        "type2": data.type2 == null ? "type2" : data.type2,
      };
}
