
import cds from '@sap/cds';
import { Request } from "express";

export type AuthRequestType = Request & { user: cds.User; tenant: string };




