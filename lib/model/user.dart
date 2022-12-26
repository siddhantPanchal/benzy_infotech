import 'dart:convert';

class User {
  User({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.image,
    required this.isPhoneVerified,
    required this.emailVerifiedAt,
    required this.emailVerificationToken,
    required this.cmFirebaseToken,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.orderCount,
    required this.empId,
    required this.departmentId,
    required this.isVeg,
    required this.isSatOpted,
  });

  final int id;
  final String fName;
  final String lName;
  final String phone;
  final String email;
  final dynamic image;
  final int isPhoneVerified;
  final dynamic emailVerifiedAt;
  final dynamic emailVerificationToken;
  final String cmFirebaseToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final int orderCount;
  final String empId;
  final int departmentId;
  final int isVeg;
  final int isSatOpted;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'email': email,
      'image': image,
      'isPhoneVerified': isPhoneVerified,
      'emailVerifiedAt': emailVerifiedAt,
      'emailVerificationToken': emailVerificationToken,
      'cmFirebaseToken': cmFirebaseToken,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'status': status,
      'orderCount': orderCount,
      'empId': empId,
      'departmentId': departmentId,
      'isVeg': isVeg,
      'isSatOpted': isSatOpted,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['id'] ?? 0) as int,
      fName: (map['f_name'] ?? '') as String,
      lName: (map['lName'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      image: map['image'] as dynamic,
      isPhoneVerified: (map['isPhoneVerified'] ?? 0) as int,
      emailVerifiedAt: map['emailVerifiedAt'] as dynamic,
      emailVerificationToken: map['emailVerificationToken'] as dynamic,
      cmFirebaseToken: (map['cmFirebaseToken'] ?? '') as String,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int),
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch((map['updatedAt'] ?? 0) as int),
      status: (map['status'] ?? 0) as int,
      orderCount: (map['orderCount'] ?? 0) as int,
      empId: (map['emp_id'] ?? '') as String,
      departmentId: (map['departmentId'] ?? 0) as int,
      isVeg: (map['isVeg'] ?? 0) as int,
      isSatOpted: (map['isSatOpted'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fName == fName &&
        other.lName == lName &&
        other.phone == phone &&
        other.email == email &&
        other.image == image &&
        other.isPhoneVerified == isPhoneVerified &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.emailVerificationToken == emailVerificationToken &&
        other.cmFirebaseToken == cmFirebaseToken &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.status == status &&
        other.orderCount == orderCount &&
        other.empId == empId &&
        other.departmentId == departmentId &&
        other.isVeg == isVeg &&
        other.isSatOpted == isSatOpted;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      fName,
      lName,
      phone,
      email,
      image,
      isPhoneVerified,
      emailVerifiedAt,
      emailVerificationToken,
      cmFirebaseToken,
      createdAt,
      updatedAt,
      status,
      orderCount,
      empId,
      departmentId,
      isVeg,
      isSatOpted,
    ]);
  }

  @override
  String toString() {
    return 'User(id: $id, fName: $fName, lName: $lName, phone: $phone, email: $email, image: $image, isPhoneVerified: $isPhoneVerified, emailVerifiedAt: $emailVerifiedAt, emailVerificationToken: $emailVerificationToken, cmFirebaseToken: $cmFirebaseToken, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, orderCount: $orderCount, empId: $empId, departmentId: $departmentId, isVeg: $isVeg, isSatOpted: $isSatOpted)';
  }

  User copyWith({
    int? id,
    String? fName,
    String? lName,
    String? phone,
    String? email,
    String? image,
    int? isPhoneVerified,
    String? emailVerifiedAt,
    String? emailVerificationToken,
    String? cmFirebaseToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? status,
    int? orderCount,
    String? empId,
    int? departmentId,
    int? isVeg,
    int? isSatOpted,
  }) {
    return User(
      id: id ?? this.id,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      emailVerificationToken:
          emailVerificationToken ?? this.emailVerificationToken,
      cmFirebaseToken: cmFirebaseToken ?? this.cmFirebaseToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      orderCount: orderCount ?? this.orderCount,
      empId: empId ?? this.empId,
      departmentId: departmentId ?? this.departmentId,
      isVeg: isVeg ?? this.isVeg,
      isSatOpted: isSatOpted ?? this.isSatOpted,
    );
  }
}
