import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/model/offer_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';
import '../mapper/offers_mapper.dart';
import '../request/offers_request.dart';
import '../response/offers_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, OffersPaginationEntity>> getOffers(
    OffersRequest request,
  ) {
    return fastHandler<OffersResponse, OffersPaginationEntity>(
      request: () => _remoteDataSource.getOffers(request),
      mapper: (response) => response.toDomain(),
    );
  }
}

