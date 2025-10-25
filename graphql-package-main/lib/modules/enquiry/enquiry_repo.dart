class EnquiryRepo {
  Future createOrder(order) async {}

  Future getEnquiryListByUser(int pageNo, int limit) async {}

  Future getSingleOrderDetail(orderId) async {}
  Future downloadInvoice(orderId) async {}
}
