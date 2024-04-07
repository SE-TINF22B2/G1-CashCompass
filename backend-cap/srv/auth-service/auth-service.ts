import cds, { ApplicationService } from "@sap/cds";
import { Request } from "express";

export class AuthService extends ApplicationService {
	async init() {

		this.on("signup", this.handleSignup);
		this.on("login", this.handleLogin);

		await super.init();
	}

	handleLogin(req: Request) {
		//take login data, check it with db and then generate jwt, decode email in it
		throw new Error("Method not implemented.");
	}

	handleSignup(req: Request) {
		//take signup data, write it in the db, and then generate jwt, decode email in it
		throw new Error("Method not implemented.");
	}

}
