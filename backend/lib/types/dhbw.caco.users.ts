export interface Users {
    email: string;
    username: string;
    passwordHash: string;
}

export enum Entity {
    Users = "dhbw.caco.users.Users"
}

export enum SanitizedEntity {
    Users = "Users"
}
