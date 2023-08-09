import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/audio_cubit.dart';
import 'package:music_player/screens/main_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Utils/configurations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  requestPermissionsOnStartup().then((value) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          // Apply the custom font to all TextStyles using the customTextStyle method.
          bodyLarge: AppTheme.customTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
          bodyMedium: AppTheme.customTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: AppTheme.customTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          displayLarge: AppTheme.customTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: AppTheme.customTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
          displaySmall: AppTheme.customTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          titleLarge: AppTheme.customTextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
          // Add more text styles as needed.
        ),
      ),
      home: BlocProvider<AudioCubit>(
        create: (context) => AudioCubit(),
        child: MainScreen(),
      ),
    );
  }
}

Future<void> requestPermissionsOnStartup() async {
  // Request the required permissions here
  Map<Permission, PermissionStatus> statuses = await [
    Permission.audio,
    // Add more permissions here if needed
  ].request();

  // Check if any of the permissions are denied
  bool allGranted = true;
  statuses.forEach((permission, status) {
    if (!status.isGranted) {
      allGranted = false;
    }
  });

  if (!allGranted) {
    // Handle the case when some or all permissions are denied
    print('Some or all permissions were denied.');
  }
}
