using {
        cuid,
        managed
} from '@sap/cds/common';

using dhbw.caco.users as users from '../users';

namespace dhbw.caco.accounts;

aspect BaseAccount : cuid, managed {
        isActive : Boolean;
        name     : String;
        user     : Association to one users.Users;
}

//category is nen account
entity Accounts : BaseAccount {}

entity Category : BaseAccount {
        color  : String;
        budget : Double;
}

entity FriendAccount : BaseAccount {
        nickName   : String;
        friendship : Association to one users.Friendships;
}
