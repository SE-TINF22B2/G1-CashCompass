import { Response, NextFunction } from "express";
import { auth } from '../../lib';
import cds from "@sap/cds";

export default function custom_auth(
  req: auth.types.AuthRequestType,
  res: Response,
  next: NextFunction
) {
  //the auth routes (login and signup) do not need auth
  if (req.baseUrl === "/rest/auth") {
    next();
    return;
  }

  try {
    req.user = auth.Shared.strategies.jwtStrategy.createUser(req);

    next();
  } catch (e) {
    return res.status(401).send().send();
  }

}
