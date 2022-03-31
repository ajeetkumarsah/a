import 'package:wtf_web/model/benefits.dart';
import 'package:wtf_web/model/gallery_model.dart';
import 'package:wtf_web/model/offer_model.dart';

class GymListModel {
   GymListModel({this.userId,
        this.gymName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.latitude,
        this.longitude,
        this.pin,
        this.country,
        this.distance,
        this.distanceText,
        this.duration,
        this.durationText,
        this.rating,
        this.text1,
        this.text2,
        this.planName,
        this.planDuration,
        this.planPrice,
        this.planDescription,
        this.coverImage,
        // this.gallery,
        this.type,
        this.description,
        this.status,
        this.slug,
        this.categoryId,
        // this.offer,
         this.benefits,
        });

     String? gymName;
     String? userId;
     String? address1;
     String? address2;
     String? city;
     String? state;
     String? latitude;
     String? longitude;
     String? pin;
     String? country;
     dynamic distance;
     String? distanceText;
     dynamic  duration;
     String? durationText;
     double? rating;
     String? text1;
     String? text2;
     String? planName;
     String? planDuration;
     String? planPrice;
     String? planDescription;
     String? coverImage;
    //  List<Gallery>? gallery;
     String ?type;
     String? description;
     String? status;
     String? slug;
     String ?categoryId;
    //  List<Offer>? offer;
    List<Benefit>? benefits;

    factory GymListModel.fromJson(Map<String, dynamic> json) => GymListModel(
        userId: json["user_id"],
        gymName: json["gym_name"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pin: json["pin"],
        country: json["country"],
        distance: json["distance"],
        distanceText: json["distance_text"],
        duration: json["duration"],
        durationText: json["duration_text"],
        rating: json["rating"].toDouble(),
        text1: json["text1"] == null ? null : json["text1"],
        text2: json["text2"] == null ? null : json["text2"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        planDuration: json["plan_duration"] == null ? null : json["plan_duration"],
        planPrice: json["plan_price"] == null ? null : json["plan_price"],
        planDescription: json["plan_description"] == null ? null : json["plan_description"],
        coverImage: json["cover_image"] == null ? null : json["cover_image"],
        // gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        type: json["type"],
        description: json["description"],
        status: json["status"],
        slug: json["slug"] == null ? null : json["slug"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        // offer: List<Offer>.from(json["offer"].map((x) => Offer.fromJson(x))),
                 benefits: json["benefits"] == null ? [] : List<Benefit>.from(json["benefits"].map((x) => Benefit.fromJson(x))),
    );


}






