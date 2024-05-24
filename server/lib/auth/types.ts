
import cds from '@sap/cds';
import { Request } from "express";
import { Users } from '../types/dhbw.caco.schema';

export type AuthRequestType = Request & { user: cds.User; tenant: string };

export type SignupParameters = {
	email: string;
	password: string;
	username: string;
};

export type SignupReturn = {
	isSignedUp: Boolean;
}

export type LoginParameters = {
	email: string;
	password: string;
};

export type LoginReturn = {
	isLoggedIn: Boolean;
	user: Users;
}

