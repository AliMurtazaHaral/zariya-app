class UserModel {
  String? userName;
  String? email;
  String? password;
  String? city;
  String? address;
  String? profession;
  String? pose;
  String? vote;
  String? fullName;
  String? status;
  String? taskNumber;
  String? campaignName;
  String? cnic;
  String? phoneNumber;
  String? targetAmount;
  String? docs;
  String? campaignDocs;
  String? donortype;
  String? foodamount;
  String? cmapaignImageReference;
  String? raisedAmount;
  String? rating;
  UserModel(
      {
        this.rating,
        this.raisedAmount,
        this.cmapaignImageReference,
        this.donortype,
        this.status,
        this.fullName,
        this.taskNumber,
        this.pose,
        this.userName,
        this.email,
        this.password,
        this.city,
        this.address,
        this.profession,
        this.vote,
        this.docs,
        this.cnic,
        this.phoneNumber,
        this.campaignDocs,
        this.campaignName,
        this.targetAmount,
        this.foodamount
      });

  // receiving data from server
  factory UserModel.fromMapRegsitration(map) {
    return UserModel(
        email: map['email'],
        password: map['password'],
        city: map['city'],
        fullName: map['fullName']
    );
  }
  // sending data to our server
  Map<String, dynamic> toMapRegistration() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'city': city
    };
  }
  Map<String, dynamic> toRaisedAmount() {
    return {
      'raisedAmount': raisedAmount
    };
  }
  Map<String, dynamic> toRateDonation() {
    return {
      'rating': rating
    };
  }
  Map<String, dynamic> toMapCampaign() {
    return {
      'campaignName': campaignName,
      'fullName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'cnic':cnic,
      'city':city,
      'address':address,
      'targetAmount':targetAmount,
      'docs':docs,
      'campaignDocs':campaignDocs,
      'campaignImageReference':cmapaignImageReference,
      'status':'pending',
      'rating':'5',
      'raisedAmount': '0',
      'description': 'Challenge The Tharparkar district, spread over 22,000 square kilometres, is a chronically poor area with an estimated population of 1.2 million. Of these, 95 % live in around 2,000 villages. Water shortage is a major problem of the area. In Tharparkar, dug-wells have been found to be the only sustainable source of groundwater. During a normal day, villagers spend around four to six hours on average to fetch four to five pots (50 to 60 litres) of water from dug-wells, situated far and wide. Solution Embarking upon this emergent need of Drinking water, the Customs Health Care Society will dig 40 water well in Goths (villages) of Tharparkar where there are no wells. These wells will provide Safe Drinking water to 12000 persons of 40 villages at their doorsteps. The social life of villagers is also restricted due to lack of adequate water. This especially affects women, who are responsible for carrying water. Young children often have to forgo education due to responsibility of fetching water Long-Term Impact This project will go a long way in improving the socioeconomic conditions of the people of tharparkar in general and women and children in particular, Due to scarcity of water and non existence of water resources in their own Goths (villages) the women and children have to travel long distances daily to fetch water from far flung areas. The water wells dug will provide 12000 persons of 40 villages, ample drinking as well as usable water at their doorstep which will also improve their health.'
    };
  }
  Map<String, dynamic> toMapDonor() {
    return {
      'fullName': fullName,
      'email': email,
      'donorType': donortype,
      'foodAmount':foodamount,
      'city':city,
      'address':address,
      'targetAmount':targetAmount,
      'password':password,
    };
  }
  Map<String, dynamic> toBecomePlayerRegistration() {
    return {
      'city': city,
      'email': email,
      'userName': userName,
      'password': password,
      'address': address,
      'profession': 'Player'
    };
  }
  Map<String, dynamic> toTask() {
    return {
      'pose':pose,
      'userName': userName,
      'taskNumber':taskNumber
    };
  }
  Map<String, dynamic> toVote() {
    return {
      'vote':'1'
    };
  }
  Map<String, dynamic> toStatus() {
    return {
      'status':status
    };
  }
  Map<String, dynamic> toUpdateAudience() {
    return {
      'userName':userName
    };
  }
  Map<String, dynamic> toUpdatePlayerRegistration() {
    return {
      'city': city,
      'userName': userName,
      'address': address,
    };
  }
}
