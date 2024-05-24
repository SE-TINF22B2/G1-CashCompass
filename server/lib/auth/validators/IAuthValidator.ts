import { LoginParameters, LoginReturn, SignupParameters, SignupReturn } from '../types';
export interface IAuthValidator {
	login(data: LoginParameters): Promise<LoginReturn>;
	signup(data: SignupParameters): Promise<SignupReturn>;
}
