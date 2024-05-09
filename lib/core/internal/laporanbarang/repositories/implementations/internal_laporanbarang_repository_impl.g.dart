// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal_laporanbarang_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchLaporanBarangInformationHash() =>
    r'7b4ad24b3650ea3d546592bfc96cc422ddb5d6d3';

/// See also [fetchLaporanBarangInformation].
@ProviderFor(fetchLaporanBarangInformation)
final fetchLaporanBarangInformationProvider = AutoDisposeFutureProvider<
    ({
      Either<ApiError, Map<String, dynamic>> generalInformation,
      Either<ApiError, List<LaporanBarangKeluar>> laporanBarangKeluar,
      Either<ApiError, List<LaporanBarangMasuk>> laporanBarangMasuk
    })>.internal(
  fetchLaporanBarangInformation,
  name: r'fetchLaporanBarangInformationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchLaporanBarangInformationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchLaporanBarangInformationRef = AutoDisposeFutureProviderRef<
    ({
      Either<ApiError, Map<String, dynamic>> generalInformation,
      Either<ApiError, List<LaporanBarangKeluar>> laporanBarangKeluar,
      Either<ApiError, List<LaporanBarangMasuk>> laporanBarangMasuk
    })>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
