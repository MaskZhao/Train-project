using { mailService } from './mail-service';

annotate mailService.mail with{
    ID           @title : 'Label';
    name         @title : 'Name';
    receiver     @title : 'Receiver';
    status       @title : 'Status';
    amount       @title : 'Amount';
}

annotate mailService.changeLog with{
    ID           @title : 'Label';
    name         @title : 'Name';
    oldstatus    @title : 'OldStatus';
    newstatus    @title : 'NewStatus';
    changereason @title : 'ChangeReason';
    reason_code  @title : 'Reason_Code';
} ;

annotate mailService.mail with @(
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

annotate mailService.mail with actions {
 nextStatus @(
//    Core.OperationAvailable : {
//      $edmJson: { $Ne: [{ $Path: 'in/status'},'unshipped']}
//    },
   Common.SideEffects.TargetProperties : ['in/status','in/critification'],
   ) };


annotate mailService.mail with @(

    UI:{
        Identification : [
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'Next Status',
                Action : 'mailService.nextStatus',
                ![@UI.Importance] : #High,
                Criticality : #Positive
            }
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Mail',
            TypeNamePlural : 'Mail',
            Title :{
                $Type: 'UI.DataField',
                Value: ID
            },
            Description: {
                $Type :'UI.DataField',
                Value: name
            }
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
                Label  : 'Status',
            },
        ],
        SelectionFields  : [
            receiver,
            status
        ],
        LineItem  : [
            {Value : ID,
            ![@HTML5.CssDefaults] : {width : 'auto'},
            ![@UI.Importance] : #High
            },
            {Value : name,
            ![@HTML5.CssDefaults] : {width : 'auto'}
            },
            {Value : receiver,
            ![@HTML5.CssDefaults] : {width : 'auto'}
            },
            {
                Value : status,
                Criticality : critification,
                ![@HTML5.CssDefaults] : {width : 'auto'}
            },
            {Value : amount,
            ![@HTML5.CssDefaults] : {width : 'auto'}
            },
            {Value : modifiedAt},
            {Value : modifiedBy},
            {Value : createdAt},
            {Value : createdBy},
        ],
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Mail',
                Label  : 'MailStatus'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'ChangeLog',
                Target : 'changelog/@UI.PresentationVariant',
            }
        ],
        FieldGroup #Mail : {
            $Type : 'UI.FieldGroupType',
            //Label : 'MailStatus',
            Data: [
                {Value : ID},
                {Value: receiver},
                {Value: status,
                 Criticality:critification
                },
                {Value: amount},
            ]
        },
        FieldGroup #HeaderAdminData : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {Value : createdAt},
                {Value : createdBy},
                {Value : modifiedAt},
                {Value : modifiedBy}
            ]
        },
        FieldGroup #Status : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    Value : status,
                    Criticality : critification,
                }
            ],
        },
    },
){

};

annotate mailService.changeLog with @(
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

