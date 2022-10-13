enum UserEnum {
  speaker,
  common,
  admin,
  collaborator
}

class UserEnumFunctions {

  /*
   * Converte os String de comparação do Usuário para o tipo Enum.
  */
  static Enum toEnum(String? userenum){
    switch(userenum) {
      case 'speaker' :
        return UserEnum.speaker;
      case 'collaborator' :
        return UserEnum.collaborator;
      default:
        return UserEnum.common;
    }
  }

  /*
   * Converte os Enums de comparação do Usuário para o tipo String.
  */
  static String enumToString(Enum? userenum){
    switch(userenum) {
      case UserEnum.speaker :
        return 'speaker';
      case UserEnum.collaborator :
        return 'collaborator';
      default:
        return 'common';
    }
  }

}