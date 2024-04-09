import cds, { ApplicationService } from "@sap/cds";
import { Request } from "@sap/cds";
import jwt from "jsonwebtoken";
import { Entity, Users } from "../../lib/types/dhbw.caco.users";
import * as argon2 from "argon2";

type SignupParameters = {
  email: string;
  password: string;
  username: string;
};

type LoginParameters = {
  email: string;
  password: string;
};

const CUSTOM_SALT = process.env.CUSTOM_SALT;

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

    const passwordMatch = await argon2.verify(user.passwordHash, password + CUSTOM_SALT);

    if (!passwordMatch) {
      req.reject(404, "Invalid credentials");
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

    const passwordHash = await argon2.hash(userData.password + CUSTOM_SALT);
    console.log(passwordHash);

    const insertResult = await INSERT.into(Entity.Users).entries([
      {
        email: userData.email,
        passwordHash,
        username: userData.username,
      },
    ]);

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
