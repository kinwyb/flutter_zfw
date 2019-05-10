import 'package:zfw/components/api/beans/common.dart';
import 'package:zfw/components/api/beans/shoppingCart.dart';

enum OrderState {
  All, //OrderStatus = 0   //所有状态
  Cancel, //OrderStatus = -1  //交易取消
  WaitPay, //OrderStatus = 10  //待支付
  Grouping, //OrderStatus = 11  //拼团中...[和数据库中状态无关]
  GroupSucc, //OrderStatus = 18  //拼团成功[和数据库中状态无关]
  SystemProcess, //OrderStatus = 19  //系统处理中...[和数据库中状态无关]
  WaitPendingDelivery, //OrderStatus = 20  //待发货
  WaitDelivery, //OrderStatus = 30  //待收货
  WaitAssess, //OrderStatus = 40  //待评价
  Finish, //OrderStatus = 100 //已完成
  Close, //OrderStatus = -2  //已关闭
  Refund, //OrderStatus = -3  //交易取消退款
  GroupFail, //OrderStatus = -4  //拼团失败
}

// 订单状态
int orderStateValue(OrderState state) {
  switch (state) {
    case OrderState.Cancel: //交易取消
      return -1;
    case OrderState.WaitPay: //待支付
      return 10;
    case OrderState.Grouping: //拼团中...[和数据库中状态无关]
      return 11;
    case OrderState.GroupSucc: //拼团成功[和数据库中状态无关]
      return 18;
    case OrderState.SystemProcess: //系统处理中...[和数据库中状态无关]
      return 19;
    case OrderState.WaitPendingDelivery: //待发货
      return 20;
    case OrderState.WaitDelivery: //待收货
      return 30;
    case OrderState.WaitAssess: //待评价
      return 40;
    case OrderState.Finish: //已完成
      return 100;
    case OrderState.Close: //已关闭
      return -2;
    case OrderState.Refund: //交易取消退款
      return -3;
    case OrderState.GroupFail: //拼团失败
      return -4;
    default:
      return 0;
  }
}

// 订单状态
OrderState orderStateParse(int state) {
  switch (state) {
    case -1: //交易取消
      return OrderState.Cancel;
    case 10: //待支付
      return OrderState.WaitPay;
    case 11: //拼团中...[和数据库中状态无关]
      return OrderState.Grouping;
    case 18: //拼团成功[和数据库中状态无关]
      return OrderState.GroupSucc;
    case 19: //系统处理中...[和数据库中状态无关]
      return OrderState.SystemProcess;
    case 20: //待发货
      return OrderState.WaitPendingDelivery;
    case 30: //待收货
      return OrderState.WaitDelivery;
    case 40: //待评价
      return OrderState.WaitAssess;
    case 100: //已完成
      return OrderState.Finish;
    case -2: //已关闭
      return OrderState.Close;
    case -3: //交易取消退款
      return OrderState.Refund;
    case -4: //拼团失败
      return OrderState.GroupFail;
    default:
      return OrderState.All;
  }
}

class OrderListResp {
  String errmsg;
  String err;
  int code;
  PageObj page;
  List<OrderListItem> data;

  OrderListResp({this.errmsg, this.err, this.code, this.page, this.data});

  OrderListResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.page = json['page'] != null ? PageObj.fromJson(json['page']) : null;
    this.data = (json['data'] as List) != null
        ? (json['data'] as List).map((i) => OrderListItem.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    if (this.page != null) {
      data['page'] = this.page.toString();
    }
    data['data'] =
        this.data != null ? this.data.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class OrderListItem {
  String orderNo;
  String statusMsg;
  OrderExpress express;
  String groupOrderNo;
  String isPay;
  String canDel;
  String isEnd;
  String hasRefund;
  double amount;
  int status;
  int totalNum;
  int orderType;
  List<OrderListItemProducts> products;

  OrderListItem(
      {this.orderNo,
      this.statusMsg,
      this.express,
      this.groupOrderNo,
      this.isPay,
      this.canDel,
      this.isEnd,
      this.hasRefund,
      this.amount,
      this.status,
      this.totalNum,
      this.orderType,
      this.products});

  OrderListItem.fromJson(Map<String, dynamic> json) {
    this.orderNo = json['OrderNo'];
    this.statusMsg = json['StatusMsg'];
    this.express =
        json['Express'] != null ? OrderExpress.fromJson(json['Express']) : null;
    this.groupOrderNo = json['GroupOrderNo'];
    this.isPay = json['IsPay'];
    this.canDel = json['CanDel'];
    this.isEnd = json['IsEnd'];
    this.hasRefund = json['HasRefund'];
    this.amount = json['Amount'];
    this.status = json['Status'];
    this.totalNum = json['TotalNum'];
    this.orderType = json['OrderType'];
    this.products = (json['Products'] as List) != null
        ? (json['Products'] as List)
            .map((i) => OrderListItemProducts.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderNo'] = this.orderNo;
    data['StatusMsg'] = this.statusMsg;
    data['Express'] = this.express.toJson();
    data['GroupOrderNo'] = this.groupOrderNo;
    data['IsPay'] = this.isPay;
    data['CanDel'] = this.canDel;
    data['IsEnd'] = this.isEnd;
    data['HasRefund'] = this.hasRefund;
    data['Amount'] = this.amount;
    data['Status'] = this.status;
    data['TotalNum'] = this.totalNum;
    data['OrderType'] = this.orderType;
    data['Products'] = this.products != null
        ? this.products.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class OrderListItemProducts {
  String productNo;
  String productCode;
  String productName;
  String productImg;
  double price;
  List<SKU> skus;

  OrderListItemProducts(
      {this.productNo,
      this.productCode,
      this.productName,
      this.productImg,
      this.price,
      this.skus});

  OrderListItemProducts.fromJson(Map<String, dynamic> json) {
    this.productNo = json['ProductNo'];
    this.productCode = json['ProductCode'];
    this.productName = json['ProductName'];
    this.productImg = json['ProductImg'];
    this.price = json['Price'];
    this.skus = (json['SKUs'] as List) != null
        ? (json['SKUs'] as List).map((i) => SKU.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductNo'] = this.productNo;
    data['ProductCode'] = this.productCode;
    data['ProductName'] = this.productName;
    data['ProductImg'] = this.productImg;
    data['Price'] = this.price;
    data['SKUs'] =
        this.skus != null ? this.skus.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class SKU {
  String skuID;
  String attrValue;
  int num;

  SKU({this.skuID, this.attrValue, this.num});

  SKU.fromJson(Map<String, dynamic> json) {
    this.skuID = json['SkuID'];
    this.attrValue = json['AttrValue'];
    this.num = json['Num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SkuID'] = this.skuID;
    data['AttrValue'] = this.attrValue;
    data['Num'] = this.num;
    return data;
  }
}

class OrderExpress {
  String orderNo;
  String buyer;
  String payMethod;
  String contactPhone;
  String contactName;
  String address;
  String expressCompany;
  String mailNo;
  String payTime;
  String orderTime;
  String expressTime;

  OrderExpress(
      {this.orderNo,
      this.buyer,
      this.payMethod,
      this.contactPhone,
      this.contactName,
      this.address,
      this.expressCompany,
      this.mailNo,
      this.payTime,
      this.orderTime,
      this.expressTime});

  OrderExpress.fromJson(Map<String, dynamic> json) {
    this.orderNo = json['OrderNo'];
    this.buyer = json['Buyer'];
    this.payMethod = json['PayMethod'];
    this.contactPhone = json['ContactPhone'];
    this.contactName = json['ContactName'];
    this.address = json['Address'];
    this.expressCompany = json['ExpressCompany'];
    this.mailNo = json['MailNo'];
    this.payTime = json['PayTime'];
    this.orderTime = json['OrderTime'];
    this.expressTime = json['ExpressTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderNo'] = this.orderNo;
    data['Buyer'] = this.buyer;
    data['PayMethod'] = this.payMethod;
    data['ContactPhone'] = this.contactPhone;
    data['ContactName'] = this.contactName;
    data['Address'] = this.address;
    data['ExpressCompany'] = this.expressCompany;
    data['MailNo'] = this.mailNo;
    data['PayTime'] = this.payTime;
    data['OrderTime'] = this.orderTime;
    data['ExpressTime'] = this.expressTime;
    return data;
  }
}

class OemOrderAddReq {
  String activityCode;
  String addrCode;
  String invoiceCode;
  String invoiceCompanyName;
  String invoiceCompanyVerifyCode;
  String invoicePersonalName;
  String memo;
  List<String> userCouponCode;
  List<OemOrderProduct> products;

  OemOrderAddReq(
      {this.activityCode,
      this.addrCode,
      this.invoiceCode,
      this.invoiceCompanyName,
      this.invoiceCompanyVerifyCode,
      this.invoicePersonalName,
      this.memo,
      this.products,
      this.userCouponCode});

  OemOrderAddReq.fromJson(Map<String, dynamic> json) {
    this.activityCode = json['ActivityCode'];
    this.addrCode = json['AddrCode'];
    this.invoiceCode = json['InvoiceCode'];
    this.invoiceCompanyName = json['InvoiceCompanyName'];
    this.invoiceCompanyVerifyCode = json['InvoiceCompanyVerifyCode'];
    this.invoicePersonalName = json['InvoicePersonalName'];
    this.memo = json['Memo'];
    this.products = (json['Products'] as List) != null
        ? (json['Products'] as List)
            .map((i) => OemOrderProduct.fromJson(i))
            .toList()
        : null;

    List<dynamic> userCouponCodeList = json['UserCouponCode'] ?? [];
    this.userCouponCode = new List();
    this.userCouponCode.addAll(userCouponCodeList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActivityCode'] = this.activityCode;
    data['AddrCode'] = this.addrCode;
    data['InvoiceCode'] = this.invoiceCode;
    data['InvoiceCompanyName'] = this.invoiceCompanyName;
    data['InvoiceCompanyVerifyCode'] = this.invoiceCompanyVerifyCode;
    data['InvoicePersonalName'] = this.invoicePersonalName;
    data['Memo'] = this.memo;
    data['Products'] = this.products != null
        ? this.products.map((i) => i.toJson()).toList()
        : null;
    data['UserCouponCode'] = this.userCouponCode;
    return data;
  }
}

class OemOrderProduct {
  String activityCode;
  String skuID;
  int num;
  String productImg;
  String productName;
  String attr;

  List<ShoppingCartProduct> gift;

  OemOrderProduct(
      {this.activityCode,
      this.productImg,
      this.productName,
      this.skuID,
      this.attr,
      this.num,
      this.gift});

  OemOrderProduct.fromJson(Map<String, dynamic> json) {
    this.activityCode = json['ActivityCode'];
    this.skuID = json['SkuID'];
    this.num = json['Num'];
    this.gift = (json['Gift'] as List) != null
        ? (json['Gift'] as List)
            .map((i) => ShoppingCartProduct.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActivityCode'] = this.activityCode;
    data['SkuID'] = this.skuID;
    data['Num'] = this.num;
    data['Gift'] =
        this.gift != null ? this.gift.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class DirectBuyResp {
  String orderNo;
  int remainingTime;
  Map<String, dynamic> payValue;

  DirectBuyResp({this.orderNo, this.remainingTime, this.payValue});

  DirectBuyResp.fromJson(Map<String, dynamic> json) {
    this.payValue = json['PayValue'];
    this.orderNo = json['OrderNo'];
    this.remainingTime = json['RemainingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PayValue'] = this.payValue;
    data['OrderNo'] = this.orderNo;
    data['RemainingTime'] = this.remainingTime;
    return data;
  }
}
