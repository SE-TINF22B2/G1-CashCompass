import { User } from "@sap/cds";
import { auth } from '../../../lib'

/**
 * IAuthStrategy.
 * This interface is used to declare different strategies for the auth. 
 * It declares all methods that are needed if we want to add or swap the auth.
 */
export interface IAuthStrategy {
	/**
	 * createUser.
	 * This method takes the request and creates a CAP user of it.
	 *
	 * @param {auth.types.AuthRequestType} req
	 * @returns {User}
	 */
	createUser(req: auth.types.AuthRequestType): User;
	/**
	 * createJWT.
	 * This method takes the username and decodes it in a JWT.
	 *
	 * @param {string} userName
	 * @returns {string}
	 */
	createJWT(userName: string): string;
}
