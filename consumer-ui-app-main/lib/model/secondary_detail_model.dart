SecondaryRegistrationDetailsVM secondaryRegistrationFormVMFromJson(
        dynamic str) =>
    (SecondaryRegistrationDetailsVM.fromJson(str));

class SecondaryRegistrationDetailsVM {
  late final SecondaryFormDetailsVM? formDetails;
  late final bool? error;
  late final String? message;

  SecondaryRegistrationDetailsVM(
      {required this.formDetails, required this.error, required this.message});

  SecondaryRegistrationDetailsVM.fromJson(dynamic json) {
    if (json.formDetails != null) {
      formDetails = new SecondaryFormDetailsVM.fromJson(json.formDetails);
    } else {
      formDetails = null;
    }
    error = json.error;
    message = json.message;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.formDetails != null) {
      data['formDetails'] = this.formDetails!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class SecondaryFormDetailsVM {
  late final List<SecondaryFormFieldVM>? formField;
  late final SecondaryFormVM? form;
  late final SecondaryUserDetailsVM? userDetails;

  SecondaryFormDetailsVM({
    required this.formField,
    required this.userDetails,
    required this.form,
  });

  SecondaryFormDetailsVM.fromJson(dynamic json) {
    if (json.formField != null) {
      formField = <SecondaryFormFieldVM>[];
      json.formField.forEach((v) {
        formField!.add(new SecondaryFormFieldVM.fromJson(v));
      });
    }
    form = json.form != null ? new SecondaryFormVM.fromJson(json.form) : null;
    userDetails = json.userDetails != null
        ? new SecondaryUserDetailsVM.fromJson(json.userDetails)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.form != null) {
      data['form'] = this.form!.toJson();
    }
    if (this.formField != null) {
      data['formField'] = this.formField!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondaryFormFieldVM {
  late final String? sId;
  late final String? name;
  late final String? label;
  late final int? sortOrder;
  late final String? type;
  late final bool? required;
  late final bool? readOnly;
  late final String? placeHolder;
  late final bool? hidden;
  late final bool? isCaseSensitive;
  late final String? caseType;
  late final SecondaryFormFieldSettingsVM? settings;
  late final String? sTypename;

  SecondaryFormFieldVM(
      {required this.sId,
      required this.name,
      required this.label,
      required this.sortOrder,
      required this.type,
      required this.hidden,
      required this.isCaseSensitive,
      required this.caseType,
      required this.settings,
      required this.sTypename,
      required this.readOnly,
      required this.required,
      required this.placeHolder});

  SecondaryFormFieldVM.fromJson(dynamic json) {
    sId = json.sId;
    name = json.name;
    label = json.label;
    sortOrder = json.sortOrder;
    hidden = json.hidden;
    isCaseSensitive = json.isCaseSensitive;
    type = json.type;
    caseType = json.caseType;
    readOnly = json.readOnly;
    placeHolder = json.placeHolder;
    required = json.required;
    settings = json.settings != null
        ? new SecondaryFormFieldSettingsVM.fromJson(json.settings)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['label'] = this.label;
    data['sortOrder'] = this.sortOrder;
    data['hidden'] = this.hidden;
    data['isCaseSensitive'] = this.isCaseSensitive;
    data['readOnly'] = this.readOnly;
    data['caseType'] = this.caseType;
    data['placeHolder'] = this.placeHolder;
    data['required'] = this.required;
    data['__typename'] = this.sTypename;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class SecondaryFormFieldSettingsVM {
  late final List<SecondaryFormFieldValidationVM>? validation;
  late final List<SecondaryFormFieldOptionsVM>? options;
  late final List<SecondaryFormFieldComparisonVM>? compare;

  SecondaryFormFieldSettingsVM({
    required this.validation,
    required this.options,
    required this.compare,
  });

  SecondaryFormFieldSettingsVM.fromJson(dynamic json) {
    if (json.validation != null) {
      validation = <SecondaryFormFieldValidationVM>[];
      json.validation.forEach((v) {
        validation!.add(new SecondaryFormFieldValidationVM.fromJson(v));
      });
    }
    if (json.options != null) {
      options = <SecondaryFormFieldOptionsVM>[];
      json.options.forEach((v) {
        options!.add(new SecondaryFormFieldOptionsVM.fromJson(v));
      });
    }
    if (json.compare != null) {
      compare = <SecondaryFormFieldComparisonVM>[];
      json.compare.forEach((v) {
        compare!.add(new SecondaryFormFieldComparisonVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.validation != null) {
      data['validation'] = this.validation!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.compare != null) {
      data['compare'] = this.compare!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondaryFormFieldComparisonVM {
  late final int? type;
  late final int? operator;
  late final String? value;
  late final int? action;
  late final SecondaryComparisonOtherFieldVM? otherField;

  SecondaryFormFieldComparisonVM(
      {required this.value,
      required this.type,
      required this.action,
      required this.operator,
      required this.otherField});

  SecondaryFormFieldComparisonVM.fromJson(dynamic json) {
    value = json.value;
    type = json.type;
    action = json.action;
    operator = json.operator;
    otherField = json.otherField != null
        ? new SecondaryComparisonOtherFieldVM.fromJson(json.otherField)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['action'] = this.action;
    data['operator'] = this.operator;
    if (this.otherField != null) {
      data['otherField'] = this.otherField!.toJson();
    }
    return data;
  }
}

class SecondaryComparisonOtherFieldVM {
  late final String? sId;
  late final String? name;
  late final String? label;

  SecondaryComparisonOtherFieldVM(
      {required this.sId, required this.name, required this.label});

  SecondaryComparisonOtherFieldVM.fromJson(dynamic json) {
    sId = json.sId;
    name = json.name;
    label = json.label;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['label'] = this.label;
    return data;
  }
}

class SecondaryFormFieldOptionsVM {
  late final String? name;
  late final String? value;
  SecondaryFormFieldOptionsVM({required this.value, required this.name});

  SecondaryFormFieldOptionsVM.fromJson(dynamic json) {
    value = json.value;
    name = json.name;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rule'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class SecondaryFormFieldValidationVM {
  late final String? rule;
  late final String? value;
  late final String? message;
  SecondaryFormFieldValidationVM({
    required this.rule,
    required this.value,
    required this.message,
  });

  SecondaryFormFieldValidationVM.fromJson(dynamic json) {
    rule = json.rule;
    value = json.value;
    message = json.message;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rule'] = this.rule;
    data['value'] = this.value;
    data['message'] = this.message;
    return data;
  }
}

class SecondaryFormVM {
  late final String? sId;
  late final String? name;
  late final String? buttonLabel;
  late final String? description;
  late final bool? isAddress;
  late final String? sTypename;

  SecondaryFormVM(
      {required this.sId,
      required this.buttonLabel,
      required this.description,
      required this.name,
      required this.isAddress,
      required this.sTypename});

  SecondaryFormVM.fromJson(dynamic json) {
    sId = json.sId;
    buttonLabel = json.buttonLabel;
    description = json.description;
    name = json.name;
    isAddress = json.isAddress;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['buttonLabel'] = this.buttonLabel;
    data['description'] = this.description;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    data['isAddress'] = this.isAddress;
    return data;
  }
}

class SecondaryUserDetailsVM {
  late final String? firstName;
  late final String? lastName;
  late final String? name;
  late final String? emailId;
  late final String? mobileNumber;
  late final String? companyName;
  late final String? gstNumber;
  late final String? address;
  late final String? panNo;

  SecondaryUserDetailsVM({
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.emailId,
    required this.mobileNumber,
    required this.companyName,
    required this.gstNumber,
    required this.address,
    required this.panNo,
  });

  SecondaryUserDetailsVM.fromJson(dynamic json) {
    firstName = json.firstName;
    lastName = json.lastName;
    name = json.name;
    emailId = json.emailId;
    mobileNumber = json.mobileNumber;
    companyName = json.companyName;
    gstNumber = json.gstNumber;
    address = json.address;
    panNo = json.panNo;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['companyName'] = this.companyName;
    data['gstNumber'] = this.gstNumber;
    data['address'] = this.address;
    data['panNo'] = this.panNo;
    return data;
  }
}
