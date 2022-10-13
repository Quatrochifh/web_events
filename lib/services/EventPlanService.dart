import 'package:appweb3603/core/ServiceConnect.dart';
import 'package:appweb3603/entities/Plan.dart';
import 'package:appweb3603/entities/form/Field.dart';
import 'package:appweb3603/services/Service.dart';

class EventPlanService extends Service {

  /// Retorna os planos para determinado evento
  fetchPlansByEventId(int eventId) {

  }

  /// Retorna os planos para determinado evento
  fetchPlansByEventCode(String code) async {
    return await serviceConnect('subscription/plans/', 'GET', {'event_code': code}).then((results) {
      if(results == null || results['status'] != 1){ 
        return null;
      }

      List<Plan> plans = [];

      results['message'].forEach((plan) {
        plans.add(
          Plan(
            id: plan['id'],
            eventId: plan['event_id'],
            categoryId: plan['category_id'],
            title: plan['title'],
            description: plan['description'],
            installmentLimit: plan['installment_limit'],
            maxInstallmentNoInterest: plan['max_installment_no_interest'],
            price: plan['price'].toDouble(),
            ticketsAvailable: plan['tickets_available']
          )
        );
      });

      return plans;
    });
  }

  /// Retorna o plano para determinado id
  fetchPlanById(int planId) async {
    return await serviceConnect('subscription/plan/', 'GET', {'plan_id': planId.toString()}).then((results) {
      if(results == null || results['status'] != 1){ 
        return null;
      }

      dynamic plan = results['message'];

      return Plan(
        id: plan['id'],
        eventId: plan['event_id'],
        categoryId: plan['category_id'],
        title: plan['title'],
        description: plan['description'],
        installmentLimit: plan['installment_limit'],
        maxInstallmentNoInterest: plan['max_installment_no_interest'],
        price: plan['price'].toDouble(),
        ticketsAvailable: plan['tickets_available']
      );
    });
  }

  /// Retorna o formulário para determinado plano
  fetchPlanForm(int planId, int eventId) async {
    return await serviceConnect('form/planForm/', 'GET', {'plan_id': planId.toString(), 'event_id': eventId.toString()}).then((results) {

      if(results == null || results['status'] != 1){ 
        return null;
      }

      dynamic fields = results['response']['fields'];

      List<Field> fieldsList = [];

      fields.forEach((k, field) {
        fieldsList.add(
          Field(
            title: field['title'] ?? "",
            type: field['type'],
            fieldType: field['field_type'],
            value: field['value'].toString(),
            options: field['options'] ?? {},
            keyName: field['key_name'],
            required: field['required'] == "true",
            objectId: int.parse(field['object_id']),
          )
        );
      });

      return fieldsList;
    });
  }

}