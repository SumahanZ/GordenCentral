// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_toko_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchProdukDetailInternalHash() =>
    r'2fa9133382f97ba8a454289736d86fdb4cd8d1a8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchProdukDetailInternal].
@ProviderFor(fetchProdukDetailInternal)
const fetchProdukDetailInternalProvider = FetchProdukDetailInternalFamily();

/// See also [fetchProdukDetailInternal].
class FetchProdukDetailInternalFamily
    extends Family<AsyncValue<Either<ApiError, Produk?>>> {
  /// See also [fetchProdukDetailInternal].
  const FetchProdukDetailInternalFamily();

  /// See also [fetchProdukDetailInternal].
  FetchProdukDetailInternalProvider call(
    int produkId,
  ) {
    return FetchProdukDetailInternalProvider(
      produkId,
    );
  }

  @override
  FetchProdukDetailInternalProvider getProviderOverride(
    covariant FetchProdukDetailInternalProvider provider,
  ) {
    return call(
      provider.produkId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchProdukDetailInternalProvider';
}

/// See also [fetchProdukDetailInternal].
class FetchProdukDetailInternalProvider
    extends AutoDisposeFutureProvider<Either<ApiError, Produk?>> {
  /// See also [fetchProdukDetailInternal].
  FetchProdukDetailInternalProvider(
    int produkId,
  ) : this._internal(
          (ref) => fetchProdukDetailInternal(
            ref as FetchProdukDetailInternalRef,
            produkId,
          ),
          from: fetchProdukDetailInternalProvider,
          name: r'fetchProdukDetailInternalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchProdukDetailInternalHash,
          dependencies: FetchProdukDetailInternalFamily._dependencies,
          allTransitiveDependencies:
              FetchProdukDetailInternalFamily._allTransitiveDependencies,
          produkId: produkId,
        );

  FetchProdukDetailInternalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.produkId,
  }) : super.internal();

  final int produkId;

  @override
  Override overrideWith(
    FutureOr<Either<ApiError, Produk?>> Function(
            FetchProdukDetailInternalRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProdukDetailInternalProvider._internal(
        (ref) => create(ref as FetchProdukDetailInternalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        produkId: produkId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<ApiError, Produk?>> createElement() {
    return _FetchProdukDetailInternalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProdukDetailInternalProvider &&
        other.produkId == produkId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, produkId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchProdukDetailInternalRef
    on AutoDisposeFutureProviderRef<Either<ApiError, Produk?>> {
  /// The parameter `produkId` of this provider.
  int get produkId;
}

class _FetchProdukDetailInternalProviderElement
    extends AutoDisposeFutureProviderElement<Either<ApiError, Produk?>>
    with FetchProdukDetailInternalRef {
  _FetchProdukDetailInternalProviderElement(super.provider);

  @override
  int get produkId => (origin as FetchProdukDetailInternalProvider).produkId;
}

String _$fetchProfileInformationHash() =>
    r'91e7e471a3a683356c87657e9e64e571e9554be7';

/// See also [fetchProfileInformation].
@ProviderFor(fetchProfileInformation)
final fetchProfileInformationProvider = AutoDisposeFutureProvider<
    (
      Either<ApiError, List<BerandaToko>>,
      Either<ApiError, Toko?>,
      Either<ApiError, List<KatalogProduk>>
    )>.internal(
  fetchProfileInformation,
  name: r'fetchProfileInformationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchProfileInformationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchProfileInformationRef = AutoDisposeFutureProviderRef<
    (
      Either<ApiError, List<BerandaToko>>,
      Either<ApiError, Toko?>,
      Either<ApiError, List<KatalogProduk>>
    )>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
