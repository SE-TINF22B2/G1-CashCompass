import cds from "@sap/cds";
import { Request, Response, NextFunction } from "express";
type Req = Request & { user: cds.User, tenant: string };

export default function custom_auth(req: Req, res: Response, next: NextFunction) {
	req.user = new cds.User("MoinMeister");

	next();
}
