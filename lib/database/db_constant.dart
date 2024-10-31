import 'package:mmt_mobile/src/const_string.dart';

class DBConstant {
  static String dbName = '${ConstString.appName}.db';

  /*
        Tables
  */
  static const String currencyTable = 'currency_table';
  static const String mscmUserTable = 'mscm_users';
  static const String companyTable = 'company';
  static const String mscmDeviceTable = 'mscm_devices';
  static const String mscmRouteTable = 'mscm_routes';
  static const String mscmRouteLineTable = 'mscm_route_lines';
  static const String mscmDeviceRouteTable = 'mscm_device_routes';
  static const String partnerRouteTable = 'partner_routes';
  static const String productTable = 'products';
  static const String productUomTable = 'product_uom';
  static const String mscmUomTable = 'mscm_uom';
  static const String warehouseTable = 'warehouses';
  static const String dashboardTable = 'dashboards';
  static const String customerDashboardTable = 'customer_dashboards';
  static const String dashboardTableGroupName = 'dashboard_group_name';
  static const String dashboardTableGroupId = 'dashboard_group_id';
  static const String categoryTable = 'categories';
  static const String childCategoryTable = 'child_categories';
  static const String syncActionTable = 'mscm_sync_actions';
  static const String syncActionWithGroupTable = 'sync_actions_with_groups';
  static const String resPartnerTable = 'res_partners';
  static const String mscmStaffRoleTable = 'mscm_staff_roles';
  static const String syncHistoryTable = 'sync_histories';
  static const String priceListTable = 'price_lists';
  static const String priceListItemTable = 'price_list_items';
  static const String customerProductTable = 'customer_products';
  static const String saleOrderTable = 'sale_order';
  static const String saleOrderLineTable = 'sale_order_line';
  static const String numberSeriesTable = 'number_series';
  static const String stockMoveTable = "stock_move";
  static const String pickingTypeTable = 'picking_types';
  static const String stockMoveModelTable = "stock_move_table";
  static const String stockPickingModelTable = "stock_picking_table";
  static const String stockMoveLineTable = "stock_move_line";
  static const String accountMoveTable = "account_move";
  static const String accountMoveLineTable = "account_move_line";
  static const String vehicleInventoryTable = "vehicle_inventory";
  static const String custVisitTable = "cust_visits";
  static const String deliveryTable = "deliveries";
  static const String deliveryItemTable = "delivery_item";
  static const String invoiceTable = "invoice";
  static const String invoiceLineTable = "invoice_line";
  static const String testTable = "test_table";
  static const String returnTable = 'return_table';
  static const String townshipTable = 'township';
  static const String wardTable = 'ward';
  static const String returnLineTable = 'return_line_table';
  static const String partnerGradeTable = 'partner_grade';
  static const String partnerOutletTypeTable = 'partner_outlet_type';
  static const String tagTable = 'tags';
  static const String tagAndPartnerTable = 'tag_and_cust';
  static const String productGroupTable = 'product_group';
  static const String employeeLocationTable = 'employee_location';
  static const String stockProductTable = 'stock_products';
  static const String productImageTable = 'product_images';
  static const String stockOrderTable = 'stock_orders';
  static const String stockOrderLineTable = 'stock_order_lines';
  static const String stockQuantityTable = 'stock_quantity';
  static const String cashCollectionTable = 'cash_collections';
  static const String saleOrderTypeTable = 'sale_order_type';
  static const String syncActionGroupTable = 'sync_action_groups';
  static const String stockQuantTable = 'stock_quant';
  static const String configTable = 'config';
  static const String mustDeleteTable = 'must_delete_table';
  static const String dailyReportTempTable = 'daily_report_temp_table';
  static const String stockPickingBatchTable = 'stock_picking_batch';
  static const String paymentTermTable = 'payment_term';
  static const String coinBillTable = 'coin_bill';
  static const String paymentTransferTable = 'payment_transfer';
  static const String paymentCoinLineTable = 'payment_transfer_line';
  static const String accountPaymentTable = 'account_payment';
  static const String accountJournalTable = 'account_journal';

  // static const String paymentCoinLineTable = 'payment_coin_line';

  /*
        Columns
  */

