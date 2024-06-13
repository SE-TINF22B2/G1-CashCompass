import { IAuthStrategy } from "./strategy/IAuthStrategy";
import { JWTAuth } from "./strategy/jwt-auth";
import { IAuthValidator, PasswordValidator } from "./validators";

/**
 * The shared.ts file is a special one.
 * This combines everything in the auth folder, so it can be used easily from other modules.
 * The contents of this file are exported in the lib-level index file.
 * The combining of the modules increases the scalability.
 */

export namespace strategies {
	export const jwtStrategy: IAuthStrategy = new JWTAuth();
}

export namespace validators {
	export const passwordValidator: IAuthValidator = new PasswordValidator();
}
