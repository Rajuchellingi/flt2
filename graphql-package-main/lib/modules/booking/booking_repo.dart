// ignore_for_file: unused_local_variable

import '../../GraphQLConfiguration.dart';

class BookingRepo {
  var graphQLConfiguration;
  var bookings;
  BookingRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getSingleBookingById(bookingId) async {}

  Future getBookingListByUser(pageNo, limit) async {}

  Future getSingleBookingDetail(bookingId) async {}

  Future intiatePaymentByBooking(bookingId) async {}

  Future createCODOrderByBooking(bookingId) async {}

  Future checkPaymentAndCreateOrder(tempTransactionId) async {}

  Future checkOrderIsConfirmed(tempTransactionId) async {}
  Future cancelBooking(orderId, reason) async {}
  Future checkTransactionIsCompleted(tempTransactionId) async {}
}