  static const String customerRank = 'customer_rank';
  static const String supplierRank = 'supplier_rank';
  static const String branchId = 'branch_id';
  static const String branchName = 'branch_name';
  static const String categoryId = "category_id";
  static const String categoryName = 'category_name';
  static const String rounding = 'rounding';
  static const String uomFactor = 'factor';
  static const String cartSessionTable = 'cart_session';
  static const String cartItemTable = 'cart_item_table';
  static const String cartHeaderTable = 'cart_header_table';
  static const String id = 'id';
  static const String mobileUserId = 'mobile_user_id';
  static const String tableName = 'table_name';
  static const String queryValue = 'query_from';
  static const String name = 'name';
  static const String fullName = 'full_name';
  static const String rate = 'rate';
  static const String symbol = 'symbol';
  static const String decimalPlaces = 'decimal_places';
  static const String value = 'value';
  static const String name2 = 'name2';
  static const String isVehicle = 'is_vehicle';
  static const String title = 'title';
  static const String sessionId = 'session';
  static const String price = 'price';
  static const String qty = 'qty';
  static const String image = 'image';
  static const String description = 'description';
  static const String discount = 'discount';
  static const String cart = 'cart';
  static const String partnerId = 'partner_id';
  static const String tagId = 'tag_id';
  static const String customerName = 'customer_name';
  static const String discountAmount = 'discount_amount';
  static const String discountPercentage = 'discount_percentage';
  static const String total = 'total';
  static const String subtotal = 'sub_total';
  static const String versionNo = 'version_no';
  static const String systemDate = 'system_date';
  static const String dateFormat = 'date_format';
  static const String timeFormat = 'time_format';
  static const String header = 'header';
  static const String footer = 'footer';
  static const String saleManId = 'saleman_id';
  static const String saleManName = 'saleman_name';
  static const String routeId = 'route_id';
  static const String routeName = 'route_name';
  static const String deviceId = 'device_id';
  static const String useLooseUom = 'use_loose_uom';
  static const String useLooseBox = 'use_loose_box';
  static const String checkAvailableQty = 'check_available_quantity';
  static const String checkPromo = 'check_promo';
  static const String warehouseId = 'warehouse_id';
  static const String warehouseName = 'warehouse_name';
  static const String vehicleId = 'vehicle_id';
  static const String vehicleName = 'vehicle_name';
  static const String solutionId = 'solution_id';
  static const String logo = 'logo';
  static const String qtyDigit = 'qty_digit';
  static const String priceDigit = 'price_digit';
  static const String invoiceAmount = 'invoice_amount';

  static const String collectAmount = 'collect_amount';

  static const String workPhone = 'work_phone';
  static const String workEmail = 'work_email';
  static const String active = 'active';
  static const String changePrice = 'change_price';
  static const String writeDate = 'write_date';
  static const String type = 'type';
  static const String defaultAccountCurrentBalance =
      'default_account_current_balance';
  static const String dateDone = 'date_done';
  static const String staffRole = 'staff_role';
  static const String token = 'token';
  static const String cashCollectType = 'cash_collect_type';
  static const String initialDateTime = 'initial_datetime';
  static const String expire = 'expire';
  static const String allowLocationUpdate = 'allow_location_update';
  static const String allowRestrictLocation = 'allow_restrict_location';
  static const String saleAreaLimit = 'sale_area_limit';
  static const String allowCashIn = 'allow_cash_in';
  static const String allowCashOut = 'allow_cash_out';
  static const String staffRoleId = 'staff_role_id';
  static const String staffRoleName = 'staff_role_name';
  static const String currentLocationId = 'current_location_id';
  static const String currentLocationName = 'current_location_name';
  static const String destinationJournalId = 'destination_journal_id';
  static const String journalId = 'journal_id';
  static const String journalName = 'journal_name';
  static const String warehouseStockLocationId = 'warehouse_stock_location_id';
  static const String warehouseStockLocationName =
      'warehouse_stock_location_name';
  static const String currentWarehouse = 'current_warehouse';
  static const String currentWarehouseName = 'current_warehouse_name';
  static const String amountCompanyCurrencySigned =
      'amount_company_currency_signed';
  static const String paymentMethodLineId = 'payment_method_line_id';
  static const String amountSigned = 'amount_signed';
  static const String paymentType = 'payment_type';
  static const String partnerType = 'partner_type';
  static const String paymentMethodLineName = 'payment_method_line_name';

