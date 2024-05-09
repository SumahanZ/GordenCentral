function applyAssociations(sequelize) {
	//define relations here
	// const { instrument, orchestra } = sequelize.models;
	// orchestra.hasMany(instrument);
	// instrument.belongsTo(orchestra);
	const { customer, address, internal, toko, user, promotional, produk, produkglobalimage, produkcolor, produksize, produkcategory, stok, laporanbarangmasuk, laporanbarangkeluar, productcombination, katalogproduk, wishlist, cart, cartitem, province, city, promo, order, orderitem, orderstatus, produkrating, customernotification, customernotificationtype, tokonotification, tokonotificationtype, formulasettings, device } = sequelize.models;
	user.hasOne(customer, { foreignKey: "userId", as: 'customer' });
	customer.belongsTo(user, { foreignKey: "userId", as: 'user' });

	user.hasOne(device, { foreignKey: "userId" });
	device.belongsTo(user, { foreignKey: "userId" })

	user.hasOne(internal, { foreignKey: "userId", });
	internal.belongsTo(user, { foreignKey: "userId" });

	address.hasOne(toko, { foreignKey: "addressId", as: 'toko' });
	toko.belongsTo(address, { foreignKey: "addressId" });

	address.hasOne(customer, { foreignKey: "addressId", as: 'customer' });
	customer.belongsTo(address, { foreignKey: "addressId" });

	toko.hasMany(internal, { foreignKey: "tokoId", as: 'internal' });
	internal.belongsTo(toko, { foreignKey: "tokoId", as: 'toko' });

	toko.hasMany(promotional, { foreignKey: "tokoId" });
	promotional.belongsTo(toko, { foreignKey: "tokoId", as: 'toko' });

	produk.hasMany(produkglobalimage, { foreignKey: "produkId", as: "image" });
	produkglobalimage.belongsTo(produk, { foreignKey: "produkId" });

	produk.hasMany(produkcolor, { foreignKey: "produkId", as: "color" });
	produkcolor.belongsTo(produk, { foreignKey: "produkId" });

	produk.hasMany(produksize, { foreignKey: "produkId", as: "size" });
	produksize.belongsTo(produk, { foreignKey: "produkId" });

	produk.hasOne(stok, { foreignKey: "produkId" });
	stok.belongsTo(produk, { foreignKey: "produkId" });

	produk.hasOne(promo, { foreignKey: "produkId" });
	promo.belongsTo(produk, { foreignKey: "produkId" });

	produk.belongsToMany(produkcategory, { as: "categories", through: "Produk_ProdukCategory", foreignKey: "produkId" });
	produkcategory.belongsToMany(produk, { as: "products", through: "Produk_ProdukCategory", foreignKey: "categoryId" });

	produk.belongsToMany(katalogproduk, { as: "catalogs", through: "Produk_ProdukKatalog", foreignKey: "produkId" });
	katalogproduk.belongsToMany(produk, { as: "products", through: "Produk_ProdukKatalog", foreignKey: "catalogId" });

	toko.hasMany(katalogproduk, { as: "catalogs", foreignKey: "tokoId" });
	katalogproduk.belongsTo(toko, { as: "toko", foreignKey: "tokoId" });

	productcombination.belongsTo(produk, { foreignKey: 'produkId', as: "product" });
	productcombination.belongsTo(produksize, { foreignKey: "sizeId", as: "size" });
	productcombination.belongsTo(produkcolor, { foreignKey: "colorId", as: "color" });

	produk.hasMany(productcombination, { foreignKey: "produkId", as: "combination" });
	produksize.hasMany(productcombination, { foreignKey: "sizeId" });
	produkcolor.hasMany(productcombination, { foreignKey: "colorId" });

	toko.hasMany(produk, { foreignKey: "tokoId", as: "products" });
	produk.belongsTo(toko, { foreignKey: "tokoId" });

	laporanbarangmasuk.belongsToMany(produk, { through: "Produk_Stockin", foreignKey: 'stockinId' });
	produk.belongsToMany(laporanbarangmasuk, { through: "Produk_Stockin", foreignKey: 'produkId', as: "stockin" });

	laporanbarangkeluar.belongsToMany(produk, { through: "Produk_Stockout", foreignKey: 'stockoutId' });
	produk.belongsToMany(laporanbarangkeluar, { through: "Produk_Stockout", foreignKey: 'produkId', as: "stockout" });

	order.hasMany(laporanbarangkeluar, { foreignKey: 'orderId', as: "stockins" });
	laporanbarangkeluar.belongsTo(order, { foreignKey: 'orderId', as: "order" });

	wishlist.belongsToMany(produk, { through: "Wishlist_Items", foreignKey: 'wishlistId', as: "products" });
	produk.belongsToMany(wishlist, { through: "Wishlist_Items", foreignKey: 'produkId', as: "wishlists" });

	customer.hasOne(wishlist, { foreignKey: 'customerId' });
	wishlist.belongsTo(customer, { foreignKey: 'customerId' });

	customer.hasOne(cart, { foreignKey: 'customerId' });
	cart.belongsTo(customer, { foreignKey: 'customerId' });

	cart.hasMany(cartitem, { foreignKey: 'cartId', as: "items" });
	cartitem.belongsTo(cart, { foreignKey: 'cartId' })

	productcombination.hasMany(cartitem, { foreignKey: 'variationId' });
	cartitem.belongsTo(productcombination, { foreignKey: 'variationId', as: "combination" })

	province.hasMany(city, { foreignKey: 'provinceId', as: "cities" });
	city.belongsTo(province, { foreignKey: 'provinceId', as: "province" })

	city.hasOne(address, { foreignKey: "cityId", as: 'address' });
	address.belongsTo(city, { foreignKey: "cityId", as: 'city' });

	order.hasMany(orderitem, { foreignKey: "orderId", as: "items" });
	orderitem.belongsTo(order, { foreignKey: "orderId" });

	orderstatus.hasOne(order, { foreignKey: "statusId" })
	order.belongsTo(orderstatus, { foreignKey: "statusId", as: "status" })

	customer.hasMany(order, { foreignKey: "customerId" })
	order.belongsTo(customer, { foreignKey: "customerId" })

	toko.hasMany(order, { foreignKey: "tokoId" })
	order.belongsTo(toko, { foreignKey: "tokoId" })

	productcombination.hasMany(orderitem, { foreignKey: 'variationId' });
	orderitem.belongsTo(productcombination, { foreignKey: 'variationId', as: "combination" })

	produk.hasMany(produkrating, { foreignKey: 'produkId', as: "rating" });
	produkrating.belongsTo(produk, { foreignKey: 'produkId' })

	customer.hasMany(produkrating, { foreignKey: 'customerId', as: "ratings" });
	produkrating.belongsTo(customer, { foreignKey: 'customerId' })

	order.hasMany(produkrating, { foreignKey: "orderId", as: "ratings" });
	produkrating.belongsTo(order, { foreignKey: "orderId" });

	customernotificationtype.hasOne(customernotification, { foreignKey: "typeId" });
	customernotification.belongsTo(customernotificationtype, { foreignKey: "typeId" });

	customer.hasMany(customernotification, { foreignKey: "customerId" });
	customernotification.belongsTo(customer, { foreignKey: "customerId" });

	tokonotificationtype.hasOne(tokonotification, { foreignKey: "typeId" });
	tokonotification.belongsTo(tokonotificationtype, { foreignKey: "typeId" });

	toko.hasMany(tokonotification, { foreignKey: "tokoId" });
	tokonotification.belongsTo(toko, { foreignKey: "tokoId" });

	toko.hasOne(formulasettings, { foreignKey: "tokoId", as: "formula" });
	formulasettings.belongsTo(toko, { foreignKey: "tokoId" });
}

module.exports = { applyAssociations };