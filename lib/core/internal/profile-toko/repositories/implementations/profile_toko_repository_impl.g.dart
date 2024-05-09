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
    r'57e15eb2e152c9bc6810f3bd094a433c74d8cdb5';

/// See also [fetchProfileInformation].
@ProviderFor(fetchProfileInformation)
const fetchProfileInformationProvider = FetchProfileInformationFamily();

/// See also [fetchProfileInformation].
class FetchProfileInformationFamily extends Family<
    AsyncValue<
        (
          Either<ApiError, List<BerandaToko>>,
          Either<ApiError, Toko?>,
          Either<ApiError, List<KatalogProduk>>
        )>> {
  /// See also [fetchProfileInformation].
  const FetchProfileInformationFamily();

  /// See also [fetchProfileInformation].
  FetchProfileInformationProvider call(
    int tokoId,
  ) {
    return FetchProfileInformationProvider(
      tokoId,
    );
  }

  @override
  FetchProfileInformationProvider getProviderOverride(
    covariant FetchProfileInformationProvider provider,
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
  String? get name => r'fetchProfileInformationProvider';
}

/// See also [fetchProfileInformation].
class FetchProfileInformationProvider extends AutoDisposeFutureProvider<
    (
      Either<ApiError, List<BerandaToko>>,
      Either<ApiError, Toko?>,
      Either<ApiError, List<KatalogProduk>>
    )> {
  /// See also [fetchProfileInformation].
  FetchProfileInformationProvider(
    int tokoId,
  ) : this._internal(
          (ref) => fetchProfileInformation(
            ref as FetchProfileInformationRef,
            tokoId,
          ),
          from: fetchProfileInformationProvider,
          name: r'fetchProfileInformationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchProfileInformationHash,
          dependencies: FetchProfileInformationFamily._dependencies,
          allTransitiveDependencies:
              FetchProfileInformationFamily._allTransitiveDependencies,
          tokoId: tokoId,
        );

  FetchProfileInformationProvider._internal(
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
    FutureOr<
                (
                  Either<ApiError, List<BerandaToko>>,
                  Either<ApiError, Toko?>,
                  Either<ApiError, List<KatalogProduk>>
                )>
            Function(FetchProfileInformationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProfileInformationProvider._internal(
        (ref) => create(ref as FetchProfileInformationRef),
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
      (
        Either<ApiError, List<BerandaToko>>,
        Either<ApiError, Toko?>,
        Either<ApiError, List<KatalogProduk>>
      )> createElement() {
    return _FetchProfileInformationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProfileInformationProvider && other.tokoId == tokoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchProfileInformationRef on AutoDisposeFutureProviderRef<
    (
      Either<ApiError, List<BerandaToko>>,
      Either<ApiError, Toko?>,
      Either<ApiError, List<KatalogProduk>>
    )> {
  /// The parameter `tokoId` of this provider.
  int get tokoId;
}

class _FetchProfileInformationProviderElement
    extends AutoDisposeFutureProviderElement<
        (
          Either<ApiError, List<BerandaToko>>,
          Either<ApiError, Toko?>,
          Either<ApiError, List<KatalogProduk>>
        )> with FetchProfileInformationRef {
  _FetchProfileInformationProviderElement(super.provider);

  @override
  int get tokoId => (origin as FetchProfileInformationProvider).tokoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