  static const String isAutoSync = 'is_auto_sync';
  static const String priority = 'priority';
  static const String iSManualSync = 'is_manual_sync';
  static const String userId = 'user_id';
  static const String isUpload = 'is_upload';
  static const String fromDelivery = 'from_delivery';
  static const String whSale = 'from_wh_sale';
  static const String actionId = 'action_id';
  static const String actionGroupID = 'action_group_id';

  static const String actionGroupName = 'action_group_name';
  static const String dateCreated = 'date_created';
  static const String routeDay = 'route_day';
  static const String routeWeek1 = 'rout_week_1';
  static const String routeWeek2 = 'rout_week_2';
  static const String routeWeek3 = 'rout_week_3';
  static const String routeWeek4 = 'rout_week_4';
  static const String note = 'note';
  static const String remark = 'remark';

  static const String street = 'street';
  static const String street2 = 'street2';
  static const String city = 'city';
  static const String stateId = 'state_id';
  static const String stateName = 'state_name';
  static const String priceListId = 'pricelist_id';
  static const String priceListName = 'pricelist_name';
  static const String zip = 'zip';
  static const String phone = 'phone';
  static const String mobile = 'mobile';
  static const String website = 'website';
  static const String email = 'email';
  static const String image512 = 'image_512';
  static const String serviceProductType = 'service_product_type';
  static const String partnerLatitude = 'partner_latitude';
  static const String partnerLongitude = 'partner_longitude';

  static const String actionName = 'action_name';

  static const String uomId = 'uom_id';
  static const String uomName = 'uom_name';
  static const String uomType = 'uom_type';
  static const String ratio = 'ratio';
  static const String uomCategoryId = 'uom_category_id';
  static const String uomCategoryName = 'uom_category_name';
  static const String productId = 'product_id';
  static const String orderId = 'order_id';

  static const String categId = 'categ_id';
  static const String listPrice = 'list_price';
  static const String defaultCode = 'default_code';
  static const String barcode = 'barcode';
  static const String image128 = 'image_128';
  static const String categName = 'categ_name';
  static const String looseQty = 'loose_qyt';
  static const String looseUomId = 'loose_uom_id';
  static const String looseUomName = 'loose_uom_name';
  static const String boxUomId = 'box_uom_id';
  static const String boxUomName = 'box_uom_name';

  static const String dashboardId = 'dashboard_id';
  static const String icon = 'icon';
  static const String isFolder = 'is_folder';
  static const String actionUrl = 'action_url';
  static const String parentId = 'parent_id';
  static const String parentUrl = 'parent_url';
  static const String dashboardName = 'dashboard_name';

  static const String completeName = 'complete_name';
  static const String parentPath = 'parent_path';
  static const String parentName = 'parent_name';
  static const String childId = 'child_id';

  static const String isVisited = 'is_visited';
  static const String conditionType = 'condition_type';

  static const String currencyId = 'currency_id';
  static const String companyId = 'company_id';
  static const String defaultCompanyId = 'default_company_id';
  static const String defaultCompanyName = 'default_company_name';
  static const String discountPolicy = 'discount_policy';
  static const String displayName = 'display_name';
  static const String currencyName = 'currency_name';
  //
  static const String documentType = 'document_type';
  static const String originDocumentNo = 'origin_document_no';
  static const String balanceDate = 'balance_date';
  static const String jBalance = 'j_balance';
  static const String leftBalance = 'left_balance';

  static const String code = 'code';
  static const String sequenceCode = 'sequence_code';
  static const String sequence = 'sequence';
  static const String companyName = 'company_name';

  static const String routePlanId = 'route_plan_id';
  static const String routePlanName = 'route_plan_name';
  static const String number = 'number';

  static const String priceGroupId = 'price_group_id';
  static const String productTemplId = 'product_tmpl_id';
  static const String appliedOn = 'applied_on';
  static const String minQuantity = 'min_quantity';
  static const String priceDiscount = 'price_discount';
  static const String fixedPrice = 'fixed_price';
  static const String dateStart = 'date_start';
  static const String dateEnd = 'date_end';
  static const String productTmplName = 'product_tmpl_name';

  static const String productTmplId = 'product_tmpl_id';
  static const String orderQuantity = 'order_quantity';
  static const String productUomName = 'product_uom_name';
  static const String productUomId = 'product_uom_id';
  static const String customerId = 'customer_id';

  static const String salePerson = 'sale_person';
  static const String dateOrder = 'date_order';
  static const String orderLine = 'order_line';

