import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/style/app_color.dart';

import '../model/partner.dart';
import '../model/tag.dart';
import '../src/enum.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      appBar: AppBar(title: const Text("Profile"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildProfileCard(),
            const SizedBox(height: 10),
            _buildButton(label: "Master Sync", icon: Icons.sync,color: Colors.green,textColor: Colors.black),
            const SizedBox(height: 10),
            _buildSettingsCard(),
            const SizedBox(height: 10,),
          ],
        ),
      ),
      persistentFooterButtons: [
        _buildButton(label: "Sign Out", icon: Icons.logout,color: AppColors.dangerColor),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wai Lin Naing",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                _buildInfoRow(Icons.phone, "09-777789648"),
                _buildInfoRow(Icons.email_outlined, "wailinnaing@gmial.com"),
                _buildInfoRow(Icons.device_unknown, "SR1"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(info, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
    Color? color,
    Color? textColor,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:color ?? AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      onPressed: onPressed ?? () => debugPrint("Sync"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 18,color:textColor ?? Colors.white)),
          const SizedBox(width: 8),
          Icon(icon, size: 25,color: textColor,),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Card(
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: 'Vehicle',
              decoration: const InputDecoration(border: InputBorder.none),
              items: const [
                DropdownMenuItem(value: 'Vehicle', child: Text("Vehicle"))
              ],
              onChanged: (value) {},
            ),
            const Divider(),
            _buildSettingsOption("Copy Database", Icons.copy, () {
              debugPrint("Copy Database");
            }),
            const Divider(),
            _buildSettingsOption("Version", null, null, trailingText: "1.2.1"),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(String title, IconData? icon, VoidCallback? onTap, {String? trailingText}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, size: 25),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18)),
              ],
            ),
            if (trailingText != null)
              Text(trailingText, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
