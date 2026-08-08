import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
          ),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC5A059),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 55,
                      color: Color(0xFF4E3700),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Welcome to Habesha Mart',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Personal Information',
              onTap: () {},
            ),

            _buildProfileOption(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {},
            ),

            _buildProfileOption(
              icon: Icons.location_on_outlined,
              title: 'My Addresses',
              onTap: () {},
            ),

            _buildProfileOption(
              icon: Icons.favorite_border,
              title: 'Wishlist',
              onTap: () {},
            ),

            _buildProfileOption(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),

            _buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFFAC322E),
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFAC322E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  side: const BorderSide(
                    color: Color(0xFFAC322E),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE7E8E9),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF1E8D3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF775A19),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191C1D),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFF775A19),
        ),
      ),
    );
  }
}