import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/data/repositories_impl/account_repository_impl.dart';
import 'package:flutter_application_1/app/data/repositories_impl/preferences_repository_impl.dart';
import 'package:flutter_application_1/app/data/repositories_impl/sing_up_repository_impl.dart';
import 'package:flutter_application_1/app/domain/repositories/acxount_repository.dart';
import 'package:flutter_application_1/app/domain/repositories/preferences_repositories.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu/meedu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories_impl/authentication_repository_impl.dart';
import 'domain/repositories/authentication_repository.dart';
import 'domain/repositories/sing_up_repository.dart';

Future<void> injectDependencies()async {
  final preferences = await SharedPreferences.getInstance();

  Get.i.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );

  Get.i.lazyPut<SingUpRepository>(
    () => SingUpRepositoryImpl(FirebaseAuth.instance),
  );

  Get.i.lazyPut<AccountRepository>(() => AccountRepositoryImpl(
        FirebaseAuth.instance,
      ));

  Get.i.lazyPut<PreferencesRepository>(() => PreferencesRepositoryImpl(preferences));
}
