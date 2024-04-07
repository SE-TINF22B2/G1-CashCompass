export interface Users {
    mail: string;
    username: string;
    passwordHash: string;
}

export enum Entity {
    Users = "dhbw.caco.users.Users"
}

export enum SanitizedEntity {
    Users = "Users"
}
