import { IAuthStrategy } from "./strategy/IAuthStrategy";
import { JWTAuth } from "./strategy/jwt-auth";
import { IAuthValidator, PasswordValidator } from "./validators";

export namespace strategies {
	export const jwtStrategy: IAuthStrategy = new JWTAuth();
}

export namespace validators {
	export const passwordValidator: IAuthValidator = new PasswordValidator();
}
