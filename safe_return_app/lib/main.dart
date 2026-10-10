import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/shared_components.dart';
import 'data/models/item_models.dart';
import 'data/repositories/safe_return_repository.dart';

void main() {
  runApp(const SafeReturnApp());
}

class SafeReturnApp extends StatelessWidget {
  const SafeReturnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeReturn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primaryBlue,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryBlue,
          surface: AppColors.background,
        ),
      ),
      home: const MainAppNavigationShell(),
    );
  }
}

class MainAppNavigationShell extends StatefulWidget {
  const MainAppNavigationShell({Key? key}) : super(key: key);

  @override
  State<MainAppNavigationShell> createState() => _MainAppNavigationShellState();
}

class _MainAppNavigationShellState extends State<MainAppNavigationShell> {
  final MockSafeReturnRepository _repo = MockSafeReturnRepository();
  int _activeRoleIndex = 0; // 0: User, 1: Guard, 2: Supervisor
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('SR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'SafeReturn',
              style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHeading, fontSize: 18),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            initialValue: _activeRoleIndex,
            onSelected: (val) {
              setState(() {
                _activeRoleIndex = val;
                _navIndex = 0;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Chip(
                backgroundColor: AppColors.primaryBlueLight,
                label: Text(
                  _activeRoleIndex == 0 ? 'User' : (_activeRoleIndex == 1 ? 'Guard' : 'Supervisor'),
                  style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0, child: Text('Mode Mahasiswa (User)')),
              const PopupMenuItem(value: 1, child: Text('Mode Satpam (Guard)')),
              const PopupMenuItem(value: 2, child: Text('Mode Supervisor (Audit)')),
            ],
          ),
        ],
      ),
      body: _buildCurrentBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCurrentBody() {
    if (_activeRoleIndex == 0) {
      if (_navIndex == 0) return _buildUserHome();
      if (_navIndex == 1) return _buildCatalog();
      return _buildUserProfile();
    } else if (_activeRoleIndex == 1) {
      if (_navIndex == 0) return _buildGuardHome();
      if (_navIndex == 1) return _buildGuardInventory();
      if (_navIndex == 2) return _buildGuardClaims();
      return _buildGuardProfile();
    } else {
      return _buildSupervisorView();
    }
  }

  Widget _buildBottomNav() {
    if (_activeRoleIndex == 0) {
      return BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Found Items'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      );
    } else if (_activeRoleIndex == 1) {
      return BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Claims'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  // --- Screens Builders matching Figma ---
  Widget _buildUserHome() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Welcome, Naya', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primaryBlue)),
        const SizedBox(height: 4),
        const Text('Report lost or found items securely and track their progress.', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 24),
        const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _actionCard('Report a Found Item', 'Report an item found on campus to help locate its owner.', Icons.inventory_2_outlined),
        const SizedBox(height: 12),
        _actionCard('Report a Lost Item', 'Submit a lost-item report to help security staff identify a match.', Icons.search),
        const SizedBox(height: 24),
        const Text('My Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Brown Wallet', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  StatusBadge(status: ItemStatus.claimApproved),
                ],
              ),
              const SizedBox(height: 4),
              const Text('Found outside the Central Library at 12:45 WIB', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('SR-20261009-1024', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  Text('View Details ›', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _actionCard(String title, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFFEA580C)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 2),
                Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildCatalog() {
    final items = _repo.getStoredItems();
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Found Items', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Find your belongings on campus', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        ...items.map((item) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.border)),
          elevation: 0,
          child: ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: AppColors.itemBrown, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.wallet, color: Colors.white),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text('${item.location} · ${item.dateTime}', style: const TextStyle(fontSize: 12)),
            trailing: StatusBadge(status: item.status),
          ),
        )),
      ],
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        ListTile(
          tileColor: AppColors.surfaceCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: const CircleAvatar(backgroundColor: AppColors.primaryBlueLight, child: Text('NP', style: TextStyle(color: AppColors.primaryBlue))),
          title: const Text('Naya Putri', style: TextStyle(fontWeight: FontWeight.w700)),
          subtitle: const Text('Student · 2304101024'),
        ),
      ],
    );
  }

  Widget _buildGuardHome() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Welcome, Budi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Friday, 9 October 2026', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: const [
              _InfoRow(label: 'Officer', value: 'Budi Santoso'),
              _InfoRow(label: 'Service Location', value: 'Main Security Post'),
              _InfoRow(label: 'Shift', value: '08:00–16:00 WIB'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppButton(
          label: 'Receive an Item (Finder Intake)',
          isPrimary: false,
          icon: const Icon(Icons.qr_code_scanner, color: AppColors.primaryBlue),
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        AppButton(
          label: 'Return an Item (Owner Handover)',
          isPrimary: false,
          icon: const Icon(Icons.assignment_ind_outlined, color: AppColors.primaryBlue),
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        const SecurityStaffCard(
          title: 'Retake the Photo and Assign a Shelf',
          content: 'Confirm the category and shelf number before storing the item in the secure locker.',
        ),
      ],
    );
  }

  Widget _buildGuardInventory() {
    final items = _repo.getStoredItems();
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Inventory', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Main Security Post · Stored Items', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        ...items.map((item) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.border)),
          child: ListTile(
            title: Text('${item.title} (Shelf ${item.shelfNumber})', style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(item.dateTime, style: const TextStyle(fontSize: 12)),
            trailing: StatusBadge(status: item.status),
          ),
        )),
      ],
    );
  }

  Widget _buildGuardClaims() {
    final queue = _repo.getClaimsQueue();
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Claim Queue', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Claims awaiting security review', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        ...queue.map((item) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.border)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    const StatusBadge(status: ItemStatus.pendingReview),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Claimant: ${item.claimantName ?? "-"} (Student ID: ${item.studentId ?? "-"})', style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                        onPressed: () {
                          setState(() {
                            _repo.approveClaim(item.id);
                          });
                        },
                        child: const Text('Approve'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(foregroundColor: AppColors.statusRed, side: const BorderSide(color: AppColors.statusRed)),
                        onPressed: () {
                          setState(() {
                            _repo.rejectClaim(item.id, 'Data tidak cocok');
                          });
                        },
                        child: const Text('Reject'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildGuardProfile() {
    return Padding(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Security Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        ListTile(
          tileColor: AppColors.surfaceCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: const CircleAvatar(backgroundColor: AppColors.primaryBlueLight, child: Text('BS', style: TextStyle(color: AppColors.primaryBlue))),
          title: const Text('Budi Santoso', style: TextStyle(fontWeight: FontWeight.w700)),
          subtitle: const Text('Officer ID: SAT-001 · Main Security Post'),
        ),
      ],
    );
  }

  Widget _buildSupervisorView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      children: const [
        Text('Supervisor Audit Log', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        Text('Read-Only Campus Oversight', style: TextStyle(color: AppColors.textSecondary)),
        SizedBox(height: 20),
        SecurityStaffCard(
          title: 'Chain of Custody Log (SR-20261009-1024)',
          content: '1. Finder Dimas Pratama submitted item.\n2. Guard Budi Santoso confirmed receipt and assigned to Shelf A-03.\n3. Claimant Naya Putri submitted claim.\n4. Guard verified answers & approved.\n5. Handover completed with student ID check.',
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
