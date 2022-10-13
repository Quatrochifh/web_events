import 'package:appweb3603/db/ContactDB.dart';
import 'package:appweb3603/entities/Contact.dart' as entity_contact;
import 'package:appweb3603/validate.dart';
import 'package:contacts_service/contacts_service.dart';

class OBContact {

  OBContact({dynamic context});

  Future<bool> verifyContactIdContact(int userId) async {
    ContactDB contactDB = new ContactDB();
    return await contactDB.getByUserId(userId).then((r){
      return r != null ? true : false;
    });
  }

  Future<bool> addContact(entity_contact.Contact contact) async {
    if (!Validate.isPhone(contact.telephone ?? "")) {
      return false;
    }

    ContactDB contactDB = new ContactDB();

    bool hasContact = await contactDB.getByUserId(contact.userId!).then((r){
      return r != null ? true : false;
    });

    // Se houver um registro na base para esse usuário, sinal que já deve constar na lista de contatos do usuário
    if (hasContact == true) {
      return false;
    }

    Contact newContact = new Contact();

    List<String> userName = contact.name!.split(" ");

    newContact.givenName = userName[0];
    newContact.middleName = userName[1];
    newContact.displayName = contact.name;

    newContact.emails = [Item(label: "E-mail Pessoal", value: contact.email)];
    newContact.phones = [Item(label: "Telefone Pessoal", value: "+55 ${contact.telephone}")];

    bool success = false;
    try {
      // Adiciona na lista de contatos do aparelho do usuário
      await ContactsService.addContact(newContact);
      success = true;
    } catch (e) {
      success = false;
    }

    if (success) {
      // Adiciona localmente que tal contato foi registrado. (Table contact)
      ContactDB contactDB = new ContactDB();
      contactDB.insertContact(contact);
    }

    return success;
  }
}