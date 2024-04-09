import cds from "@sap/cds";
import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
type Req = Request & { user: cds.User; tenant: string };

export default function custom_auth(
  req: Req,
  res: Response,
  next: NextFunction
) {
  if (req.baseUrl === "/rest/auth") {
    next();
    return;
  }

  const authHeader = req.headers["authorization"];

  if (!authHeader || authHeader.split(" ").length !== 2) {
    return res.status(403).send({ auth: false, message: "No token provided." });
  }

  const token = authHeader.split(" ")[1];

  jwt.verify(token, process.env.JWT_SECRET, function (error, decoded) {
    if (error) {
      cds
        .log("auth")
        .error("Failed to authenticate Token with error: " + error.message);

      return res.status(500).send("Failed to authenticate Token.");
    }

    if (!decoded["userName"]) {
      return res.status(403).send("No username saved in token.");
    }

    req.user = new cds.User(decoded["userName"]);
    next();
  });
}
