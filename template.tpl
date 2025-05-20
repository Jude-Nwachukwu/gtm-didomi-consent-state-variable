___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "DD Didomi CMP Consent State (Unofficial)",
  "description": "This variable template works with Didomi CMP to detect and retrieve a user\u0027s consent state for a vendor or consent purpose, helping control how tags are executed in Google Tag Manager.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "didomiConsentStateCheckType",
    "displayName": "Select Consent State Check Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "didomiSpecificPurposeConsentState",
        "displayValue": "Consent Purpose State Check"
      },
      {
        "value": "didomiSpecificVendorConsentState",
        "displayValue": "Vendor Consent State"
      }
    ],
    "simpleValueType": true,
    "help": "Select the type of consent state check you want to perform—either a specific purpose consent category or vendor consent state (e.g..) Google Analytics."
  },
  {
    "type": "TEXT",
    "name": "didomiConsentPurpose",
    "displayName": "Insert The Didomi Purpose Category Name",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "didomiConsentStateCheckType",
        "paramValue": "didomiSpecificPurposeConsentState",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Enter the didomi purpose category here.",
    "valueHint": "e.g., analytics"
  },
  {
    "type": "TEXT",
    "name": "didomiByVendor",
    "displayName": "Enter Vendor Name",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "valueHint": "e.g., google",
    "help": "Here is where you enter the vendor name here.",
    "enablingConditions": [
      {
        "paramName": "didomiConsentStateCheckType",
        "paramValue": "didomiSpecificVendorConsentState",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "didomiEnableOptionalConfig",
    "checkboxText": "Enable Optional Output Transformation",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "didomiOptionalConfig",
    "displayName": "Didomi CMP Consent State Value Transformation",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "didomiGranted",
        "displayName": "Transform \"granted\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "didomiGrantedTrue",
            "displayValue": "true"
          },
          {
            "value": "didomiGrantedAccept",
            "displayValue": "accept"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "didomiDenied",
        "displayName": "Transform \"denied\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "didomiDeniedFalse",
            "displayValue": "false"
          },
          {
            "value": "didomiDeniedDeny",
            "displayValue": "deny"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "didomiUndefined",
        "checkboxText": "Also transform \"undefined\" to \"denied\"",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "didomiEnableOptionalConfig",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromWindow = require('copyFromWindow');
const makeString = require('makeString');
const getType = require('getType');

const checkType = data.didomiConsentStateCheckType;
const purposeInput = makeString(data.didomiConsentPurpose).toLowerCase();
const vendorInput = makeString(data.didomiByVendor).toLowerCase();

const enableTransform = data.didomiEnableOptionalConfig;
const transformGranted = data.didomiGranted;
const transformDenied = data.didomiDenied;
const transformUndefinedToDenied = data.didomiUndefined;

function transformValue(val) {
  if (getType(val) === 'undefined' && transformUndefinedToDenied) val = 'denied';
  if (!enableTransform) return val;

  if (val === 'granted') {
    return transformGranted === 'didomiGrantedTrue' ? true : 'accept';
  }
  if (val === 'denied') {
    return transformDenied === 'didomiDeniedFalse' ? false : 'deny';
  }
  return val;
}

function matchValueInList(input, csvList) {
  if (getType(csvList) !== 'string') return undefined;
  const values = csvList.split(',');
  for (let i = 0; i < values.length; i++) {
    const entry = values[i];
    if (getType(entry) !== 'string') continue;
    const core = entry.split('-')[0].toLowerCase();
    if (core === input) return 'granted';
  }
  return 'denied';
}

if (checkType === 'didomiSpecificPurposeConsentState') {
  const didomiPurposesEnabled = copyFromWindow('didomiState.didomiPurposesEnabled');
  const result = matchValueInList(purposeInput, didomiPurposesEnabled);
  return transformValue(result);
}

if (checkType === 'didomiSpecificVendorConsentState') {
  const didomiVendorsEnabled = copyFromWindow('didomiState.didomiVendorsEnabled');
  const result = matchValueInList(vendorInput, didomiVendorsEnabled);
  return transformValue(result);
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "didomiState.didomiPurposesEnabled"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "didomiState.didomiVendorsEnabled"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/20/2025, 9:54:26 AM


