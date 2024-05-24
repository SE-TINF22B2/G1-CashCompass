using {
        cuid,
        managed
} from '@sap/cds/common';
using dhbw.caco.accounts as accounts from '../accounts';

namespace dhbw.caco.transactions;

aspect BaseTransaction : cuid, managed {
        activeAccount  : Association to one accounts.Accounts;
        passiveAccount : Association to one accounts.Accounts;
        amount         : Double;
}

entity Transactions : BaseTransaction {
        timestamp : Timestamp;
}

entity RecurringTransactions : BaseTransaction {
        startDate : Timestamp;
        endDate   : Timestamp;
        interval  : String; //cron string
}
