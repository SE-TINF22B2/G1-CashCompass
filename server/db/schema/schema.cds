using {
        cuid,
        managed
} from '@sap/cds/common';


namespace dhbw.caco.schema;

aspect BaseAccount : cuid, managed {
        accountType    : Integer; //0=active, 1=passive
        name           : String;
        user           : Association to one Users;
        account_number : Integer;
}

//category is nen account
entity Accounts : BaseAccount {}

entity Categories : BaseAccount {
        color  : String;
        budget : Double;
}

entity FriendAccounts : BaseAccount {
        nickName   : String;
        friendship : Association to one Friendships;
}

aspect BaseTransaction : cuid, managed {
        activeAccount  : Association to one Accounts;
        passiveAccount : Association to one Accounts;
        amount         : Double;
        label          : String;
        transactionsNr : Integer;
}


entity Transactions : BaseTransaction {
        timestamp : Timestamp;
}

entity RecurringTransactions : BaseTransaction {
        startDate : Timestamp;
        endDate   : Timestamp;
        interval  : String; //cron string
}

@assert.unique: {email: [email], }
entity Users {
        key username     : String;
            email        : String @mandatory;
            passwordHash : String @mandatory;
}

entity Friendships {
        user1 : Association to Users;
        user2 : Association to Users;
}
