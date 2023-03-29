using { masterService } from './master-service';

annotate masterService.mail with {
    @Common: {Text: receiver, }
    ID
};

annotate masterService.store with {
    @Common: {Text: category, }
    ID
}

annotate masterService.country with {
    @Common: {Text: country, }
    ID
}
annotate masterService.changeLog with{
    ID           @title : 'Label';
    name         @title : 'Name';
    oldstatus    @title : 'OldStatus';
    newstatus    @title : 'NewStatus';
    changereason @title : 'ChangeReason';
    reason_code  @title : 'Reason_Code';
} ;


annotate masterService.mail with @(
    Capabilities.DeleteRestrictions : {
        Deletable : true
    },
    Capabilities.UpdateRestrictions : {
        Updatable : true
    },
    Capabilities.InsertRestrictions : {
        Insertable : true
    }
){};

annotate masterService.mail with actions {
 nextStatus @(
   Common.SideEffects.TargetProperties : ['in/status','in/critification'],
) };

annotate masterService.master with @(
    Capabilities : {
        InsertRestrictions.Insertable : true,
        UpdateRestrictions.Updatable  : true,
        DeleteRestrictions.Deletable  : false,
    },

    UI :{
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
                Label : 'ChangeLog',
                Target : 'changelog/@UI.PresentationVariant',
            }
        ],
        FieldGroup #Master : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {Value : ID},
                {Value : name},
                {Value: mail.receiver},
                {Value: mail.status,
                 Criticality:mail.critification,
                 Label : 'mail',
                },
                {Value: mail.amount},
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
                {Value: mail.status,
                 Criticality:mail.critification,
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
    TextArrangement          : #TextFirst,
    ValueListWithFixedValues : true,
    ValueList                : {
      Label          : 'Country',
      CollectionPath : 'Country',
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
    TextArrangement          : #TextFirst,
    ValueListWithFixedValues : true,
    ValueList                : {
      Label          : 'MAIL',
      CollectionPath : 'mail',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterInOut',
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
    TextArrangement          : #TextFirst,
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
        }
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
            Deletable : true,
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
            {Value : modifiedAt},
            {Value : modifiedBy},
            {Value : createdAt},
            {Value : createdBy},
        ],
        PresentationVariant  : {
            $Type : 'UI.PresentationVariantType',
            SortOrder      : [{
            Property   : reason_code,
            Descending : true
            }],
            Visualizations : [
                '@UI.LineItem',
                '@Capabilities'
                ]
        },
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'ChangeLog',
            TypeNamePlural : 'Items',
        },
    },
){

};
