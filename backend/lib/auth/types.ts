
import cds from '@sap/cds';
import { Request } from "express";

export type AuthRequestType = Request & { user: cds.User; tenant: string };

export type SignupParameters = {
	email: string;
	password: string;
	username: string;
};

export type LoginParameters = {
	email: string;
	password: string;
};

