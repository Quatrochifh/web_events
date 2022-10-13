enum FormEnum {
  input,
  radio,
  select
}

class FormEnumFunctions {

  bool isRadio(String type) {
    return type == "radio";
  }

  bool isInput(String type) {
    return type == "input";
  }

  bool isSelect(String type) {
    return type == "select";
  }

}