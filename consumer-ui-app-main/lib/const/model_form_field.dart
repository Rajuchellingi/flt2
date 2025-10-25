const userRegistrationForm = [
  {
    "label": "First Name",
    "name": "firstName",
    "errorMsg": "Please enter your first name",
    "required": true,
    "enabled": true,
    "type": 1,
    "pattern":
        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$"
  },
  {
    "label": "Last Name",
    "name": "lastName",
    "required": true,
    "enabled": true,
    "errorMsg": "Please enter your last name",
    "type": 1,
    "pattern":
        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$"
  },
  {
    "label": "Mobile Number",
    "name": "phone",
    "required": true,
    "errorMsg": "Please enter your mobile number",
    "enabled": true,
    "type": 2,
    "pattern": r'^[6789]\d{9}$'
  },
  {
    "label": "Email",
    "name": "email",
    "required": true,
    "enabled": true,
    "type": 7,
    "pattern": r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$'
  },
  {
    "label": "Password",
    "name": "password",
    "required": true,
    "enabled": true,
    "type": 8,
    "hidden": true
  },
];

const defaultRegistrationForm = [
  {
    "label": "Email",
    "name": "email",
    "required": true,
    "enabled": true,
    "type": "email",
    "fieldType": "form-field",
    "pattern": null
  },
  {
    "label": "Password",
    "name": "password",
    "required": true,
    "fieldType": "form-field",
    "enabled": true,
    "type": "password",
    "hidden": true
  },
];

const userRegistrationForm2 = [
  {
    "label": "Name",
    "name": "firstName",
    "errorMsg": "Please enter your name",
    "required": true,
    "enabled": true,
    "type": 1,
    "pattern":
        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$"
  },
  {
    "label": "Email",
    "name": "email",
    "required": true,
    "enabled": true,
    "type": 7,
    "pattern": r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$'
  },
  {
    "label": "Password",
    "name": "password",
    "required": true,
    "enabled": true,
    "type": 8,
    "hidden": true
  },
];
// const modelContactForm = [];
// const modelProfileForm = [];
const allModelFormField = [
  {"name": "firstName"},
  {"name": "lastName"},
  {"name": "phone"},
  {"name": "email"},
  {"name": "password"},
];

const ModelFields = ["firstName", "lastName", "phone", "email", "password"];
