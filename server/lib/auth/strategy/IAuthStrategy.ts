import { User } from "@sap/cds";
import { auth } from '../../../lib'

export interface IAuthStrategy {
	createUser(req: auth.types.AuthRequestType): User;
	createJWT(userName: string): string;
}
