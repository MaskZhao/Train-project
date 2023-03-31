using { masterService } from './master-service';

annotate masterService.mail with {
    ID               @title : 'ID' @Common.FieldControl: #ReadOnly;
    name             @title : 'FoodName';
    status           @title : 'Status';
    receiver         @title : 'Receiver';
    critification    @title : 'Critification';
    amount           @title : 'Amount';
    @Common: {Text: receiver,}
    ID;

};

annotate masterService.store with {
    name     @title : 'Name';
    storage  @title : 'Storage';
    criticality @title : 'Criticality';

    @Common: {Text: category, }
    ID
}

annotate masterService.mailCountry with {
    @Common: {Text: country, }
    ID
}


annotate masterService.mail with @(
    Capabilities.DeleteRestrictions : {
        Deletable : false
    },
    Capabilities.UpdateRestrictions : {
        Updatable : true
    },
    Capabilities.InsertRestrictions : {
        Insertable : true
    },
){

};

annotate masterService.store with @(
    Capabilities.DeleteRestrictions : {
        Deletable : false
    },
    Capabilities.UpdateRestrictions : {
        Updatable : true
    },
    Capabilities.InsertRestrictions : {
        Insertable : true
    },
){

};

annotate masterService.master with actions {
 nextStatus @(
    Common.SideEffects.TargetEntities : ['in/mail'],
);
 newStorage @(
    Common.SideEffects.TargetEntities : ['in/store'],
)
};

annotate masterService.master with @(
    Capabilities : {
        InsertRestrictions.Insertable : true,
        UpdateRestrictions.Updatable  : true,
        DeleteRestrictions.Deletable  : false,
    },

    UI :{
        Identification : [
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'Next Status',
                Action : 'masterService.nextStatus',
                ![@UI.Importance] : #High,
                Criticality : #Positive
            },
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'New Storage',
                Action : 'masterService.newStorage',
                ![@UI.Importance] : #High,
                Criticality : #Positive
            }
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Master',
            TypeNamePlural : 'Master',
            Title : {
                $Type : 'UI.DataField',
                Value : ID,
            },
            Description : {
                $Type : 'UI.DataField',
                Value : name,
            },
        },

        HeaderFacets  : [
            {
                $Type : 'UI.CollectionFacet',
                Facets : [{
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#HeaderAdminData',
                }],
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Status',
                Label  : 'Status'
            },
        ],
        SelectionFields  : [
            mail_ID,
            store_ID,
            country_ID,
        ],

        LineItem  : [
            {
                Value : ID,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : name,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : mail.status,
                Criticality : mail.critification,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : mail_ID,
                Label : 'Receiver',
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : store_ID,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : country_ID,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : store.storage,
                Criticality : store.criticality ,
            },
            {Value : createdAt},
            {Value : createdBy},
            {Value : modifiedAt},
            {Value : modifiedBy},
        ],
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Master',
                Label  : 'Information'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#MailInfor',
                Label : 'MailInfor',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Country',
                Label : 'Country',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Store',
                Label : 'Store',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'ChangeLog',
                Target : 'changeLog/@UI.PresentationVariant',
            },
        ],
        FieldGroup #Master : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {Value : ID},
                {Value : name},
                {Value: mail_ID},
                {Value: store_ID,
                },
                {Value: country_ID},
            ]
        },
        FieldGroup #HeaderAdminData : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {Value : createdAt},
                {Value : createdBy},
                {Value : modifiedAt},
                {Value : modifiedBy},
            ]
        },
        FieldGroup #Status : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    Value: mail.status,
                    Criticality:mail.critification,
                },
                {
                    Value : store.storage,
                    Criticality : store.criticality,
                },
            ],
        },
        FieldGroup #MailInfor : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    Value : mail.name,
                    ![@HTML5.CssDefaults] : {width : 'auto'},
                },
                {
                    Value : mail.receiver,
                    ![@HTML5.CssDefaults] : {width : 'auto'},
                },
                {
                    Value : mail.status,
                    Criticality : mail.critification,
                    ![@HTML5.CssDefaults] : {width : 'auto'},
                },
                {
                    Value : mail.amount,
                    ![@HTML5.CssDefaults] : {width : 'auto'},
                },
            ],
        },
        FieldGroup #Country : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                Value : country.country,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : mail.status,
                Criticality : mail.critification,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
        ],
        },
        FieldGroup #Store : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                Value : store_ID,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : store.name,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {
                Value : store.storage,
                Criticality : store.criticality,
                ![@HTML5.CssDefaults] : {width : 'auto'},
            },
        ],
        },
    },
){
    @title       : 'ID'
    @Common.Label: 'ID'
    @mandatory
    ID;

    @title       : 'Name'
    @Common.Label: 'Name'
    @mandatory
    name;

    @title        : 'Country'
    @Common.Label : 'Country'
    @Common       : {
    Text                     : country.country,
    TextArrangement          : #TextOnly,
    ValueListWithFixedValues : true,
    ValueList                : {
      Label          : 'Country',
      CollectionPath : 'mailCountry',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterInOut',
          ValueListProperty : 'ID',
          LocalDataProperty : country_ID
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'country'
        }
      ]
    }
  }
  @mandatory
  country;


    @title        : 'MAIL'
    @Common.Label : 'Receiver'
    @Common       : {
    Text                     : mail.receiver,
    TextArrangement          : #TextOnly,
    ValueListWithFixedValues : true,
    ValueList                : {
      Label          : 'MAIL',
      CollectionPath : 'mail',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterOut',
          ValueListProperty : 'ID',
          LocalDataProperty : mail_ID
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'receiver'
        }
      ]
    }
  }
  @mandatory
  mail;

    @title        : 'STORE'
    @Common.Label : 'Category'
    @Common       : {
    Text                     : store.category,
    TextArrangement          : #TextOnly,
    ValueListWithFixedValues : true,
    ValueList                : {
      Label          : 'STORE',
      CollectionPath : 'store',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterInOut',
          ValueListProperty : 'ID',
          LocalDataProperty : store_ID
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'category'
        },
      ]
    }
  }
  @mandatory
  store;
};
annotate masterService.changeLog with @(
    Capabilities : {
        DeleteRestrictions : {
            $Type : 'Capabilities.DeleteRestrictionsType',
            Deletable : false,
        },
        UpdateRestrictions : {
            $Type : 'Capabilities.UpdateRestrictionsType',
            Updatable : true,
        },
        InsertRestrictions : {
            $Type : 'Capabilities.InsertRestrictionsType',
            Insertable : true,
        },
    },
    UI :{
        LineItem  : [
            {Value : ID,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {Value : name,
            ![@HTML5.CssDefaults] : {width : 'auto'}
            },
            {Value : oldstatus,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {Value : newstatus,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {Value : changereason,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {Value : reason_code,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            },
        ],
        PresentationVariant  : {
            $Type : 'UI.PresentationVariantType',
            SortOrder      : [{
            Property   : reason_code,
            Descending : true
            }],
            Visualizations : [
                '@UI.LineItem',
                '@Capabilities',
                ]
        },
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'ChangeLog',
            TypeNamePlural : 'Items',
        },
    },
){
    ID           @title : 'Label';
    name         @title : 'Name';
    oldstatus    @title : 'OldStatus';
    newstatus    @title : 'NewStatus';
    changereason @title : 'ChangeReason';
    reason_code  @title : 'Reason_Code';
};
