import {
    createParamDecorator,
    ExecutionContext,
} from '@nestjs/common';

export const GetUser = createParamDecorator(
    (
        data: string | undefined,
        ctx: ExecutionContext,
    ) => {
        //come back to this as this fails the test in the pipeline for some reason
        const request: any = ctx
            .switchToHttp()
            .getRequest();
        // const request: Express.Request = ctx
        //     .switchToHttp()
        //     .getRequest();
        if (data) {
            return request.user[data];
        }
        return request.user;
    },
);
