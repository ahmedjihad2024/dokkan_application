import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/offers_request.dart';
import '../model/offer_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, OffersPaginationEntity>> getOffers(
    OffersRequest request,
  );
}

