import cds, { ApplicationService } from "@sap/cds";
import { Request } from "@sap/cds";
import jwt from "jsonwebtoken";
import { Entity, Users } from "../../lib/types/dhbw.caco.users";

type SignupParameters = {
  email: String;
  password: String;
  username: String;
};

type LoginParameters = {
  email: String;
  password: String;
};

export class AuthService extends ApplicationService {
  async init() {
    this.on("signup", this.handleSignup);
    this.on("login", this.handleLogin);

    await super.init();
  }

  private async handleLogin(req: Request): Promise<String> {
    const { email, password }: LoginParameters = req.data; //must not be verified, will be there

    const user: Users = await SELECT.one(Entity.Users).where({ email });

    if (!user) {
      req.reject(404, "User not found");
      return;
    }

    if (user.passwordHash !== password) {
      //TODO: use Hashes
      req.reject(404, "Wrong password");
      return;
    }

    const token = jwt.sign(
      { userName: user.username },
      process.env.JWT_SECRET,
      {
        expiresIn: process.env.JWT_EXPIRES_IN,
      }
    );

    return token;
  }

  private async handleSignup(req: Request): Promise<string> {
    //take signup data, write it in the db, and then generate jwt, decode email in it
    const userData: SignupParameters = req.data;

    const insertResult = await INSERT.into(Entity.Users).entries([userData]);

    if (!insertResult.results || insertResult.results.length !== 1) {
      req.reject(500, "An error occured");
      return;
    }

    const token = jwt.sign(
      { userName: userData.username },
      process.env.JWT_SECRET,
      {
        expiresIn: process.env.JWT_EXPIRES_IN,
      }
    );

    return token;
  }
}
