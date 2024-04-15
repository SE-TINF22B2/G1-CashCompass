using dhbw.caco.mock as mock from '../../db';

@rest
service MockService {
        entity MockEntity as projection on mock.MockEntity;
}

annotate MockService with @(Authorization: {
        Authorizations : [
                {
                        $Type : 'Auth.Http',
                        Name  : 'Basic',
                        Scheme: 'basic'
                },
                {
                        $Type       : 'Auth.Http',
                        Name        : 'JWT',
                        Scheme      : 'bearer',
                        BearerFormat: 'JWT'
                },
        ],
        SecuritySchemes: [
                {Authorization: 'Basic'},
                {
                        Authorization : 'JWT',
                        RequiredScopes: []
                },
        ]
});
