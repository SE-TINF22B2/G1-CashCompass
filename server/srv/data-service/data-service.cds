using dhbw.caco.schema as schema from '../../db';

service DataService {

        entity Accounts              as projection on schema.Accounts;
        entity Categories            as projection on schema.Categories;
        entity FriendAccounts        as projection on schema.FriendAccounts;
        entity Transactions          as projection on schema.Transactions;
        entity RecurringTransactions as projection on schema.RecurringTransactions;
        action getInitalPullData() returns String;
}