  static const String productTemplateId = 'product_template_id';
  static const String saleType = 'sale_type';
  static const String partnerName = 'partner_name';
  static const String amountTotal = 'amount_total';
  static const String priceUnit = 'price_unit';
  static const String saleOrderQty = 'sale_order_qty';
  static const String productUom = 'product_uom';
  static const String productUomQty = 'product_uom_qty';
  static const String quantityDone = 'quantity_done';
  static const String isBasePrice = 'is_base_price';

  static const String quantity = 'quantity';

  static const String saleOrderCartHdrId = 'sale_order_cart_hdr_id';
  static const String suggestUomName = 'suggest_uom_name';
  static const String boxQty = 'box_qty';
  static const String lQty = 'loose_qty';

  static const String prefix = 'prefix';
  static const String useYear = 'use_year';
  static const String useMonth = 'use_month';
  static const String useDay = 'use_day';
  static const String resetIn = 'reset_in';
  static const String numberLength = 'number_length';
  static const String numberLast = 'number_last';
  static const String yearLast = 'year_last';
  static const String monthLast = 'month_last';
  static const String dayLast = 'day_last';

  static const String moveNo = 'move_no';
  static const String moveDate = 'date';
  static const String remarks = 'remarks';
  static const String reference = 'reference';
  static const String soNo = 'so_no';
  static const String batchNo = 'batch_no';
  static const String transferNo = 'doc_no';
  static const String productName = 'product_name';
  static const String lotName = 'lot_name';
  static const String locationFrom = 'location_from';
  static const String locationTo = 'location_to';
  static const String orderNo = 'order_no';
  static const String requiredClockinPhoto = 'required_clockin_photo';

// "doc_no": "",
// "doc_date": "2021-10-28 13:55:32",
// "doc_type": "clock-in",
// "customer_id": 9,
// "employee_id": 1,
// "vehicle_id": 1,
// "device_id": 1,
// "photo": null,
// "latitude": 21.9829623,
// "longitude": 96.1118101,
// "remarks": ""
  static const String docDate = 'doc_date';
  static const String docType = 'doc_type';
  static const String employeeId = 'employee_id';
  static const String employeeName = 'employee_name';
  static const String requestLocationName = 'request_location_name';
  static const String requestLocationId = 'request_location_id';
  static const String orderName = 'order_name';
  static const String photo = 'photo';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String docNo = 'doc_no';

  static const String townshipId = 'township_id';
  static const String townshipName = 'township_name';
  static const String wardId = 'ward_id';
  static const String wardName = 'ward_name';

  static const String invoiceDate = 'invoice_date';
  static const String invoiceOrign = 'invoice_orign';
  static const String ref = 'ref';
  static const String narration = 'narration';
  static const String amountUntaxed = 'amount_untaxed';
  static const String moveType = 'move_type';
  static const String date = 'date';

  static const String invoiceDateDue = 'invoice_date_due';
  static const String accountMoveId = 'account_move_id';

  static const String origin = 'origin';
  static const String saleId = 'sale_id';
  static const String batchId = 'batch_id';
  static const String pkPcs = 'pk_pcs';
  static const String ward = 'ward';
  static const String township = 'township';
  static const String phoneNo = 'phone_no';
  static const String isBackOrder = 'is_back_order';

  static const String batchName = 'batch_name';
  static const String deliveryBatch = 'delivery_batch';
  static const String orderAmount = 'order_amount';
  static const String clientOrderRef = 'client_order_ref';
  static const String state = 'state';
  static const String validityDate = 'validity_date';
  static const String isExpired = 'is_expired';
  static const String requireSignature = 'require_signature';
  static const String requirePayment = 'require_payment';
  static const String invoiceStatus = 'invoice_status';
  static const String amountTax = 'amount_tax';
  static const String signature = 'signature';
  static const String signedBy = 'signed_by';
  static const String signedOn = 'signed_on';
  static const String pickingNo = 'picking_no';
  static const String pickingState = 'picking_state';

  static const String qtyDelivered = 'qty_delivered';
  static const String qtyInvoiced = 'qty_invoiced';
  static const String priceSubtotal = 'price_subtotal';
  static const String status = 'status';

