import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository_provider.dart';



class AuthNotifier extends Notifier<AsyncValue<bool>> {


  @override
  AsyncValue<bool> build() {

    return const AsyncData(false);

  }



  Future<void> login(
    String username,
    String password,
  ) async {


    state = const AsyncLoading();


    try {


      final repository =
          ref.read(authRepositoryProvider);


      await repository.login(
        username,
        password,
      );


      state = const AsyncData(true);



    } catch(e, stackTrace){


      state = AsyncError(
        e,
        stackTrace,
      );


      rethrow;

    }

  }

}



final authProvider =
    NotifierProvider<AuthNotifier, AsyncValue<bool>>(
      AuthNotifier.new,
    );