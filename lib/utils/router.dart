import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/views/customer_personalization_page.dart';
import 'package:tugas_akhir_project/core/auth/views/karyawan_personalization_page.dart';
import 'package:tugas_akhir_project/core/auth/views/login_page.dart';
import 'package:tugas_akhir_project/core/auth/views/pemilik_personalization_page.dart';
import 'package:tugas_akhir_project/core/auth/views/prelimenary_auth_page.dart';
import 'package:tugas_akhir_project/core/auth/views/registration_customer_confirmation_page.dart';
import 'package:tugas_akhir_project/core/auth/views/registration_karyawan_confirmation_page.dart';
import 'package:tugas_akhir_project/core/auth/views/registration_page_customer.dart';
import 'package:tugas_akhir_project/core/auth/views/registration_page_internal.dart';
import 'package:tugas_akhir_project/core/auth/views/registration_pemilik_confirmation_page.dart';
import 'package:tugas_akhir_project/core/customer/account/views/customer_change_delivery_information_page.dart';
import 'package:tugas_akhir_project/core/customer/account/views/customer_edit_profile_page.dart';
import 'package:tugas_akhir_project/core/customer/browse-toko/views/customer_browse_toko_page.dart';
import 'package:tugas_akhir_project/core/customer/cart/views/customer_cart_checkout_page.dart';
import 'package:tugas_akhir_project/core/customer/cart/views/customer_cart_page.dart';
import 'package:tugas_akhir_project/core/customer/dashboard/views/customer_dashboard_page.dart';
import 'package:tugas_akhir_project/core/customer/main/customer_main_page.dart';
import 'package:tugas_akhir_project/core/customer/notifications/views/customer_notification_page.dart';
import 'package:tugas_akhir_project/core/customer/orders/views/customer_complete_orderreview_page.dart';
import 'package:tugas_akhir_project/core/customer/orders/views/customer_order_detail_page.dart';
import 'package:tugas_akhir_project/core/customer/orders/views/customer_order_page.dart';
import 'package:tugas_akhir_project/core/customer/search/views/customer_search_page.dart';
import 'package:tugas_akhir_project/core/customer/search/views/customer_search_results_page.dart';
import 'package:tugas_akhir_project/core/customer/settings/views/customer_settings_page.dart';
import 'package:tugas_akhir_project/core/customer/toko/views/customer_toko_page.dart';
import 'package:tugas_akhir_project/core/customer/wishlist/views/customer_wishlist_page.dart';
import 'package:tugas_akhir_project/core/internal/account/views/internal_edit_profile_page.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/views/internal_internaltoko_add_page.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/views/internal_internaltoko_join_page.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/views/internal_add_laporanbarangkeluar_page.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/views/internal_add_laporanbarangmasuk_page.dart';
import 'package:tugas_akhir_project/core/internal/orders/views/internal_configure_order_log_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_add_produk_category_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_add_produkstok_information_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_add_stok_information_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_add_stok_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_add_stok_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/analisiskeuangan/views/internal_analisiskeuangan_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_add_stok_selection_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_configure_formula_page.dart';
import 'package:tugas_akhir_project/core/internal/dashboard/views/internal_dashboard_page.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/views/internal_edit_laporanbarangkeluar_page.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/views/internal_edit_laporanbarangmasuk_page.dart';
import 'package:tugas_akhir_project/core/internal/layanan/views/internal_edit_layanan_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_edit_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_edit_produkstok_information_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_edit_stok_details_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_edit_stok_information_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_input_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/views/internal_laporanbarang_page.dart';
import 'package:tugas_akhir_project/core/internal/layanan/views/internal_layanan_page.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/views/internal_internaltoko_page.dart';
import 'package:tugas_akhir_project/core/internal/main/internal_main_page.dart';
import 'package:tugas_akhir_project/core/internal/notifications/views/internal_notification_page.dart';
import 'package:tugas_akhir_project/core/internal/orders/views/internal_order_detail_page.dart';
import 'package:tugas_akhir_project/core/internal/orders/views/internal_order_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_produkstok_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_add_katalog_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_add_promo_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_beranda_toko_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_edit_katalog_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_edit_promo_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_katalog_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_pick_items_katalog_produk_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_preview_profile_toko_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_profile_toko_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_promo_item_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_promo_page.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/views/internal_toko_information_page.dart';
import 'package:tugas_akhir_project/core/internal/settings/views/internal_settings_page.dart';
import 'package:tugas_akhir_project/core/shared_pages.dart/customer_produk_detail_page.dart';
import 'package:tugas_akhir_project/core/shared_pages.dart/internal_layanan_detail_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_produk_color_page.dart';
import 'package:tugas_akhir_project/core/shared_pages.dart/internal_produk_detail_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_produk_select_categories_page.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/views/internal_produk_size_page.dart';

import '../core/internal/profile-toko/views/internal_edit_produk_toko_page.dart';

