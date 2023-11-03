import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { PrismaService } from "nestjs-prisma";
import { ExtractJwt, Strategy } from "passport-jwt";

export class JwtStrategy extends PassportStrategy(Strategy, 'jwt') {
    constructor(config: ConfigService, private readonly prisma: PrismaService) {
        super({
            jwtFromRequest:
                ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey: config.get('JWT_SECRET'),
        })
    }

    async validate(payload: {
        sub: number,
        email: string
    }) {
        const user = await this.prisma.user.findUniqueOrThrow({
            where: {
                id: payload.sub
            }
        });

        delete user.passwordHash;

        return user;
    }
}