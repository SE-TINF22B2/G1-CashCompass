using {cuid} from '@sap/cds/common';

namespace dhbw.caco.mock;

@assert.unique: {email: [email], }
entity MockEntity : cuid {
        email : String;
        name  : String;
}
