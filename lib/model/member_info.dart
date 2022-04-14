class MemberInfo {
  MemberInfo({
    this.uid,
    this.name,
    this.userId,
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
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.howactive,
    this.dietCategoryId,
    this.gender,
    this.email,
    this.age,
    this.type1,
    this.type2,
  });

  String? uid;
  String? name;
  String? userId;
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
  String? status;
  String? dateAdded;
  String? lastUpdated;
  String? howactive;
  String? dietCategoryId;
  String? gender;
  String? email;
  String? age;
  String? type1;
  String? type2;

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        userId: json["user_id"] == null ? null : json["user_id"],
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
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        howactive: json["howactive"] == null ? null : json["howactive"],
        dietCategoryId:
            json["diet_category_id"] == null ? null : json["diet_category_id"],
        gender: json["gender"] == null ? null : json["gender"],
        email: json["email"] == null ? null : json["email"],
        age: json["age"] == null ? null : json["age"],
        type1: json["type1"] == null ? null : json["type1"],
        type2: json["type2"] == null ? null : json["type2"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "user_id": userId == null ? null : userId,
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
        "status": status == null ? null : status,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "howactive": howactive == null ? null : howactive,
        "diet_category_id": dietCategoryId == null ? null : dietCategoryId,
        "gender": gender == null ? null : gender,
        "email": email == null ? null : email,
        "age": age == null ? null : age,
        "type1": type1 == null ? null : type1,
        "type2": type2 == null ? null : type2,
      };
}
