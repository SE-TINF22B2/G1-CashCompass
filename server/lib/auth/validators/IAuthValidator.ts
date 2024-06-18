import { LoginParameters, LoginReturn, SignupParameters, SignupReturn } from '../types';
/**
 * IAuthValidator.
 * This interface declares what is needed to add a validator to the application.
 * Validators take care of the authorization and login or signup users.
 */
export interface IAuthValidator {
	/**
	 * login.
	 * This is the method for logging in. It checks the login data und returns a jwt if successful.
	 *
	 * @param {LoginParameters} data
	 * @returns {Promise<LoginReturn>}
	 */
	login(data: LoginParameters): Promise<LoginReturn>;
	/**
	 * signup.
	 * This is the method for signing up. It checks the signup data und returns a jwt if successful.
	 *
	 * @param {SignupParameters} data
	 * @returns {Promise<SignupReturn>}
	 */
	signup(data: SignupParameters): Promise<SignupReturn>;
}
