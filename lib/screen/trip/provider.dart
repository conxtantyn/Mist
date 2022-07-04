import 'package:injectable/injectable.dart';

import '../../router/router.dart';

import 'detail/detail_route.dart';
import 'request/request_route.dart';
import 'requests/requests_route.dart';

@injectable
class TripProvider {
  final DetailRoute _detailRoute;
  final RequestRoute _requestRoute;
  final RequestsRoute _requestsRoute;

  TripProvider(
    @Named('DetailRoute') this._detailRoute,
    @Named('RequestRoute') this._requestRoute,
    @Named('RequestsRoute') this._requestsRoute,
  );

  List<KRouter> get routes => <KRouter>[
        _detailRoute,
        _requestRoute,
        _requestsRoute,
      ];
}
