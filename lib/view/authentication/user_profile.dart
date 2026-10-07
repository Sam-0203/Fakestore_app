import 'package:fakestore/controller/user_provider.dart';
import 'package:fakestore/core/utils/token_save.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();

    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final userId = await SaveToken.getUserId();

    if (userId != null) {
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).fetchSingleUserDetails(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    final user = provider.singleUser;

    if (user == null) {
      return const Center(child: Text('No User Data Found'));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            /// PROFILE IMAGE
            Container(
              height: 110,
              width: 110,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade100,

                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),

                    blurRadius: 12,

                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Icon(Icons.person, size: 65, color: Colors.green.shade700),
            ),

            const SizedBox(height: 15),

            /// USER NAME
            Text(
              '${user.name.firstname} ${user.name.lastname}',

              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            /// EMAIL
            Text(
              user.email,

              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 25),

            /// DETAILS CARD
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),

                      blurRadius: 10,

                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    _buildTile(
                      icon: Icons.person_outline,

                      title: 'Username',

                      value: user.username,
                    ),

                    _buildTile(
                      icon: Icons.phone_outlined,

                      title: 'Phone',

                      value: user.phone,
                    ),

                    _buildTile(
                      icon: Icons.location_on_outlined,

                      title: 'City',

                      value: user.address.city,
                    ),

                    _buildTile(
                      icon: Icons.home_outlined,

                      title: 'Street',

                      value: '${user.address.number}, ${user.address.street}',
                    ),

                    _buildTile(
                      icon: Icons.markunread_mailbox_outlined,

                      title: 'Zip Code',

                      value: user.address.zipcode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: Colors.green.shade50,

            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(icon, color: Colors.green),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 2),

              Text(
                value,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontSize: 15,

                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
