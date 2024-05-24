import cds, { insert } from "@sap/cds";
import { Entity, Users } from "../../types/dhbw.caco.schema";
import { LoginParameters, LoginReturn, SignupParameters, SignupReturn } from "../types";
import { IAuthValidator } from "./IAuthValidator";
import * as argon2 from "argon2";

const CUSTOM_SALT = process.env.CUSTOM_SALT;

export class PasswordValidator implements IAuthValidator {
	private logger = cds.log("pwValid");

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
