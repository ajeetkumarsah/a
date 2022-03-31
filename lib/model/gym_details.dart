
class GymDetailsModel {
    GymDetailsModel({
        this.id,
        this.uid,
        this.userId,
        this.name,
        this.gymName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.pin,
        this.country,
        this.lat,
        this.long,
        this.leaseAgreement,
        this.electricityBill,
        this.bankStatement,
        this.status,
        this.dateAdded,
        this.lastUpdated,
        this.description,
        this.planType,
        this.modules,
        this.coverImage,
        this.type,
        this.qrCode,
        this.isPartial,
        this.is100,
        this.slug,
        this.categoryId,
        this.planName,
        this.planPrice,
        this.planDuration,
        this.text1,
        this.planDescription,
        this.text2,
        this.relatedTo,
        this.gallery,
        this.benefits,
        this.rating,
        this.distance,
        this.distanceText,
        this.duration,
        this.durationText,this.totalRatings,
    });

    int? id;
    String? uid;
    String? userId;
    String? name;
    String? gymName;
    String? address1;
    String? address2;
    String? city;
    String? state;
    String? pin;
    String? country;
    String? lat;
    String? long;
    String? leaseAgreement;
    String? electricityBill;
    String? bankStatement;
    String? status;
    String? dateAdded;
    String? lastUpdated;
    String? description;
    String? planType;
    String? modules;
    String? coverImage;
    String? type;
    String? qrCode;
    String? isPartial;
    int? is100;
    dynamic slug;
    dynamic categoryId;
    String? planName;
    String? planPrice;
    String? planDuration;
    String? text1;
    String? planDescription;
    String? text2;
    List<RelatedTo>? relatedTo;
    List<Gallery>? gallery;
    List<Benefit>? benefits;
    int? rating;
    int ?distance;
    String? distanceText;
    int? duration;
    String? durationText;
    String? totalRatings;

    factory GymDetailsModel.fromJson(Map<String, dynamic> json) => GymDetailsModel(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        gymName: json["gym_name"] == null ? null : json["gym_name"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        pin: json["pin"] == null ? null : json["pin"],
        country: json["country"] == null ? null : json["country"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
        leaseAgreement: json["lease_agreement"] == null ? null : json["lease_agreement"],
        electricityBill: json["electricity_bill"] == null ? null : json["electricity_bill"],
        bankStatement: json["bank_statement"] == null ? null : json["bank_statement"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        description: json["description"] == null ? null : json["description"],
        planType: json["plan_type"] == null ? null : json["plan_type"],
        modules: json["modules"] == null ? null : json["modules"],
        coverImage: json["cover_image"] == null ? null : json["cover_image"],
        type: json["type"] == null ? null : json["type"],
        qrCode: json["qr_code"] == null ? null : json["qr_code"],
        isPartial: json["is_partial"] == null ? null : json["is_partial"],
        is100: json["is_100"] == null ? null : json["is_100"],
        slug: json["slug"],
        categoryId: json["category_id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        planPrice: json["plan_price"] == null ? null : json["plan_price"],
        planDuration: json["plan_duration"] == null ? null : json["plan_duration"],
        text1: json["text1"] == null ? null : json["text1"],
        planDescription: json["plan_description"] == null ? null : json["plan_description"],
        text2: json["text2"] == null ? null : json["text2"],
        relatedTo: json["related_to"] == null ? null : List<RelatedTo>.from(json["related_to"].map((x) => RelatedTo.fromJson(x))),
        gallery: json["gallery"] == null ? null : List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        benefits: json["benefits"] == null ? null : List<Benefit>.from(json["benefits"].map((x) => Benefit.fromJson(x))),
        rating: json["rating"] == null ? null : json["rating"],
        distance: json["distance"] == null ? null : json["distance"],
        distanceText: json["distance_text"] == null ? null : json["distance_text"],
        duration: json["duration"] == null ? null : json["duration"],
        durationText: json["duration_text"] == null ? null : json["duration_text"],
        totalRatings:json["total_ratings"] == null ? null : json["total_ratings"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "gym_name": gymName == null ? null : gymName,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pin": pin == null ? null : pin,
        "country": country == null ? null : country,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "lease_agreement": leaseAgreement == null ? null : leaseAgreement,
        "electricity_bill": electricityBill == null ? null : electricityBill,
        "bank_statement": bankStatement == null ? null : bankStatement,
        "status": status == null ? null : status,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "description": description == null ? null : description,
        "plan_type": planType == null ? null : planType,
        "modules": modules == null ? null : modules,
        "cover_image": coverImage == null ? null : coverImage,
        "type": type == null ? null : type,
        "qr_code": qrCode == null ? null : qrCode,
        "is_partial": isPartial == null ? null : isPartial,
        "is_100": is100 == null ? null : is100,
        "slug": slug,
        "category_id": categoryId,
        "plan_name": planName == null ? null : planName,
        "plan_price": planPrice == null ? null : planPrice,
        "plan_duration": planDuration == null ? null : planDuration,
        "text1": text1 == null ? null : text1,
        "plan_description": planDescription == null ? null : planDescription,
        "text2": text2 == null ? null : text2,
        "related_to": relatedTo == null ? null : List<dynamic>.from(relatedTo!.map((x) => x.toJson())),
        "gallery": gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x.toJson())),
        "benefits": benefits == null ? null : List<dynamic>.from(benefits!.map((x) => x.toJson())),
        "rating": rating == null ? null : rating,
        "distance": distance == null ? null : distance,
        "distance_text": distanceText == null ? null : distanceText,
        "duration": duration == null ? null : duration,
        "duration_text": durationText == null ? null : durationText,
    };
}

class Benefit {
    Benefit({
        this.id,
        this.uid,
        this.gymId,
        this.name,
        this.breif,
        this.image,
        this.status,
        this.dateAdded,
        this.lastUpdated,
    });

    int? id;
    String? uid;
    String? gymId;
    String? name;
    String? breif;
    String? image;
    String? status;
    DateTime? dateAdded;
    DateTime? lastUpdated;

    factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        gymId: json["gym_id"] == null ? null : json["gym_id"],
        name: json["name"] == null ? null : json["name"],
        breif: json["breif"] == null ? null : json["breif"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
        lastUpdated: json["last_updated"] == null ? null : DateTime.parse(json["last_updated"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "gym_id": gymId == null ? null : gymId,
        "name": name == null ? null : name,
        "breif": breif == null ? null : breif,
        "image": image == null ? null : image,
        "status": status == null ? null : status,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
    };
}

class Gallery {
    Gallery({
        this.id,
        this.uid,
        this.gymId,
        this.categoryId,
        this.images,
        this.status,
        this.dateAdded,
        this.lastUpdated,
        this.type,
    });

    int? id;
    String? uid;
    String? gymId;
    String? categoryId;
    String? images;
    String? status;
    String? dateAdded;
    String? lastUpdated;
    String? type;

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        gymId: json["gym_id"] == null ? null : json["gym_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        images: json["images"] == null ? null : json["images"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "gym_id": gymId == null ? null : gymId,
        "category_id": categoryId == null ? null : categoryId,
        "images": images == null ? null : images,
        "status": status == null ? null : status,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "type": type == null ? null : type,
    };
}

class RelatedTo {
    RelatedTo({
        this.relatedTo,
    });

    int? relatedTo;

    factory RelatedTo.fromJson(Map<String, dynamic> json) => RelatedTo(
        relatedTo: json["related_to"] == null ? null : json["related_to"],
    );

    Map<String, dynamic> toJson() => {
        "related_to": relatedTo == null ? null : relatedTo,
    };
}
