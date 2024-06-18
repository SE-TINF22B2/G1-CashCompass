import cds, { insert } from "@sap/cds";
import { Entity, Users } from "../../types/dhbw.caco.schema";
import { LoginParameters, LoginReturn, SignupParameters, SignupReturn } from "../types";
import { IAuthValidator } from "./IAuthValidator";
import * as argon2 from "argon2";

const CUSTOM_SALT = process.env.CUSTOM_SALT;

/**
 * PasswordValidator.
 * This is the password implemenation of a validator. 
 * It does the validation with usernames and passwords.
 *
 * @implements {IAuthValidator}
 */
export class PasswordValidator implements IAuthValidator {
	/**
	 * @type {}
	 */
	private logger = cds.log("pwValid");

	/**
	 * login.
	 * This is the method for logging in. It checks the login data und returns a jwt if successful.
	 *
	 * @param {LoginParameters} data
	 * @returns {Promise<LoginReturn>}
	 */
	async login(data: LoginParameters): Promise<LoginReturn> {
		const user: Users = await SELECT.one(Entity.Users).where({ email: data.email });

		if (!user) {
			this.logger.log("No User found");
			return {
				isLoggedIn: false,
				user
			};
		}

		const passwordMatch = await argon2.verify(user.passwordHash, data.password + CUSTOM_SALT);

		return {
			isLoggedIn: passwordMatch,
			user
		};

	}
	/**
	 * signup.
	 * This is the method for signin up. It checks the login data und returns a jwt if successful.
	 *
	 * @param {SignupParameters} data
	 * @returns {Promise<SignupReturn>}
	 */
	async signup(data: SignupParameters): Promise<SignupReturn> {
		const passwordHash = await argon2.hash(data.password + CUSTOM_SALT);

		const insertResult = await INSERT.into(Entity.Users).entries([
			{
				email: data.email,
				passwordHash,
				username: data.username
			},
		]);

		if (!insertResult.results || insertResult.results.length !== 1) {
			return { isSignedUp: false };
		}

		return {
			isSignedUp: true,
		}
	}

}
