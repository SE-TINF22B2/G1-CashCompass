export interface MockEntity {
    ID: string;
    email: string;
    name: string;
}

export enum Entity {
    MockEntity = "dhbw.caco.mock.MockEntity"
}

export enum SanitizedEntity {
    MockEntity = "MockEntity"
}
