export interface Accounts {
    ID: string;
    createdAt?: Date;
    createdBy?: string;
    modifiedAt?: Date;
    modifiedBy?: string;
    accountType: number;
    name: string;
    user?: Users;
    user_username?: string;
}

export interface Categories {
    ID: string;
    createdAt?: Date;
    createdBy?: string;
    modifiedAt?: Date;
    modifiedBy?: string;
    accountType: number;
    name: string;
    user?: Users;
    user_username?: string;
    color: string;
    budget: number;
}

export interface FriendAccounts {
    ID: string;
    createdAt?: Date;
    createdBy?: string;
    modifiedAt?: Date;
    modifiedBy?: string;
    accountType: number;
    name: string;
    user?: Users;
    user_username?: string;
    nickName: string;
    friendship?: Friendships;
}

export interface Transactions {
    ID: string;
    createdAt?: Date;
    createdBy?: string;
    modifiedAt?: Date;
    modifiedBy?: string;
    activeAccount?: Accounts;
    activeAccount_ID?: string;
    passiveAccount?: Accounts;
    passiveAccount_ID?: string;
    amount: number;
    timestamp: Date;
}

export interface RecurringTransactions {
    ID: string;
    createdAt?: Date;
    createdBy?: string;
    modifiedAt?: Date;
    modifiedBy?: string;
    activeAccount?: Accounts;
    activeAccount_ID?: string;
    passiveAccount?: Accounts;
    passiveAccount_ID?: string;
    amount: number;
    startDate: Date;
    endDate: Date;
    interval: string;
}

export interface Users {
    username: string;
    email: string;
    passwordHash: string;
}

export interface Friendships {
    user1?: Users;
    user1_username?: string;
    user2?: Users;
    user2_username?: string;
}

export enum Entity {
    Accounts = "dhbw.caco.schema.Accounts",
    Categories = "dhbw.caco.schema.Categories",
    FriendAccounts = "dhbw.caco.schema.FriendAccounts",
    Transactions = "dhbw.caco.schema.Transactions",
    RecurringTransactions = "dhbw.caco.schema.RecurringTransactions",
    Users = "dhbw.caco.schema.Users",
    Friendships = "dhbw.caco.schema.Friendships"
}

export enum SanitizedEntity {
    Accounts = "Accounts",
    Categories = "Categories",
    FriendAccounts = "FriendAccounts",
    Transactions = "Transactions",
    RecurringTransactions = "RecurringTransactions",
    Users = "Users",
    Friendships = "Friendships"
}
