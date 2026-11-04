import '../../../../core/network/base_response.dart';

class DeleteCartItemResponse implements BasicResponse {
  const DeleteCartItemResponse();

  @override
  bool get success => true;

  @override
  String get message => 'Item removed from cart';
}
