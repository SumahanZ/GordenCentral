// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_toko_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchProdukDetailHash() => r'8b1004276c35d94e5b20c97a99b137d1064c4852';

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

/// See also [fetchProdukDetail].
@ProviderFor(fetchProdukDetail)
const fetchProdukDetailProvider = FetchProdukDetailFamily();

/// See also [fetchProdukDetail].
class FetchProdukDetailFamily
    extends Family<AsyncValue<Either<ApiError, Produk?>>> {
  /// See also [fetchProdukDetail].
  const FetchProdukDetailFamily();

  /// See also [fetchProdukDetail].
  FetchProdukDetailProvider call(
    int tokoId,
    int produkId,
  ) {
    return FetchProdukDetailProvider(
      tokoId,
      produkId,
    );
  }

  @override
  FetchProdukDetailProvider getProviderOverride(
    covariant FetchProdukDetailProvider provider,
  ) {
    return call(
      provider.tokoId,
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
  String? get name => r'fetchProdukDetailProvider';
}

/// See also [fetchProdukDetail].
class FetchProdukDetailProvider
    extends AutoDisposeFutureProvider<Either<ApiError, Produk?>> {
  /// See also [fetchProdukDetail].
  FetchProdukDetailProvider(
    int tokoId,
    int produkId,
  ) : this._internal(
          (ref) => fetchProdukDetail(
            ref as FetchProdukDetailRef,
            tokoId,
            produkId,
          ),
          from: fetchProdukDetailProvider,
          name: r'fetchProdukDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchProdukDetailHash,
          dependencies: FetchProdukDetailFamily._dependencies,
          allTransitiveDependencies:
              FetchProdukDetailFamily._allTransitiveDependencies,
          tokoId: tokoId,
          produkId: produkId,
        );

  FetchProdukDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokoId,
    required this.produkId,
  }) : super.internal();

  final int tokoId;
  final int produkId;

  @override
  Override overrideWith(
    FutureOr<Either<ApiError, Produk?>> Function(FetchProdukDetailRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProdukDetailProvider._internal(
        (ref) => create(ref as FetchProdukDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokoId: tokoId,
        produkId: produkId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<ApiError, Produk?>> createElement() {
    return _FetchProdukDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProdukDetailProvider &&
        other.tokoId == tokoId &&
        other.produkId == produkId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokoId.hashCode);
    hash = _SystemHash.combine(hash, produkId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchProdukDetailRef
    on AutoDisposeFutureProviderRef<Either<ApiError, Produk?>> {
  /// The parameter `tokoId` of this provider.
  int get tokoId;

  /// The parameter `produkId` of this provider.
  int get produkId;
}

class _FetchProdukDetailProviderElement
    extends AutoDisposeFutureProviderElement<Either<ApiError, Produk?>>
    with FetchProdukDetailRef {
  _FetchProdukDetailProviderElement(super.provider);

  @override
  int get tokoId => (origin as FetchProdukDetailProvider).tokoId;
  @override
  int get produkId => (origin as FetchProdukDetailProvider).produkId;
}

String _$fetchTokoAllInformationHash() =>
    r'b8ef3fa31f09da12f50918cb94ff5d0e72806977';

/// See also [fetchTokoAllInformation].
@ProviderFor(fetchTokoAllInformation)
const fetchTokoAllInformationProvider = FetchTokoAllInformationFamily();

/// See also [fetchTokoAllInformation].
class FetchTokoAllInformationFamily extends Family<
    AsyncValue<
        (Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)>> {
  /// See also [fetchTokoAllInformation].
  const FetchTokoAllInformationFamily();

  /// See also [fetchTokoAllInformation].
  FetchTokoAllInformationProvider call(
    int tokoId,
  ) {
    return FetchTokoAllInformationProvider(
      tokoId,
    );
  }

  @override
  FetchTokoAllInformationProvider getProviderOverride(
    covariant FetchTokoAllInformationProvider provider,
  ) {
    return call(
      provider.tokoId,
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
  String? get name => r'fetchTokoAllInformationProvider';
}

/// See also [fetchTokoAllInformation].
class FetchTokoAllInformationProvider extends AutoDisposeFutureProvider<
    (Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)> {
  /// See also [fetchTokoAllInformation].
  FetchTokoAllInformationProvider(
    int tokoId,
  ) : this._internal(
          (ref) => fetchTokoAllInformation(
            ref as FetchTokoAllInformationRef,
            tokoId,
          ),
          from: fetchTokoAllInformationProvider,
          name: r'fetchTokoAllInformationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchTokoAllInformationHash,
          dependencies: FetchTokoAllInformationFamily._dependencies,
          allTransitiveDependencies:
              FetchTokoAllInformationFamily._allTransitiveDependencies,
          tokoId: tokoId,
        );

  FetchTokoAllInformationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokoId,
  }) : super.internal();

  final int tokoId;

  @override
  Override overrideWith(
    FutureOr<(Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)>
            Function(FetchTokoAllInformationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchTokoAllInformationProvider._internal(
        (ref) => create(ref as FetchTokoAllInformationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokoId: tokoId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<
          (Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)>
      createElement() {
    return _FetchTokoAllInformationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchTokoAllInformationProvider && other.tokoId == tokoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchTokoAllInformationRef on AutoDisposeFutureProviderRef<
    (Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)> {
  /// The parameter `tokoId` of this provider.
  int get tokoId;
}

class _FetchTokoAllInformationProviderElement
    extends AutoDisposeFutureProviderElement<
        (Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)>
    with FetchTokoAllInformationRef {
  _FetchTokoAllInformationProviderElement(super.provider);

  @override
  int get tokoId => (origin as FetchTokoAllInformationProvider).tokoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
