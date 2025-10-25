DynamicFormVM dynamicFormVMFromJson(dynamic str) =>
    (DynamicFormVM.fromJson(str.toJson()));
List<DynamicFormDetailsVM> allFormVMFromJson(dynamic str) =>
    List<DynamicFormDetailsVM>.from(
        str.map((x) => DynamicFormDetailsVM.fromJson(x.toJson())));

class DynamicFormVM {
  late final List<DynamicFormFieldVM>? formField;
  late final DynamicFormDetailsVM? form;
  late final String? sTypename;

  DynamicFormVM(
      {required this.formField, required this.form, required this.sTypename});

  DynamicFormVM.fromJson(Map<String, dynamic> json) {
    if (json['formField'] != null) {
      formField = <DynamicFormFieldVM>[];
      json['formField'].forEach((v) {
        formField!.add(new DynamicFormFieldVM.fromJson(v));
      });
    }
    form = json['form'] != null
        ? new DynamicFormDetailsVM.fromJson(json['form'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.form != null) {
      data['form'] = this.form!.toJson();
    }
    if (this.formField != null) {
      data['formField'] = this.formField!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DynamicFormFieldVM {
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
  late final FormFieldSettingsVM? settings;
  late final String? sTypename;
  late final Metafield? metafield;
  late final String? formId;
  late final int? version;
  late final String? fieldType;
  late final String? creationDate;
  late final String? clientId;

  DynamicFormFieldVM({
    required this.sId,
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
    required this.placeHolder,
    required this.fieldType,
    required this.creationDate,
    required this.clientId,
    required this.formId,
    required this.version,
    required this.metafield,
  });

  DynamicFormFieldVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    label = json['label'];
    sortOrder = json['sortOrder'];
    hidden = json['hidden'];
    isCaseSensitive = json['isCaseSensitive'];
    type = json['type'];
    caseType = json['caseType'];
    readOnly = json['readOnly'];
    placeHolder = json['placeHolder'];
    required = json['required'];
    sTypename = json['__typename'];
    settings = json['settings'] != null
        ? new FormFieldSettingsVM.fromJson(json['settings'])
        : null;
    fieldType = json['fieldType'];
    creationDate = json['creationDate'];
    clientId = json['clientId'];
    formId = json['formId'];
    version = json['__v'];
    metafield = json['metafield'] != null
        ? Metafield.fromJson(json['metafield'])
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
    data['fieldType'] = fieldType;
    data['creationDate'] = creationDate;
    data['clientId'] = clientId;
    data['formId'] = formId;
    data['__v'] = version;
    if (metafield != null) {
      data['metafield'] = metafield!.toJson();
    }
    return data;
  }
}

class Metafield {
  late final String? sId;
  late final String? clientId;
  late final String? definition;
  late final String? name;
  late final String? namespace;
  late final String? key;
  late final String? description;
  late final String? type;
  late final String? storefrontAccess;
  late final String? valueType;
  late final bool? isUniqueValue;
  late final bool? isPresetChoices;
  late final List<dynamic>? presetChoices;
  late final int? minimumCharacterCount;
  late final int? maximumCharacterCount;
  late final int? maximumDecimalPlaces;
  late final String? regularExpression;
  late final String? acceptedFileType;
  late final List<dynamic>? acceptedFileTypes;
  late final String? status;
  late final String? creationDate;
  late final int? version;

  Metafield({
    required this.sId,
    required this.clientId,
    required this.definition,
    required this.name,
    required this.namespace,
    required this.key,
    required this.description,
    required this.type,
    required this.storefrontAccess,
    required this.valueType,
    required this.isUniqueValue,
    required this.isPresetChoices,
    required this.presetChoices,
    required this.minimumCharacterCount,
    required this.maximumCharacterCount,
    required this.maximumDecimalPlaces,
    required this.regularExpression,
    required this.acceptedFileType,
    required this.acceptedFileTypes,
    required this.status,
    required this.creationDate,
    required this.version,
  });

  Metafield.fromJson(Map<String, dynamic> json) {
    // print("Metafield tojson $json");
    sId = json['_id'];
    clientId = json['clientId'];
    definition = json['definition'];
    name = json['name'];
    namespace = json['namespace'];
    key = json['key'];
    description = json['description'];
    type = json['type'];
    storefrontAccess = json['storefrontAccess'];
    valueType = json['valueType'];
    isUniqueValue = json['isUniqueValue'];
    isPresetChoices = json['isPresetChoices'];
    presetChoices = json['presetChoices'] ?? [];
    minimumCharacterCount = json['minimumCharacterCount'];
    maximumCharacterCount = json['maximumCharacterCount'];
    maximumDecimalPlaces = json['maximumDecimalPlaces'];
    regularExpression = json['regularExpression'];
    acceptedFileType = json['acceptedFileType'];
    acceptedFileTypes = json['acceptedFileTypes'] ?? [];
    status = json['status'];
    creationDate = json['creationDate'];
    version = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['clientId'] = clientId;
    data['definition'] = definition;
    data['name'] = name;
    data['namespace'] = namespace;
    data['key'] = key;
    data['description'] = description;
    data['type'] = type;
    data['storefrontAccess'] = storefrontAccess;
    data['valueType'] = valueType;
    data['isUniqueValue'] = isUniqueValue;
    data['isPresetChoices'] = isPresetChoices;
    data['presetChoices'] = presetChoices;
    data['minimumCharacterCount'] = minimumCharacterCount;
    data['maximumCharacterCount'] = maximumCharacterCount;
    data['maximumDecimalPlaces'] = maximumDecimalPlaces;
    data['regularExpression'] = regularExpression;
    data['acceptedFileType'] = acceptedFileType;
    data['acceptedFileTypes'] = acceptedFileTypes;
    data['status'] = status;
    data['creationDate'] = creationDate;
    data['__v'] = version;
    return data;
  }
}

class FormFieldSettingsVM {
  late final List<FormFieldValidationVM>? validation;
  late final List<FormFieldOptionsVM>? options;
  late final List<FormFieldComparisonVM>? compare;
  late final String? sTypename;

  FormFieldSettingsVM(
      {required this.validation,
      required this.options,
      required this.compare,
      required this.sTypename});

  FormFieldSettingsVM.fromJson(Map<String, dynamic> json) {
    if (json['validation'] != null) {
      validation = <FormFieldValidationVM>[];
      json['validation'].forEach((v) {
        validation!.add(new FormFieldValidationVM.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <FormFieldOptionsVM>[];
      json['options'].forEach((v) {
        options!.add(new FormFieldOptionsVM.fromJson(v));
      });
    }
    if (json['compare'] != null) {
      compare = <FormFieldComparisonVM>[];
      json['compare'].forEach((v) {
        compare!.add(new FormFieldComparisonVM.fromJson(v));
      });
    }
    sTypename = json['__typename'];
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
    data['__typename'] = this.sTypename;

    return data;
  }
}

class FormFieldComparisonVM {
  late final int? type;
  late final int? operator;
  late final String? value;
  late final int? action;
  late final ComparisonOtherFieldVM? otherField;
  late final String? sTypename;

  FormFieldComparisonVM(
      {required this.value,
      required this.type,
      required this.sTypename,
      required this.action,
      required this.operator,
      required this.otherField});

  FormFieldComparisonVM.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    type = json['type'];
    action = json['action'];
    operator = json['operator'];
    sTypename = json['__typename'];
    otherField = json['otherField'] != null
        ? new ComparisonOtherFieldVM.fromJson(json['otherField'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['action'] = this.action;
    data['operator'] = this.operator;
    data['__typename'] = this.sTypename;
    if (this.otherField != null) {
      data['otherField'] = this.otherField!.toJson();
    }
    return data;
  }
}

class ComparisonOtherFieldVM {
  late final String? sId;
  late final String? name;
  late final String? label;
  late final String? sTypename;

  ComparisonOtherFieldVM(
      {required this.sId,
      required this.name,
      required this.sTypename,
      required this.label});

  ComparisonOtherFieldVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    label = json['label'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['label'] = this.label;
    data['__typename'] = this.sTypename;

    return data;
  }
}

List<FormFieldOptionsVM> optionVMFromJson(dynamic str) =>
    List<FormFieldOptionsVM>.from(
        str.map((x) => FormFieldOptionsVM.fromJson(x.toJson())));
List<FormFieldOptionsVM> optionValueVMFromJson(dynamic str) =>
    List<FormFieldOptionsVM>.from(
        str.map((x) => FormFieldOptionsVM.fromJson(x)));

class FormFieldOptionsVM {
  late final String? name;
  late final String? value;
  late final String? sTypename;
  FormFieldOptionsVM(
      {required this.value, required this.name, required this.sTypename});

  FormFieldOptionsVM.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['__typename'] = this.sTypename;

    return data;
  }
}

class FormFieldValidationVM {
  late final String? rule;
  late final String? value;
  late final String? message;
  late final String? sTypename;
  FormFieldValidationVM(
      {required this.rule,
      required this.value,
      required this.message,
      required this.sTypename});

  FormFieldValidationVM.fromJson(Map<String, dynamic> json) {
    rule = json['rule'];
    value = json['value'];
    message = json['message'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rule'] = this.rule;
    data['value'] = this.value;
    data['message'] = this.message;
    data['__typename'] = this.sTypename;

    return data;
  }
}

class DynamicFormDetailsVM {
  late final String? sId;
  late final String? name;
  late final String? userType;
  late final String? userTypeId;
  late final String? buttonLabel;
  late final String? description;
  late final UserTypeBannerVM? userTypeBanner;
  late final String? sTypename;

  DynamicFormDetailsVM(
      {required this.sId,
      required this.buttonLabel,
      required this.userType,
      required this.userTypeId,
      required this.userTypeBanner,
      required this.description,
      required this.name,
      required this.sTypename});

  DynamicFormDetailsVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buttonLabel = json['buttonLabel'];
    description = json['description'];
    userTypeId = json['userTypeId'];
    userType = json['userType'];
    userTypeBanner = json['userTypeBanner'] != null
        ? new UserTypeBannerVM.fromJson(json['userTypeBanner'])
        : null;
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['buttonLabel'] = this.buttonLabel;
    data['description'] = this.description;
    data['userTypeId'] = this.userTypeId;
    data['userType'] = this.userType;
    data['name'] = this.name;
    if (this.userTypeBanner != null) {
      data['userTypeBanner'] = this.userTypeBanner!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class UserTypeBannerVM {
  late final String? imageId;
  late final String? imageName;

  UserTypeBannerVM({
    required this.imageId,
    required this.imageName,
  });

  UserTypeBannerVM.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['imageId'] = this.imageId;
    return data;
  }
}
