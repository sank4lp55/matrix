class EventModel {
  int? status;
  String? message;
  List<Data>? data;

  EventModel({this.status, this.message, this.data});

  EventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? uuid;
  int? userId;
  String? title;
  String? description;
  String? eventDate;
  String? location;
  String? startTime;
  String? startTimeType;
  String? endTime;
  String? endTimeType;
  String? image;
  String? eventVenueName;
  String? eventVenueAddress1;
  String? eventVenueAddress2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? createdAt;
  String? updatedAt;
  int? status;
  String? endMinuteTime;
  String? startMinuteTime;
  String? qrCode;
  String? startTimeFormat;
  int? feedback;
  String? eventStartDate;
  String? eventEndDate;
  Null? whyAttendInfo;
  Null? moreInformation;
  Null? tAndConditions;
  int? totalAttendee;
  int? totalAccepted;
  int? totalNotAccepted;
  int? totalRejected;

  Data(
      {this.id,
        this.uuid,
        this.userId,
        this.title,
        this.description,
        this.eventDate,
        this.location,
        this.startTime,
        this.startTimeType,
        this.endTime,
        this.endTimeType,
        this.image,
        this.eventVenueName,
        this.eventVenueAddress1,
        this.eventVenueAddress2,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.endMinuteTime,
        this.startMinuteTime,
        this.qrCode,
        this.startTimeFormat,
        this.feedback,
        this.eventStartDate,
        this.eventEndDate,
        this.whyAttendInfo,
        this.moreInformation,
        this.tAndConditions,
        this.totalAttendee,
        this.totalAccepted,
        this.totalNotAccepted,
        this.totalRejected});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    eventDate = json['event_date'];
    location = json['location'];
    startTime = json['start_time'];
    startTimeType = json['start_time_type'];
    endTime = json['end_time'];
    endTimeType = json['end_time_type'];
    image = json['image'];
    eventVenueName = json['event_venue_name'];
    eventVenueAddress1 = json['event_venue_address_1'];
    eventVenueAddress2 = json['event_venue_address_2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    endMinuteTime = json['end_minute_time'];
    startMinuteTime = json['start_minute_time'];
    qrCode = json['qr_code'];
    startTimeFormat = json['start_time_format'];
    feedback = json['feedback'];
    eventStartDate = json['event_start_date'];
    eventEndDate = json['event_end_date'];
    whyAttendInfo = json['why_attend_info'];
    moreInformation = json['more_information'];
    tAndConditions = json['t_and_conditions'];
    totalAttendee = json['total_attendee'];
    totalAccepted = json['total_accepted'];
    totalNotAccepted = json['total_not_accepted'];
    totalRejected = json['total_rejected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['event_date'] = this.eventDate;
    data['location'] = this.location;
    data['start_time'] = this.startTime;
    data['start_time_type'] = this.startTimeType;
    data['end_time'] = this.endTime;
    data['end_time_type'] = this.endTimeType;
    data['image'] = this.image;
    data['event_venue_name'] = this.eventVenueName;
    data['event_venue_address_1'] = this.eventVenueAddress1;
    data['event_venue_address_2'] = this.eventVenueAddress2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['end_minute_time'] = this.endMinuteTime;
    data['start_minute_time'] = this.startMinuteTime;
    data['qr_code'] = this.qrCode;
    data['start_time_format'] = this.startTimeFormat;
    data['feedback'] = this.feedback;
    data['event_start_date'] = this.eventStartDate;
    data['event_end_date'] = this.eventEndDate;
    data['why_attend_info'] = this.whyAttendInfo;
    data['more_information'] = this.moreInformation;
    data['t_and_conditions'] = this.tAndConditions;
    data['total_attendee'] = this.totalAttendee;
    data['total_accepted'] = this.totalAccepted;
    data['total_not_accepted'] = this.totalNotAccepted;
    data['total_rejected'] = this.totalRejected;
    return data;
  }
}
