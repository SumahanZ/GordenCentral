class ApiVariables {
  static const baseURL = "10.0.2.2:3005";
  static const signUpCustomerURL = "/signup-customer";
  static const signUpInternalURL = "/signup-internal";
  static const loginURL = "/login";
  static const logoutURL = "/logout";
  static const completeCustomerPersonalizationURL =
      "/complete-customer-personalization";
  static const completeKaryawanPersonalizationURL =
      "/complete-karyawan-personalization";
  static const completePemilikPersonalizationURL =
      "/complete-pemilik-personalization";
  static const getUserInfoURL = "/get-userdata";
  static const getEnrolledTokoURL = "/get-toko";
  static const getProvincesURL = "/get-provinces";
  static const getCitiesURL = "/get-cities";
  static const createTokoInformationURL =
      "/profiletoko/create-toko-information";
  static const fetchInternalInformationURL = "/settings-internal";
  static const fetchCustomerInformationURL = "/settings-customer";
  static const fetchPreviewTokoInformationURL =
      "/profiletoko/fetch-toko-information";
  static const fetchBerandaInformationURL =
      "/profiletoko/fetch-beranda-toko-information";
  static const configureBerandaTokoURL = "/profiletoko/configure-beranda-toko";
  static const editInternalInformationURL = "/profile-internal/edit";
  static const editCustomerInformationURL = "/profile-customer/edit";
  static const inputStokProductURL = "/produk/input-stok-produk";
  static const addStokProductURL = "/produk/add-stok-produk";
  static const addProdukCategoryURL = "/produk/add-produk-category";
  static const fetchCategoriesURL = "/produk/fetch-categories";
  static const fetchCategoryItemsProdukListURL =
      "/profiletoko/katalog-produk-produk-items";
  static const addKatalogProdukURL = "/profiletoko/add-katalog-produk";
  static const editKatalogProdukURL = "/profiletoko/edit-katalog-produk";
  static const fetchKatalogProdukTokoURL = "/profiletoko/fetch-katalog-produk";
  static const fetchInternalProdukDetailURL =
      "/profiletoko/fetch-produk-detail";
  static const internalEditProdukURL = "/profiletoko/edit-produk";
  static const fetchKatalogProdukTokoPreviewURL =
      "/profiletoko/fetch-katalog-produk-preview";
  static const fetchSingleKatalogProdukURL =
      "/profiletoko/fetch-katalog-produk-single";
  static const fetchTokosURL = "/browsetoko/fetch-tokos";
  static const fetchCustomerTokoURL = "/toko/fetch-toko";
  static const fetchCustomerKatalogProdukTokoURL = "/toko/katalog-produk";
  static const fetchCustomerProdukDetail = "/toko/produk-detail";
  static const removeProdukWishlistCustomerURL =
      "/wishlist/remove-produk-wishlist";
  static const fetchWishlistCustomerURL = "/wishlist/fetch-wishlist";
  static const fetchCartCustomerURL = "/cart/fetch-cart";
  static const increaseCartItemQuantityURL = "/cart/increase-quantity-cartitem";
  static const decreaseCartItemQuantityURL = "/cart/decrease-quantity-cartitem";
  static const createOrderURL = "/cart/create-order";
  static const addProdukWishlistCustomerURL = "/wishlist/add-produk-wishlist";
  static const addProdukCartCustomerURL = "/cart/add-produk-cart";
  static const addProdukCartCustomerFromModalURL =
      "/cart/add-produk-cart-modal";
  static const configureCustomerDeliveryInformationURL =
      "/configure-delivery-information/customer";
  static const fetchDeliveryInformationCustomerURL =
      "/fetch-delivery-information/customer";
  static const fetchProduksAddStokURL = "/produk/fetch-produk-add-stok";
  static const fetchAvailablePromoItemsURL =
      "/profiletoko/fetch-available-promo-items";
  static const removePromoURL = "/profiletoko/remove-promo";
  static const addPromoURL = "/profiletoko/add-promo";
  static const editPromoURL = "/profiletoko/edit-promo";
  static const fetchPromosURL = "/profiletoko/fetch-promos";
  static const fetchInternalsURL = "/internal-toko/fetch";
  static const acceptJoinRequestURL = "/internal-toko/accept-join-request";
  static const declineJoinRequestURL = "/internal-toko/decline-join-request";
  static const addInternalThroughUserCodeURL =
      "/internal-toko/add-internal-through-user-code";
  static const joinInternalThroughInviteCodeURL =
      "/internal-toko/join-internal-through-invite-code";
  static const completeOrderCustomerURL = "/customer-orders/complete-order";
  static const cancelOrderCustomerURL = "/customer-orders/cancel-order";
  static const fetchOrdersCustomerURL = "/customer-orders/fetch-orders";
  static const fetchAllCustomerOrdersURL =
      "/internal-orders/fetch-customer-orders";
  static const fetchOrdersProdukURL = "/customer-orders/fetch-orders-produk";
  static const cancelOrderURL = "/internal-orders/cancel-order";
  static const configureOrderURL = "/internal-orders/configure-order";
  static const fetchOrderStasusesURL = "/internal-orders/fetch-order-stasus";
  static const fetchMostPopularProductsURL =
      "/customer-dashboard/fetch-most-popular-products";
  static const fetchNewArrivalProductsURL =
      "/customer-dashboard/fetch-new-arrival-products";
  static const fetchPromoProductsURL =
      "/customer-dashboard/fetch-promo-products";
  static const fetchOrderCompletedOngoingCountURL =
      "/customer-dashboard/fetch-order-completed-ongoing-count";
  static const fetchAllProdukSearchURL = "/customer-search/fetch-produks";
  static const fetchSearchOptionURL = "/customer-search/fetch-search-option";
  static const fetchFilteredProductsURL =
      "/customer-search/fetch-filtered-products";
  static const fetchTokoNotificationsURL =
      "/internal-notification/fetch-toko-notifications";
  static const fetchCustomerNotificationsURL =
      "/customer-notification/fetch-customer-notifications";
  static const fetchCompleteOngoingOrdersInternalURL =
      "/internal-dashboard/fetch-order-completed-ongoing-count";
  static const fetchLaporanBarangMasukInternalURL =
      "/internal-laporan-barang/fetch-laporan-barang-masuk";
  static const fetchLaporanBarangKeluarInternalURL =
      "/internal-laporan-barang/fetch-laporan-barang-keluar";
  static const fetchLaporanGeneralInformationURL =
      "/internal-laporan-barang/fetch-laporan-general-information";
  static const fetchAnalisisKeuanganGeneralInformationURL =
      "/internal-analisis-keuangan/fetch-analisis-keuangan-information";
  static const fetchAnalisisKeuanganRecentTransactionsURL =
      "/internal-analisis-keuangan/fetch-recent-transactions";
  static const fetchAnalisisKeuanganSalesReportURL =
      "/internal-analisis-keuangan/fetch-sales-report";
  static const calculateSafetyStockReorderPointURL =
      "/produk/calculate-safety-stock-reorder-point";
  static const checkSafetyStockReorderPointURL =
      "/produk/check-safety-stock-reorder-point";
  static const fetchOutOfStockAndCriticalProductCountURL =
      "/produk/fetch-produk-outofstok-critical-count";
  static const internalRemoveProdukURL = "/produk/remove-produk";
  static const updateUserDeviceTokenURL = "/user/update-device-token";
  static const emptyUserDeviceTokenURL = "/user/empty-device-token";
}
