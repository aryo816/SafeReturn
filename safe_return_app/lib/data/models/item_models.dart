enum ItemStatus {
  reported,
  stored,
  matched,
  claimApproved,
  pendingReview,
  claimed,
  returned,
}

extension ItemStatusX on ItemStatus {
  String get label {
    switch (this) {
      case ItemStatus.reported:
        return 'Reported';
      case ItemStatus.stored:
        return 'Stored';
      case ItemStatus.matched:
        return 'Matched';
      case ItemStatus.claimApproved:
        return 'Claim Approved';
      case ItemStatus.pendingReview:
        return 'Pending Review';
      case ItemStatus.claimed:
        return 'Claimed';
      case ItemStatus.returned:
        return 'Returned';
    }
  }
}

class FoundItem {
  final String id;
  final String title;
  final String category;
  final String color;
  final String location;
  final String dateTime;
  final String shelfNumber;
  final String reporterName;
  final String secretDetails; // Only visible to security staff
  final ItemStatus status;
  final String? claimantName;
  final String? studentId;
  final int? matchScore;

  FoundItem({
    required this.id,
    required this.title,
    required this.category,
    required this.color,
    required this.location,
    required this.dateTime,
    this.shelfNumber = 'A-03',
    this.reporterName = 'Dimas Pratama',
    this.secretDetails = 'Cream stitching inside, three card slots; a library card.',
    this.status = ItemStatus.stored,
    this.claimantName,
    this.studentId,
    this.matchScore,
  });

  FoundItem copyWith({
    String? id,
    String? title,
    String? category,
    String? color,
    String? location,
    String? dateTime,
    String? shelfNumber,
    String? reporterName,
    String? secretDetails,
    ItemStatus? status,
    String? claimantName,
    String? studentId,
    int? matchScore,
  }) {
    return FoundItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      color: color ?? this.color,
      location: location ?? this.location,
      dateTime: dateTime ?? this.dateTime,
      shelfNumber: shelfNumber ?? this.shelfNumber,
      reporterName: reporterName ?? this.reporterName,
      secretDetails: secretDetails ?? this.secretDetails,
      status: status ?? this.status,
      claimantName: claimantName ?? this.claimantName,
      studentId: studentId ?? this.studentId,
      matchScore: matchScore ?? this.matchScore,
    );
  }
}

class ClaimRequest {
  final String claimId;
  final String itemId;
  final String claimantName;
  final String studentId;
  final String submissionTime;
  final String answerDetails;
  final String answerContents;
  final String answerTimeLocation;
  final ItemStatus status;
  final String? rejectionReason;

  ClaimRequest({
    required this.claimId,
    required this.itemId,
    required this.claimantName,
    required this.studentId,
    required this.submissionTime,
    required this.answerDetails,
    required this.answerContents,
    required this.answerTimeLocation,
    this.status = ItemStatus.pendingReview,
    this.rejectionReason,
  });
}
