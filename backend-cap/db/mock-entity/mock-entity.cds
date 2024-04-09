using {
        cuid,
        managed
} from '@sap/cds/common';

namespace dhbw.caco.mock;

@assert.unique: {email: [email], }
entity MockEntity : cuid, managed {
        email : String;
        name  : String;
}
