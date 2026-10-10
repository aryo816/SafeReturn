import '../models/item_models.dart';

abstract class SafeReturnRepository {
  List<FoundItem> getStoredItems();
  List<FoundItem> getUserReports();
  List<FoundItem> getClaimsQueue();
  FoundItem? getItemById(String id);
  void addFoundItem(FoundItem item);
  void updateItemShelf(String id, String shelfNumber, String secretDetails);
  void approveClaim(String itemId);
  void rejectClaim(String itemId, String reason);
  void completeHandover(String itemId);
}

class MockSafeReturnRepository implements SafeReturnRepository {
  static final MockSafeReturnRepository _instance = MockSafeReturnRepository._internal();
  factory MockSafeReturnRepository() => _instance;
  MockSafeReturnRepository._internal();

  final List<FoundItem> _items = [
    FoundItem(
      id: 'SR-20261009-1024',
      title: 'Brown Wallet',
      category: 'Wallet',
      color: 'Brown',
      location: 'Central Library',
      dateTime: '9 October 2026, 09:15 WIB',
      shelfNumber: 'A-03',
      reporterName: 'Dimas Pratama',
      secretDetails: 'Cream stitching inside, three card slots; a library card in Naya Putri\'s name.',
      status: ItemStatus.stored,
      claimantName: 'Naya Putri',
      studentId: '2304101024',
      matchScore: 92,
    ),
    FoundItem(
      id: 'SR-20261008-0891',
      title: 'Black Wallet',
      category: 'Wallet',
      color: 'Black',
      location: 'Building A',
      dateTime: '8 October 2026, 14:20 WIB',
      shelfNumber: 'A-02',
      reporterName: 'Andi Saputra',
      secretDetails: 'Red stitching inside, two card slots; student ID and library card.',
      status: ItemStatus.matched,
      claimantName: 'Raka Pradana',
      studentId: '2304101087',
    ),
    FoundItem(
      id: 'SR-20261009-1025',
      title: 'Blue Umbrella',
      category: 'Umbrella',
      color: 'Blue',
      location: 'Campus Cafeteria',
      dateTime: '9 October 2026, 10:05 WIB',
      shelfNumber: 'B-01',
      reporterName: 'Siti Rahma',
      secretDetails: 'Silver handle with tiny sticker at the bottom.',
      status: ItemStatus.stored,
      claimantName: 'Sinta Lestari',
    ),
    FoundItem(
      id: 'SR-20261008-0892',
      title: 'White Charger',
      category: 'Electronics',
      color: 'White',
      location: 'Building B',
      dateTime: '8 October 2026, 15:10 WIB',
      shelfNumber: 'C-02',
      reporterName: 'Farhan',
      secretDetails: '65W USB-C adapter with blue cable wrap.',
      status: ItemStatus.stored,
    ),
  ];

  @override
  List<FoundItem> getStoredItems() => List.unmodifiable(_items);

  @override
  List<FoundItem> getUserReports() => [
    _items[0].copyWith(status: ItemStatus.matched),
    FoundItem(
      id: 'SR-2025-05-13-0891',
      title: 'Lenovo ThinkPad Laptop',
      category: 'Electronics',
      color: 'Black',
      location: 'Building A at 09:20 WIB',
      dateTime: '13 May 2025, 09:20 WIB',
      status: ItemStatus.reported,
    ),
  ];

  @override
  List<FoundItem> getClaimsQueue() => _items.where((item) => item.claimantName != null && item.status != ItemStatus.returned).toList();

  @override
  FoundItem? getItemById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void addFoundItem(FoundItem item) {
    _items.insert(0, item);
  }

  @override
  void updateItemShelf(String id, String shelfNumber, String secretDetails) {
    final idx = _items.indexWhere((i) => i.id == id);
    if (idx != -1) {
      _items[idx] = _items[idx].copyWith(
        shelfNumber: shelfNumber,
        secretDetails: secretDetails,
        status: ItemStatus.stored,
      );
    }
  }

  @override
  void approveClaim(String itemId) {
    final idx = _items.indexWhere((i) => i.id == itemId);
    if (idx != -1) {
      _items[idx] = _items[idx].copyWith(status: ItemStatus.claimApproved);
    }
  }

  @override
  void rejectClaim(String itemId, String reason) {
    final idx = _items.indexWhere((i) => i.id == itemId);
    if (idx != -1) {
      _items[idx] = _items[idx].copyWith(status: ItemStatus.stored, claimantName: null);
    }
  }

  @override
  void completeHandover(String itemId) {
    final idx = _items.indexWhere((i) => i.id == itemId);
    if (idx != -1) {
      _items[idx] = _items[idx].copyWith(status: ItemStatus.returned);
    }
  }
}
