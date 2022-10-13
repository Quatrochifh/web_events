class Service {

  final List<String> _errors = [];

  setError( String error ){
    this._errors.add(error);
  }

}