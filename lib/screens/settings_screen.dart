import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              'プライバシーポリシー',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.shield),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final url = Uri.parse(
                  'https://ru2lu.github.io/daily_spend_tracker_privacy_policy_site/');
              await launchUrl(url);
            },
          ),
          const ListTile(
            title: Text(
              '全てのデータを削除する',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
