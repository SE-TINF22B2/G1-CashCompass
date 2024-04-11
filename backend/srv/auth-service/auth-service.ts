import { ApplicationService } from "@sap/cds";
import { Request } from "@sap/cds";
import jwt from "jsonwebtoken";
import { Entity, Users } from "../../lib/types/dhbw.caco.users";
import { LoginParameters, SignupParameters } from "../../lib/auth/types";
import { auth } from "../../lib";


export class AuthService extends ApplicationService {
  async init() {
    this.on("signup", this.handleSignup);
    this.on("login", this.handleLogin);

    await super.init();
  }

  private async handleLogin(req: Request): Promise<String> {
    const loginParams: LoginParameters = req.data; //must not be verified, will be there


    const loginData = await auth.Shared.validators.passwordValidator.login(loginParams);

    if (!loginData.isLoggedIn) {
      req.reject(403, "Login data invalid");
      return;
    }

    return auth.Shared.strategies.jwtStrategy.createJWT(loginData.user.username);

  }

  private async handleSignup(req: Request): Promise<string> {
    //take signup data, write it in the db, and then generate jwt, decode email in it
    const signupParams: SignupParameters = req.data;

    const signupData = await auth.Shared.validators.passwordValidator.signup(signupParams);

    if (!signupData.isSignedUp) {
      req.reject(500, "An error occured");
    }

    const token = auth.Shared.strategies.jwtStrategy.createJWT(signupParams.username);

    return token;
  }
}
