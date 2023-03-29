using storeService from './store-service';


annotate storeService.store with {
    ID       @title: 'ID';
    category @title: 'Category';
    name     @title: 'Name';
    storage  @title: 'Storage';
}

annotate storeService.changeLog2 with {
    ID        @title: 'ID';
    attribute @title: 'Category';
    action    @title: 'Name';
    oldvalue  @title: 'OldValue';
    newvalue  @title: 'Newalue';
// datatime  @title: 'Datatime';
};

annotate storeService.store with @(
    UI: {
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
    FieldGroup #Main           : {Data: [
        {Value: category},
        {Value: name, },
        {
            Value      : storage,
            Criticality: criticality
        }
    ]}
}, );

annotate storeService.changeLog2 with @(
    UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'ChangeLog',
        TypeNamePlural: 'Items',
    },
    LineItem           : [
        {
            Value                : ID,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            Value                : attribute,
            ![@HTML5.CssDefaults]: {width: 'auto'}
        },
        {
            Value                : action,
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
        Visualizations: ['@UI.LineItem']
    },
}, ) {

};