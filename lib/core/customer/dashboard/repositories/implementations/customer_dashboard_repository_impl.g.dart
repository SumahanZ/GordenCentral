// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dashboard_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchDashboardInformationHash() =>
    r'13707155618a3a7397e3e6cf6cb3269368d4afbf';

/// See also [fetchDashboardInformation].
@ProviderFor(fetchDashboardInformation)
final fetchDashboardInformationProvider = AutoDisposeFutureProvider<
    ({
      Either<ApiError, List<Produk>> popular,
      Either<ApiError, List<Produk>> newArrival,
      Either<ApiError, List<Produk>> promo,
      Either<ApiError, Map<String, dynamic>> counts
    })>.internal(
  fetchDashboardInformation,
  name: r'fetchDashboardInformationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchDashboardInformationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchDashboardInformationRef = AutoDisposeFutureProviderRef<
    ({
      Either<ApiError, List<Produk>> popular,
      Either<ApiError, List<Produk>> newArrival,
      Either<ApiError, List<Produk>> promo,
      Either<ApiError, Map<String, dynamic>> counts
    })>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
