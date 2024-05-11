// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:convert';
// ignore: implementation_imports
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/sources/profile_toko_repository.dart';
import 'package:tugas_akhir_project/models/beranda_toko.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/katalog_produk.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/promo.dart';
import 'package:tugas_akhir_project/models/province.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:riverpod/riverpod.dart';

part 'profile_toko_repository_impl.g.dart';

final httpClient = Provider((ref) => http.Client());
final profileTokoProvider =
    Provider((ref) => ProfileTokoRepositoryImpl(client: ref.watch(httpClient)));

final fetchTokoInformationProvider =
    FutureProvider.autoDispose<Either<ApiError, Toko?>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchTokoInformation(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

@riverpod
Future<Either<ApiError, Produk?>> fetchProdukDetailInternal(
    FetchProdukDetailInternalRef ref, int produkId) async {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response =
      tokoApi.fetchProdukDetail(ref: ref, produkId: produkId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
}

final fetchSingleKatalogProdukProvider = FutureProvider.family
    .autoDispose<Either<ApiError, KatalogProduk?>, int>((ref, int katalogId) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response =
      tokoApi.fetchSingleKatalogProduk(ref: ref, katalogId: katalogId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchBerandaTokoProvider =
    FutureProvider.autoDispose<Either<ApiError, List<BerandaToko>>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchBerandaToko(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchPromoItemsProvider =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchAvailablePromoItems(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchPromoProvider =
    FutureProvider.autoDispose<Either<ApiError, List<Promo>>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchPromos(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

@riverpod
Future<
        (
          Either<ApiError, List<BerandaToko>>,
          Either<ApiError, Toko?>,
          Either<ApiError, List<KatalogProduk>>
        )>
    fetchProfileInformation(FetchProfileInformationRef ref) async {
  final value1 = await ref.watch(fetchBerandaTokoProvider.future);
  final value2 = await ref.watch(fetchTokoInformationProvider.future);
  final value3 = await ref.watch(fetchKatalogProdukTokoPreview.future);
  return (value1, value2, value3);
}

final fetchCategoryItemProdukList =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchTokoProduk(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchKatalogProdukToko =
    FutureProvider.autoDispose<Either<ApiError, List<KatalogProduk>>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchKatalogProdukToko(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchProvinceslistFromProfileToko =
    FutureProvider.autoDispose<Either<ApiError, List<Province>>>((ref) {
  final accountApi = ref.watch(profileTokoRepositoryProvider);
  final response = accountApi.getProvinces(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchCitieslistFromProfileToko = FutureProvider.family
    .autoDispose<Either<ApiError, List<City>>, int>((ref, int provinceId) {
  final accountApi = ref.watch(profileTokoRepositoryProvider);
  final response = accountApi.getCities(ref: ref, provinceId: provinceId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchKatalogProdukTokoPreview =
    FutureProvider.autoDispose<Either<ApiError, List<KatalogProduk>>>((ref) {
  final tokoApi = ref.watch(profileTokoRepositoryProvider);
  final response = tokoApi.fetchKatalogProdukTokoPreview(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final profileTokoRepositoryProvider =
    Provider((ref) => ProfileTokoRepositoryImpl(client: ref.watch(httpClient)));

class ProfileTokoRepositoryImpl extends ProfileTokoRepository {
  final http.Client _client;

  ProfileTokoRepositoryImpl({
    required http.Client client,
  }) : _client = client;

  @override
  TaskEither<ApiError, Toko> createTokoInformation(
      {required TokoInformationRequest request, required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.createTokoInformationURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "tokoId": request.id,
            "tokoName": request.name,
            "tokoPhoneNumber": request.phoneNumber,
            "tokoProfilePhotoUrl": request.profilePhotoURL,
            "tokoStreetAddress": request.streetAddress,
            "cityId": request.cityId,
            "tokoCountry": request.country,
            "tokoPostalCode": request.postalCode,
            "tokoBio": request.bio,
            "tokoWhatsAppUrl": request.whatsAppURL,
            "tokoInviteCode": request.inviteCode,
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var toko = Toko.fromJson(response);
            return TaskEither.right(toko);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, Toko?> fetchTokoInformation({required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchPreviewTokoInformationURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var toko = Toko.fromJson(response);
            return TaskEither.right(toko);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<BerandaToko>> fetchBerandaToko({required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchBerandaInformationURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var berandaToko = List<BerandaToko>.from(response
                .where((e) => e != null)
                .map((e) => BerandaToko.fromJson(e)));

            return TaskEither.right(berandaToko);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> configureBerandaToko(
      {required Ref<Object?> ref, required List<String> imageUrls}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.configureBerandaTokoURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "imageUrls": imageUrls,
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<Produk>> fetchTokoProduk(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");

      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!,
      };

      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchCategoryItemsProdukListURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) {
      print(error);
      return RequestError(errorMessage: error.toString());
    }).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var listProduk = List<Produk>.from(response
                .where((e) => e != null)
                .map((e) => Produk.fromJson(e)));
            return TaskEither.right(listProduk);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }
        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> addKatalogProduk(
      {required Ref<Object?> ref,
      required List<Produk> produkList,
      required String katalogProdukName}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.addKatalogProdukURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "name": katalogProdukName,
            "produkIdList": produkList.map((e) => e.id).toList(),
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<KatalogProduk>> fetchKatalogProdukToko(
      {required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchKatalogProdukTokoURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var katalogProduk = List<KatalogProduk>.from(response
                .where((e) => e != null)
                .map((e) => KatalogProduk.fromJson(e)));

            return TaskEither.right(katalogProduk);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<KatalogProduk>> fetchKatalogProdukTokoPreview(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchKatalogProdukTokoPreviewURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var katalogProduk = List<KatalogProduk>.from(response
                .where((e) => e != null)
                .map((e) => KatalogProduk.fromJson(e)));

            return TaskEither.right(katalogProduk);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, KatalogProduk> fetchSingleKatalogProduk(
      {required Ref<Object?> ref, required int katalogId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          "${ApiVariables.fetchSingleKatalogProdukURL}/$katalogId");
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var katalogProduk = KatalogProduk.fromJson(response);
            return TaskEither.right(katalogProduk);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> editKatalogProduk(
      {required Ref<Object?> ref,
      required List<Produk> produkList,
      required String katalogProdukName,
      required int katalogId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.editKatalogProdukURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "name": katalogProdukName,
            "produkIdList": produkList.map((e) => e.id).toList(),
            "katalogId": katalogId
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(
            ResponseAPIError(
                responseStatusCode: value.statusCode,
                errorMessage: jsonDecode(value.body.toString())["error"]),
          );
      }
    });
  }

  @override
  TaskEither<ApiError, Produk> fetchProdukDetail(
      {required Ref<Object?> ref, required int produkId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          "${ApiVariables.fetchInternalProdukDetailURL}/$produkId");
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) {
      print(error);
      return RequestError(errorMessage: error.toString());
    }).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var produk = Produk.fromJson(response);
            return TaskEither.right(produk);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }
        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> editProduk(
      {required Ref<Object?> ref,
      required int produkId,
      required ProductSaved productSaved}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, "${ApiVariables.internalEditProdukURL}/$produkId");

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {"produkSaved": productSaved.toMap()},
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(
            ResponseAPIError(
                responseStatusCode: value.statusCode,
                errorMessage: jsonDecode(value.body.toString())["error"]),
          );
      }
    });
  }

  @override
  TaskEither<ApiError, List<City>> getCities(
      {required Ref<Object?> ref, required int provinceId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, "${ApiVariables.getCitiesURL}/$provinceId");
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var cities = List<City>.from(
                response.where((e) => e != null).map((e) => City.fromJson(e)));
            return TaskEither.right(cities);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }
        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<Province>> getProvinces(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL, ApiVariables.getProvincesURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var provinces = List<Province>.from(response
                .where((e) => e != null)
                .map((e) => Province.fromJson(e)));
            return TaskEither.right(provinces);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }
        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> addPromo(
      {required Ref<Object?> ref,
      required int produkId,
      required String expiredAt,
      required int discountPercent}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL, ApiVariables.addPromoURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "discountPercent": discountPercent,
            "expiredDate": expiredAt,
            "produkId": produkId
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> editPromo(
      {required Ref<Object?> ref,
      required int promoId,
      required int produkId,
      required String expiredAt,
      required int discountPercent}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, "${ApiVariables.editPromoURL}/$promoId");

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "discountPercent": discountPercent,
            "expiredDate": expiredAt,
            "produkId": produkId
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<Produk>> fetchAvailablePromoItems(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchAvailablePromoItemsURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var produk = List<Produk>.from(response
                .where((e) => e != null)
                .map((e) => Produk.fromJson(e)));

            return TaskEither.right(produk);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, bool> removePromo(
      {required Ref<Object?> ref, required int promoId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(
      () async {
        final token = await ref
            .read(sharedPreferenceRepositoryProvider)
            .getToken(key: "token");
        Map<String, String> requestHeaders = {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token!
        };
        var url = Uri.https(
            ApiVariables.baseURL, "${ApiVariables.removePromoURL}/$promoId");

        final response = await _client.delete(
          url,
          headers: requestHeaders,
        );
        return response;
      },
      (error, stackTrace) => RequestError(
        errorMessage: error.toString(),
      ),
    ).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  TaskEither<ApiError, List<Promo>> fetchPromos({required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL, ApiVariables.fetchPromosURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var promos = List<Promo>.from(
                response.where((e) => e != null).map((e) => Promo.fromJson(e)));

            return TaskEither.right(promos);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }
}
