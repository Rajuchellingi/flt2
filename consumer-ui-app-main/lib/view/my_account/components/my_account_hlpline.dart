import 'package:flutter/material.dart';

class HelpSupportCard extends StatelessWidget {
  const HelpSupportCard({key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help & Support',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              'Need help? Get in touch with us.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            _buildSupportOption(
              icon: Icons.chat_bubble_outline,
              text: 'Chat with Support',
              bgColor: Colors.green.shade50,
              textColor: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildSupportOption(
                icon: Icons.email_outlined, text: 'Email Support'),
            const SizedBox(height: 12),
            _buildSupportOption(icon: Icons.help_outline, text: 'Browse FAQ'),
            const SizedBox(height: 12),
            _buildSupportOption(
                icon: Icons.call_outlined, text: 'Call Helpline'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                'View All Help Options',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String text,
    Color? bgColor,
    Color? textColor,
  }) {
    return Container(
      decoration: bgColor != null
          ? BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
            )
          : null,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: textColor ?? Colors.green),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