  static const String dateDeadLine = 'date_deadline';
  static const String locationId = 'location_id';
  static const String lotId = 'lot_id';
  static const String moveId = 'move_id';
  static const String moveName = 'move_name';
  static const String pickingId = 'picking_id';
  static const String pickingName = 'picking_name';
  static const String productQty = 'product_qty';
  static const String totalUom = 'total_uom';
  static const String productsAvailability = 'products_availability';
  static const String qtyDone = 'qty_done';
  static const String doneQty = 'done_qty';
  static const String products_availability = 'products_availability';
  static const String scanType = 'scan_type';
  static const String scheduledDate = 'scheduled_date';
  static const String commitmentDate = 'commitment_date';
  static const String saleLineId = 'sale_line_id';
  static const String moveLineState = 'move_line_state';
  static const String availablePQty = 'available_p_qty';
  static const String availableQty = 'available_qty';
  static const String moveLineId = 'move_line_id';
  static const String deliveryStatus = 'delivery_status';
  static const String locationDestId = 'location_dest_id';
  static const String locationDestName = 'location_dest_name';
  static const String rtnId = 'rtn_id';
  static const String detialType = 'detailed_type';
  static const String partnerGradeId = 'partner_grade_id';
  static const String outletTypeId = 'outlet_type_id';
  static const String partnerState = 'partner_state';
  static const String fromDirectSale = 'from_direct_sale';
  static const String productGroupId = 'product_group_id';
  static const String saleUomId = 'sale_uom_id';
  static const String saleUomName = 'sale_uom_name';
  static const String saleOK = 'sale_ok';
  static const String purchaseOK = 'purchase_ok';

  static const String saleOrderTypeId = 'sale_order_type_id';
  static const String saleOrderTypeName = 'sale_order_type_name';

  static const String locationName = 'location_name';
  static const String productCategId = 'product_categ_id';
  static const String inventoryQuantityAutoApply =
      'inventory_quantity_auto_apply';
  static const String productCategName = 'product_categ_name';
  static const String onHandQty = 'onhand_quantity';

  /// 'onhand_quantity_uom'
  static const String onHandQtyUom = 'onhand_quantity_uom';
  static const String availableQuantity = 'available_quantity';
  static const String availableQtyUom = 'available_quantity_uom';
  static const String reservedQty = 'reserved_quantity';
  static const String reservedQtyUom = 'reserved_quantity_uom';

  static const String deliveryMan = 'delivery_man';
  static const String deliveryManName = 'delivery_man_name';

  static const String totalLoading = 'total_loading';
  static const String voucherCount = 'voucher_count';
  static const String amount = 'amount';

  // daily sale report
  static const String row1 = 'row_1';
  static const String row2 = 'row_2';
  static const String col1 = 'col_1';
  static const String col2 = 'col_2';
  static const String lRatio = 'l_ratio';
  static const String bRatio = 'b_ratio';
  static const String lbQty = 'lb_qty';
  static const String totalAmount = 'total_amount';

  // "is_internal_transfer": true,
  // "payment_id": 17688,
  // "employee_id": 2,
  // "payment_coin_line": [],
  // "transfer_type": "bank",
  // "write_date": "2023-06-14 14:44:28.136971",
  // "amount": 80000.0,
  // "company_id": 1,
  // "memo": "swedrftgyhjn",
  // "payment_name": "D001/2023/06/0009",
  // "employee_name": "SR1- THEIN ZAW",
  // "company_name": "COCA COLA",
  // "total_amount": 80000.0
  // payment transfer
  static const String isInternalTransfer = 'is_internal_transfer';
  static const String paymentId = 'payment_id';
  static const String paymentCoinLine = 'payment_coin_line';
  static const String transferType = 'transfer_type';
  static const String memo = 'memo';
  static const String paymentName = 'payment_name';
  static const String transferId = 'transfer_id';
  static const String coinId = 'coin_id';
  static const String coinName = 'coin_name';
  static const String isPartial = 'is_partial';
  static const String lastSaleOrder = 'last_sale_order';
  static const String lastSaleOrderName = 'last_sale_order_name';
  static const String lastSaleAmount = 'last_sale_amount';
  static const String totalDue = 'total_due';
  static const String totalInvoiced = 'total_invoiced';
  static const String lastSaleOrderDate = 'last_sale_order_date';
  static const String lastSaleCurrencyId = 'last_sale_currency_id';
  static const String saleOrderCount = 'sale_order_count';
  static const String invoiceCount = 'invoice_count';
  static const String lastSaleCurrencyName = 'last_sale_currency_name';
  static const String totalOrdered = 'total_ordered';
}
