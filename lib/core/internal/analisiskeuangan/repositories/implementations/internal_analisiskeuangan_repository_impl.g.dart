// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal_analisiskeuangan_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAnalisisKeuanganInformationHash() =>
    r'57541ea9d3e58e733c0939a52e767059b5770eb8';

/// See also [fetchAnalisisKeuanganInformation].
@ProviderFor(fetchAnalisisKeuanganInformation)
final fetchAnalisisKeuanganInformationProvider = AutoDisposeFutureProvider<
    ({
      fp.Either<ApiError, Map<String, dynamic>> generalInformation,
      fp.Either<ApiError, List<Order>> recentTransactions,
      fp.Either<ApiError, List<Order>> salesReport
    })>.internal(
  fetchAnalisisKeuanganInformation,
  name: r'fetchAnalisisKeuanganInformationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAnalisisKeuanganInformationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAnalisisKeuanganInformationRef = AutoDisposeFutureProviderRef<
    ({
      fp.Either<ApiError, Map<String, dynamic>> generalInformation,
      fp.Either<ApiError, List<Order>> recentTransactions,
      fp.Either<ApiError, List<Order>> salesReport
    })>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