final loggedOutRoute =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  "/": (_) => const MaterialPage(child: PrelimenaryAuthPage()),
  "/registration-internal": (_) => const TransitionPage(
      child: RegisterPageInternal(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/registration-customer": (_) => const TransitionPage(
      child: RegisterPageCustomer(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/confirmation-karyawan": (_) => const TransitionPage(
      child: RegistrationConfirmationKaryawanPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/confirmation-pemilik": (_) => const TransitionPage(
      child: RegistrationConfirmationPemilikPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/confirmation-customer": (_) => const TransitionPage(
      child: RegistrationConfirmationCustomerPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/personalization-karyawan": (_) => const TransitionPage(
      child: KaryawanPersonalizationPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/personalization-pemilik": (_) => const TransitionPage(
      child: PemilikPersonalizationPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/personalization-customer": (_) => const TransitionPage(
      child: CustomerPersonalizationPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/login": (_) => const TransitionPage(
      child: LoginPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
});

final loggedInCustomerRoute =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  "/": (_) => const TabPage(child: CustomerMainPage(), paths: [
        '/customer-dashboard',
        '/customer-browse-toko',
        '/customer-search',
        '/customer-notification',
        '/customer-account',
      ]),
  '/customer-dashboard': (route) => const TransitionPage(
      child: CustomerDashboardPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-dashboard/produk/:tokoId/:produkId': (route) => TransitionPage(
      child: CustomerProdukPage(int.parse(route.pathParameters["produkId"]!),
          int.parse(route.pathParameters["tokoId"]!)),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account': (route) => const TransitionPage(
      child: CustomerAccountPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-search': (route) => const TransitionPage(
      child: CustomerSearchPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-search/produk/:tokoId/:produkId': (route) => TransitionPage(
      child: CustomerProdukPage(int.parse(route.pathParameters["produkId"]!),
          int.parse(route.pathParameters["tokoId"]!)),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-search/search-results': (route) => const TransitionPage(
      child: CustomerSearchResultsPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-search/search-results/produk/:tokoId/:produkId': (route) =>
      TransitionPage(
          child: CustomerProdukPage(
              int.parse(route.pathParameters["produkId"]!),
              int.parse(route.pathParameters["tokoId"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/customer-notification': (route) =>
      const TransitionPage(child: CustomerNotificationPage()),
  '/customer-browse-toko': (route) => const TransitionPage(
      child: CustomerBrowseTokoPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-browse-toko/toko/:id': (route) => TransitionPage(
      child: CustomerTokoPage(tokoId: int.parse(route.pathParameters["id"]!)),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-browse-toko/toko/:id/:produkId': (route) => TransitionPage(
      child: CustomerProdukPage(int.parse(route.pathParameters["produkId"]!),
          int.parse(route.pathParameters["id"]!)),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/orders': (route) => const TransitionPage(
      child: CustomerOrderPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/orders/complete-order-review/:orderId': (route) =>
      TransitionPage(
          child: CustomerCompleteOrderRatingPage(
              int.parse(route.pathParameters["orderId"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  "/customer-account/orders/detail": (route) => const TransitionPage(
      child: CustomerOrderDetailPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/change-delivery': (route) => const TransitionPage(
      child: CustomerChangeDeliveryInformationPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/cart': (route) => const TransitionPage(
      child: CustomerCartPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/cart/checkout': (route) => const TransitionPage(
      child: CustomerCartCheckoutPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/wishlist': (route) => const TransitionPage(
      child: CustomerWishlistPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/customer-account/wishlist/produk/:tokoId/:produkId': (route) =>
      TransitionPage(
          child: CustomerProdukPage(
              int.parse(route.pathParameters["produkId"]!),
              int.parse(route.pathParameters["tokoId"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/customer-account/edit-profile': (route) => const TransitionPage(
      child: CustomerEditProfilePage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
});

final loggedInInternalRoute =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  "/": (_) => const TabPage(
        child: InternalMainPage(),
        paths: [
          '/internal-dashboard',
          '/internal-order',
          '/internal-notification',
          '/internal-account',
        ],
      ),
  '/internal-dashboard': (route) => const TransitionPage(
      child: InternalDashboardPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/layanan': (route) => const TransitionPage(
      child: InternalLayananPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/layanan/edit': (route) => const TransitionPage(
      child: InternalEditLayananPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/layanan/detail/edit': (route) => const TransitionPage(
      child: InternalEditLayananPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/layanan/detail': (route) => const TransitionPage(
      child: InternalLayananDetailPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok': (route) => const TransitionPage(
      child: InternalProdukStokPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/add-category-produk': (route) =>
      const TransitionPage(
          child: InternalAddProdukCategoryPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/configure-formula': (route) =>
      const TransitionPage(
          child: InternalConfigureFormulaPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk': (route) =>
      const TransitionPage(
          child: InternalInputProdukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk/add-stok': (route) =>
      const TransitionPage(
          child: InternalAddStokProdukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk/add-stok/add-details': (route) =>
      const TransitionPage(
          child: InternalAddProdukStokInformationPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk/add-stok/edit-details/:id':
      (route) => TransitionPage(
          child: InternalEditProdukStokInformationPage(
              produkStokId: int.parse(route.pathParameters["id"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/edit-produk/:id': (route) => TransitionPage(
      child: InternalEditProdukPage(
          produkId: int.parse(route.pathParameters["id"]!)),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/edit-produk/:id/size': (route) =>
      const TransitionPage(
          child: InternalProdukSizePage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/edit-produk/:id/color': (route) =>
      const TransitionPage(
          child: InternalProdukColorPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/edit-produk/:id/select-category': (route) =>
      const TransitionPage(
          child: InternalProdukSelectCategoryPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk/color': (route) =>
      const TransitionPage(
          child: InternalProdukColorPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk/size': (route) =>
      const TransitionPage(
          child: InternalProdukSizePage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/input-produk/select-category': (route) =>
      const TransitionPage(
          child: InternalProdukSelectCategoryPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/add-stok': (route) => const TransitionPage(
      child: InternalAddStokProdukSelection(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/add-stok/selection': (route) =>
      const TransitionPage(
          child: InternalAddStokPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/add-stok/selection/add-details': (route) =>
      const TransitionPage(
          child: InternalAddStokInformationPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/add-stok/selection/edit-details/:id':
      (route) => TransitionPage(
          child: InternalEditStokInformationPage(
            produkStokId: int.parse(route.pathParameters["id"]!),
          ),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/produkstok/edit-stok': (route) => const TransitionPage(
      child: InternalEditStokDetailsPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/analisa-keuangan': (route) => const TransitionPage(
      child: InternalAnalisaKeuanganPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/laporan-barang': (route) => const TransitionPage(
      child: InternalLaporanBarangPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-dashboard/laporan-barang/add-masuk': (route) =>
      const TransitionPage(
          child: InternalAddLaporanBarangMasukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/laporan-barang/edit-masuk': (route) =>
      const TransitionPage(
          child: InternalEditLaporanBarangMasukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/laporan-barang/add-keluar': (route) =>
      const TransitionPage(
          child: InternalAddLaporanBarangKeluarPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-dashboard/laporan-barang/edit-keluar': (route) =>
      const TransitionPage(
          child: InternalEditLaporanBarangKeluarPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account': (route) => const TransitionPage(
      child: InternalAccountPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-notification': (route) => const TransitionPage(
      child: InternalNotificationPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-order': (route) => const TransitionPage(
      child: InternalOrderPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/internal-order/detail": (route) => const TransitionPage(
      child: InternalOrderDetailPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  "/internal-order/detail/configure-order-log": (route) => const TransitionPage(
      child: InternalConfigureOrderLogPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko': (route) => const TransitionPage(
      child: InternalProfileTokoPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/toko-information': (route) =>
      const TransitionPage(
          child: InternalTokoInformationPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/katalog-produk': (route) =>
      const TransitionPage(
          child: InternalKatalogProdukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/katalog-produk/add': (route) =>
      const TransitionPage(
          child: InternalAddKatalogProdukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/katalog-produk/add/select-items': (route) =>
      const TransitionPage(
          child: PickItemsKatalogProdukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/katalog-produk/edit/:id': (route) =>
      TransitionPage(
          child: InternalEditKatalogProdukPage(
              int.parse(route.pathParameters["id"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/katalog-produk/edit/:id/select-items':
      (route) => const TransitionPage(
          child: PickItemsKatalogProdukPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/beranda-toko': (route) =>
      const TransitionPage(
          child: InternalBerandaTokoPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/preview-profile-toko': (route) =>
      const TransitionPage(
          child: InternalPreviewProfileTokoPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/preview-profile-toko/:produkId': (route) =>
      TransitionPage(
          child:
              InternalProdukPage(int.parse(route.pathParameters["produkId"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/preview-profile-toko/:produkId/edit':
      (route) => TransitionPage(
          child: InternalEditProdukTokoPage(
              produkId: int.parse(route.pathParameters["produkId"]!)),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/preview-profile-toko/:produkId/edit/color':
      (route) => const TransitionPage(
          child: InternalProdukColorPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/preview-profile-toko/:produkId/edit/size':
      (route) => const TransitionPage(
          child: InternalProdukSizePage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/preview-profile-toko/:produkId/edit/select-category':
      (route) => const TransitionPage(
          child: InternalProdukSelectCategoryPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/promosi': (route) => const TransitionPage(
      child: InternalPromoPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/promosi/add': (route) => const TransitionPage(
      child: InternalAddPromoPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/promosi/add/item': (route) =>
      const TransitionPage(
          child: InternalPromoItemPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/promosi/edit': (route) =>
      const TransitionPage(
          child: InternalEditPromoPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/profile-toko/promosi/edit/item': (route) =>
      const TransitionPage(
          child: InternalPromoItemPage(),
          pushTransition: PageTransition.cupertino,
          popTransition: PageTransition.cupertino),
  '/internal-account/internal-toko': (route) => const TransitionPage(
      child: InternalInternalTokoPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/internal-toko/add': (route) => const TransitionPage(
      child: InternalInternalTokoAddPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/edit-profile': (route) => const TransitionPage(
      child: InternalEditProfilePage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino),
  '/internal-account/join-toko': (route) => const TransitionPage(
      child: InternalInternalTokoJoinPage(),
      pushTransition: PageTransition.cupertino,
      popTransition: PageTransition.cupertino)
});
