import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/viewmodels/auth_viewmodel.dart';
import 'package:tugas_akhir_project/utils/helpers/awesome_notification_helper.dart';
import 'package:tugas_akhir_project/utils/helpers/firebase_helper.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';
import 'package:tugas_akhir_project/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "TugasAkhirSkripsi-PN",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LocalNotificationHelper.initHelper();
  FirebaseHelper.initHelper();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(authViewModelProvider.notifier)
          .getUserInformation()
          .then((value) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        dividerColor: Colors.transparent,
        primaryColor: const Color.fromARGB(255, 248, 248, 255),
        useMaterial3: true,
      ),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          if (userState != null && userState.personalizationFinished == true) {
            return (userState.type == "pemilik" || userState.type == "karyawan")
                ? loggedInInternalRoute
                : loggedInCustomerRoute;
          }
          return loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
