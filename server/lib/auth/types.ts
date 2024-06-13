
import cds from '@sap/cds';
import { Request } from "express";
import { Users } from '../types/dhbw.caco.schema';

/**
 * AuthRequestType.
 * The type for the request of the Auth.
 * It takes the standard express object and adds the cds user and tenant properties.
 */
export type AuthRequestType = Request & { user: cds.User; tenant: string };

/**
 * SignupParameters.
 * The type for the request of the signup.
 */
export type SignupParameters = {
	email: string;
	password: string;
	username: string;
};

/**
 * SignupReturn.
 * The type for the return of the signup.
 */
export type SignupReturn = {
	isSignedUp: Boolean;
}

/**
 * LoginParameters.
 * The type for the request of the login.
 */
export type LoginParameters = {
	email: string;
	password: string;
};

/**
 * LoginReturn.
 * The type for the return of the login.
 */
export type LoginReturn = {
	isLoggedIn: Boolean;
	user: Users;
}

