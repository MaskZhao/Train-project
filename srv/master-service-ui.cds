using { masterService } from './master-service';

annotate masterService.mail with @(
    Capabilities.DeleteRestrictions : {
        Deletable : true
    },
    Capabilities.UpdateRestrictions : {
        Updatable : true
    },
    Capabilities.InsertRestrictions : {
        Insertable : true
    },
){
    ID               @title : 'ID' @Common.FieldControl: #ReadOnly;
    name             @title : 'FoodName';
    status           @title : 'Status';
    receiver         @title : 'Receiver';
    critification    @title : 'Critification';
    amount           @title : 'Amount';
    @Common: {Text: receiver,}
    ID;
};

annotate masterService.store with @(
    Capabilities.DeleteRestrictions : {
        Deletable : true
    },
    Capabilities.UpdateRestrictions : {
        Updatable : true
    },
    Capabilities.InsertRestrictions : {
        Insertable : true
    },
){
    name     @title : 'Name';
    storage  @title : 'Storage';
    criticality @title : 'Criticality';

    @Common: {Text: category, }
    ID
};

annotate masterService.mailCountry with @(
    Capabilities.DeleteRestrictions : {
        Deletable : true
    },
    Capabilities.UpdateRestrictions : {
        Updatable : true
    },
    Capabilities.InsertRestrictions : {
        Insertable : true
    },
    UI :{
        Identification : [
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'Amount',
                Action : 'masterService.Amount',
                ![@UI.Importance] : #High,
                Criticality : #Positive
            },
        ],
         HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Country',
            TypeNamePlural : 'Items',
            Title : {
                $Type : 'UI.DataField',
                Value : country,
            },
            Description : {
                $Type : 'UI.DataField',
                Value : country,
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
                Target : '@UI.FieldGroup#Amount',
                Label  : 'Amount'
            },
        ],
        SelectionFields  : [
            country,
        ],
        LineItem  : [
            {Value : country,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            },
            {Value : amount,
            ![@HTML5.CssDefaults] : {width : 'auto'}
            },
        ],
        PresentationVariant  : {
            $Type : 'UI.PresentationVariantType',
            SortOrder      : [{
            Property   : amount,
            Descending : false
            }],
            Visualizations : [
                '@UI.LineItem',
                '@Capabilities',
                ]
        },
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#descr',
                Label  : 'Description'
            },
        ],
        FieldGroup #HeaderAdminData : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {Value : createdAt},
                {Value : createdBy},
                {Value : modifiedAt},
                {Value : modifiedBy},
            ]
        },
        FieldGroup #Amount : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    Value: amount,
                },
            ],
        },
        FieldGroup #descr :{
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    Value: descr_ID,
                },
            ],
        },
    },
){
    @title       : 'Country'
    @Common.Label: 'Country'
    @mandatory
    country;

    @title       : 'Amount'
    @Common.Label: 'Amount'
    @mandatory
    amount;

    @title        : 'Descr'
    @Common.Label : 'Description'
    @Common       : {
    Text                     : descr.descr,
    TextArrangement          : #TextOnly,
    ValueListWithFixedValues : true,
    ValueList                : {
      Label          : 'Description',
      CollectionPath : 'description',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterInOut',
          ValueListProperty : 'ID',
          LocalDataProperty : descr_ID
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'descr'
        }
      ]
    }
  }
  @mandatory
  descr;
};

annotate masterService.mailCountry with actions {
 Amount @(
    Common.SideEffects.TargetProperties : ['in/amount'],
);
};

annotate masterService.master with actions {
 nextStatus @(
    Common.SideEffects.TargetProperties : ['in/status','in/critification'],
);
 newStorage @(
    Common.SideEffects.TargetProperties : ['in/storage','in/criticality'],
)
};

annotate masterService.master with @(
    Capabilities : {
        InsertRestrictions.Insertable : true,
        UpdateRestrictions.Updatable  : true,
        DeleteRestrictions.Deletable  : true,
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
            name,
            mail_ID,
            store_ID,
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
                Value : status,
                Criticality : critification,
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
                Value : storage,
                Criticality : criticality ,
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
                Target : 'country/@UI.PresentationVariant',
                Label : 'Country',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Store',
                Label : 'Store',
            },
        ],
        FieldGroup #Master : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {Value : ID},
                {Value : name},
                {Value: mail_ID},
                {Value: store_ID},
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
                    Value: status,
                    Criticality:critification,
                },
                {
                    Value : storage,
                    Criticality : criticality,
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
                    Value : status,
                    Criticality : critification,
                    ![@HTML5.CssDefaults] : {width : 'auto'},
                },
                {
                    Value : mail.amount,
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
                Value : storage,
                Criticality : criticality,
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

    @title       : 'Status'
    @Common.Label: 'Status'
    @mandatory
    status;

    @title       : 'Storage'
    @Common.Label: 'Storage'
    @mandatory
    storage;

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