import cds, { User } from "@sap/cds";
import { IAuthStrategy } from "./IAuthStrategy";
import { auth } from '../../../lib';
import jwt from 'jsonwebtoken';

/**
 * JWTAuth.
 *
 * @implements {IAuthStrategy}
 */
export class JWTAuth implements IAuthStrategy {

	/**
	 * @type {Logger}
	 */
	private logger = cds.log("auth");

	/**
	 * createUser.
	 * This method decodes the JWT from the request header and creates a CAP user with the username saved in the JWT.
	 *
	 * @param {auth.types.AuthRequestType} req
	 * @returns {User}
	 */
	createUser(req: auth.types.AuthRequestType): User {
		const authHeader = req.headers["authorization"];

		if (!authHeader || authHeader.split(" ").length !== 2) {
			this.logger.error("No token provided in following auth header: " + authHeader);
			throw new Error();
		}

		const token = authHeader.split(" ")[1];

		let user: User;

		jwt.verify(token, process.env.JWT_SECRET, (error, decoded) => {
			if (error) {
				this.logger.error("Failed to authenticate Token with error: " + error.message);
				throw new Error();
			}

			if (!decoded["userName"]) {
				this.logger.error("No username saved in token.");
				throw new Error();
			}


			user = new User(decoded["userName"]);

		});

		if (user && user.id) {
			return user;
		}

		throw new Error();
	}


	/**
	 * createJWT.
	 * This method codes the username into the token.
	 *
	 * @param {string} userName
	 * @returns {string} The JWT
	 */
	createJWT(userName: string): string {
		const token = jwt.sign(
			{ userName: userName },
			process.env.JWT_SECRET,
			{
				expiresIn: process.env.JWT_EXPIRES_IN,
			}
		);
		return token;
	}

}
