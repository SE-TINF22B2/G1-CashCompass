export interface MockEntity {
    ID: string;
    createdAt?: Date;
    createdBy?: string;
    modifiedAt?: Date;
    modifiedBy?: string;
    email: string;
    name: string;
}

export enum Entity {
    MockEntity = "dhbw.caco.mock.MockEntity"
}

export enum SanitizedEntity {
    MockEntity = "MockEntity"
}
