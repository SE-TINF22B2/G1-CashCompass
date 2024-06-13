import { ApplicationService } from "@sap/cds";
import { Request } from "@sap/cds";
import { LoginParameters, SignupParameters } from "../../lib/auth/types";
import { auth } from "../../lib";

/**
 * AuthService.
 * This is the service that configures all the endpoints regarding the auth.
 * It implements the logic for login and signup.
 *
 * @extends {ApplicationService}
 */
export class AuthService extends ApplicationService {
  /**
   * init.
   * This init overrides the init of the Application Service. Its used to define custom handler.
   * Because of this, we have to declare our handlers vefore calling the super method.
   */
  async init() {
    this.on("signup", this.handleSignup);
    this.on("login", this.handleLogin);

    await super.init();
  }

  /**
   * handleLogin.
   * This method handles the login. It uses the login data in the body of the request.
   * It creates a JWT, if everything is fine and throws a 403 error if the data is invalid.
   *
   * @param {Request} req
   * @returns {Promise<String>}
   */
  private async handleLogin(req: Request): Promise<String> {
    const loginParams: LoginParameters = req.data; //must not be verified, will be there


    const loginData = await auth.Shared.validators.passwordValidator.login(loginParams);

    if (!loginData.isLoggedIn) {
      req.reject(403, "Login data invalid");
      return;
    }

    return auth.Shared.strategies.jwtStrategy.createJWT(loginData.user.username);

  }

  /**
   * This method handles the signup. It uses the user data in the body of the request.
   * It creates a JWT, if everything is fine and throws a 403 error if the data is invalid.
   *
   * @param {Request} req
   * @returns {Promise<string>}
   */
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
