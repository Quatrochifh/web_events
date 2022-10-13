import 'package:appweb3603/core/ServiceConnect.dart';
import 'package:appweb3603/services/Service.dart';

class EventSubscriptionService extends Service {

  /// Retorna os planos para determinado evento
  subscriptionInEvent(int eventId, int planId, Map<String, dynamic> fields) async {
    Map<String, dynamic> params = {'plan_id': planId.toString(), 'event_id' : eventId.toString()};
    fields.addAll(params);
    return await serviceConnect('subscription/join/', 'GET', fields).then((results) {
      return results;
    });
  }

}