using storeService from './store-service';

annotate storeService.store with actions {
 nextStatus @(
   Common.SideEffects.TargetProperties : ['in/storage','in/criticality'],
   ) 
};

annotate storeService.store with @(
    Capabilities : {
        InsertRestrictions.Insertable : true,
        UpdateRestrictions.Updatable  : true,
        DeleteRestrictions.Deletable  : true,
    },
    UI: {
    Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Balance Storage',
            Action : 'storeService.nextStatus',
            ![@UI.Importance] : #High,
            Criticality : #Positive
        }
    ],
    HeaderInfo                 : {
        TypeName      : 'Store',
        TypeNamePlural: 'Store items',
        Title         : {
            $Type: 'UI.DataField',
            Value: category
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: name
        }
    },
    SelectionFields            : [
        category,
        name
    ],
    LineItem                   : [
        {
            Value                : ID,
            ![@HTML5.CssDefaults]: {width: 'auto'},
            ![@UI.Importance]    : #High
        },
        {
            Value                : category,
            ![@HTML5.CssDefaults]: {width: 'auto'}
        },
        {
            Value                : name,
            ![@HTML5.CssDefaults]: {width: 'auto'}
        },
        {
            Value      : storage,
            Criticality: criticality
        }
    ],

    HeaderFacets               : [ //头部标签页
        {
            $Type : 'UI.CollectionFacet',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#HeaderAdminData',
            }],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Status',
            Label : 'Storage Capacity',
        }
    ],
    FieldGroup #HeaderAdminData: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: createdAt},
            {Value: createdBy},
            {Value: modifiedAt},
            {Value: modifiedBy}
        ]
    },
    FieldGroup #Status         : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            Value      : storage,
            Criticality: criticality
        }],
    },
    Facets                     : [ //带选择项的子标签页
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'detailed information',
            Target: '@UI.FieldGroup#Main'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'ChangeLog',
            Target: 'changeLog2/@UI.PresentationVariant',
        }
    ],
    FieldGroup #Main    : {Data: [
        {Value: category},
        {Value: name, },
        {
            Value      : storage,
            Criticality: criticality
        }
    ]}
}){
    ID       @title: 'ID';
    category @title: 'Category';
    name     @title: 'Name';
    storage  @title: 'Storage';
};

annotate storeService.changeLog2 with @(
    Capabilities : {
        InsertRestrictions.Insertable : false,
        UpdateRestrictions.Updatable : false
    },
    UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'ChangeLog',
        TypeNamePlural: 'Items',
    },
    LineItem           : [
        {
            Value                : attribute,
            ![@HTML5.CssDefaults]: {width: 'auto'}
        },
        {
            Value                : name,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            Value                : oldvalue,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            Value                : newvalue,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        }
    ],
    PresentationVariant: { //数据展示变量
        $Type         : 'UI.PresentationVariantType',
        SortOrder     : [{
            Property  : datatime,
            Descending: true
        }],
        Visualizations: [
            '@UI.LineItem',
            '@Capabilities'
        ]
    },
}) {
    attribute  @title: 'Category';
    name       @title: 'Name';
    oldvalue   @title: 'OldValue';
    newvalue   @title: 'Newalue';
};