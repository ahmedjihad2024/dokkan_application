import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/offers_request.dart';
import '../model/offer_entity.dart';
import '../repository/home_repository.dart';

class GetOffersUseCase {
  final HomeRepository _repository;

  GetOffersUseCase(this._repository);

  Future<Either<Failure, OffersPaginationEntity>> call(OffersRequest request) {
    return _repository.getOffers(request);
  }
}