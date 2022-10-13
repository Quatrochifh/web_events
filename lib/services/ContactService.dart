import 'package:appweb3603/entities/Contact.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/objects/object_contact.dart';
import 'package:appweb3603/services/Service.dart';
import 'package:appweb3603/validate.dart';

class ContactService extends Service{

  /*
   * Adicionar um usuário a lista de usuários
   */
  Future<dynamic> addContact(User user) async {

    if (!Validate.isPhone(user.telephone)) {
      return false;
    }

    Contact contact = new Contact(
      name: user.name,
      userId: user.id,
      telephone: user.telephone,
      email: user.email,
      dateRegister: getCurrentDateTime()
    );

    OBContact obContact = new OBContact();
    return obContact.addContact(contact);
  }

  /*
   * Contact Exists
   */
  Future<dynamic> verifyUserIdContact(int userId) async {
    OBContact obContact = new OBContact();
    return obContact.verifyContactIdContact(userId);
  }

}