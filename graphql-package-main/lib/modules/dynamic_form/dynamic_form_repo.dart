class DynamicFormRepo {
  DynamicFormRepo();

  Future getDynamicForm(type) async {}

  Future getRegistrationForm() async {}
  Future getAllRegistrationForm() async {}
  Future getFormByUserType(type, userType) async {}
  Future getFormByLink(link) async {}
  Future createCustomFormDetail(input) async {}
}
