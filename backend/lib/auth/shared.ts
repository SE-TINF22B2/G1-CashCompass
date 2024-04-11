import { IAuthStrategy } from "./strategy/IAuthStrategy";
import { JWTAuth } from "./strategy/jwt-auth";

export namespace strategies {
	export const jwtStrategy: IAuthStrategy = new JWTAuth();
}
