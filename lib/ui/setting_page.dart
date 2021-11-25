import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/setting_provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => SettingProvider().setup(),
        child: Consumer<SettingProvider>(
          builder: (context, provider, _) {
            return ListTile(
              title: Text('Notification'),
              subtitle: Text('Random Restaurant at 11 AM'),
              trailing: Container(
                margin: const EdgeInsets.all(16.0),
                child: Switch.adaptive(
                  value: provider.isScheduled,
                  onChanged: (value) async {
                    await provider.setScheduled(value);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
