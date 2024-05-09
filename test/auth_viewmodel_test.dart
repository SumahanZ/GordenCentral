// // ignore_for_file: null_argument_to_non_null_type
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:tugas_akhir_project/core/auth/repositories/implementations/auth_repository_impl.dart';
// import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
// import 'package:tugas_akhir_project/core/auth/viewmodels/auth_viewmodel.dart';
// import 'package:tugas_akhir_project/models/user.dart';
// import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

// class MockAuthRepository extends Mock implements AuthRepositoryImpl {}

// class MockSharedStorage extends Mock
//     implements SharedPreferenceRepositoryImpl {}

// // a generic Listener class, used to keep track of when a provider notifies its listeners
// class Listener<T> extends Mock {
//   void call(T? previous, T next);
// }

// void main() {
//   setUpAll(() {
//     registerFallbackValue(const AsyncLoading<void>());
//   });
//   // a helper method to create a ProviderContainer that overrides the authRepositoryProvider
//   ProviderContainer makeProviderContainer(
//       MockAuthRepository authRepository, MockSharedStorage storage) {
//     final container = ProviderContainer(
//       overrides: [
//         authRepositoryProvider.overrideWithValue(authRepository),
//         sharedPreferenceRepositoryProvider.overrideWithValue(storage),
//       ],
//     );
//     addTearDown(container.dispose);
//     return container;
//   }

//   test("initial state is AsyncData", () {
//     final authRepository = MockAuthRepository();
//     final storageRepository = MockSharedStorage();
//     // create the ProviderContainer with the mock auth repository;
//     final container = makeProviderContainer(authRepository, storageRepository);
//     // create a listener
//     final listener = Listener<AsyncValue<void>>();
//     // listen to the provider and call [listener] whenever its value changes
//     container.listen(authViewModelProvider, listener, fireImmediately: true);

//     //verify
//     verify(
//       // the build method returns a value immediately, so we expect AsyncData
//       () => listener(null, const AsyncData<void>(null)),
//     );

//     // verify that the listener is no longer called
//     verifyNoMoreInteractions(listener);
//     // verify that [signInAnonymously] was not called during initialization
//     //define dummy dependencies
//     const String name = "Kevin";
//     const String password = "kenarok999";
//     const String email = "kevinsu16@yahoo.com";
//     verifyNever(
//       () => authRepository
//           .signUpCustomer(name: name, password: password, email: email)
//           .run(),
//     );
//     verifyNever(() => storageRepository.saveToken(token: "token"));
//   });

//   test("sign-up success", () async {
//     const String name = "Kevin";
//     const String password = "kenarok999";
//     const String email = "kevinsu16@yahoo.com";
//     final authRepository = MockAuthRepository();
//     final storageRepository = MockSharedStorage();
//     //THIS IS THE ONLY PROBLEM WITH THE TEST CODE
//     when(() => authRepository.signUpCustomer(
//             name: name, password: password, email: email))
//         .thenAnswer((_) => TaskEither<ApiError, User>.of(User(
//               email: "sup",
//               name: "dummyname",
//               password: "dummypassword",
//               token: "token",
//               type: "dummy",
//             )));
//     when(() => storageRepository.saveToken(token: "token"))
//         .thenAnswer((invocation) => Future.value());
//     // create the ProviderContainer with the mock auth repository
//     final container = makeProviderContainer(authRepository, storageRepository);
//     //create a listener
//     final listener = Listener<AsyncValue<void>>();
//     // listen to the provider and call [listener] whenever its value changes
//     container.listen(
//       authViewModelProvider,
//       listener,
//       fireImmediately: true,
//     );
//     // store this into a variable since we'll need it multiple times
//     const data = AsyncData<void>(null);
//     // verify initial value from the build method
//     verify(() => listener(null, data));
//     // get the controller via container.read
//     final authController = container.read(authViewModelProvider.notifier);
//     // run
//     authController.signUpCustomer(
//         name: name, password: password, email: email, fromTest: true);

//     // final result = await authRepository
//     //     .signUpCustomer(name: name, password: password, email: email)
//     //     .run();
//     // expect(
//     //     result,
//     //     Either<ApiError, User>.right(User(
//     //       email: "sup",
//     //       name: "dummyname",
//     //       password: "dummypassword",
//     //       token: "token",
//     //       type: "dummy",
//     //     )));

//     // verify
//     verifyInOrder([
//       // set loading state
//       // * use a matcher since AsyncLoading != AsyncLoading with data
//       () => listener(data, any(that: isA<AsyncLoading>())),
//       // data when complete
//       () => listener(any(that: isA<AsyncLoading>()), data),
//     ]);
//     verifyNoMoreInteractions(listener);
//     verify(() => authRepository
//         .signUpCustomer(name: name, password: password, email: email)
//         .run()).called(1);
//     // verify(() => storageRepository.saveToken(token: "token")).called(1);
//   });
// }
