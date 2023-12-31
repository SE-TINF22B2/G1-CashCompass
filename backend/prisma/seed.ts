// prisma/seed.ts

import { PrismaClient } from '@prisma/client';

/**
 * The prisma client to access the DB.
 */
const prisma = new PrismaClient();

/**
 * The main seed function. This upserts some data in the DB.
 */
async function main() {
    // create two dummy articles
    const mockUser1 = await prisma.mockEntity.upsert({
        where: { email: '1@mock.de' },
        update: {},
        create: {
            email: '1@mock.de',
            name: "Mockuser 1"
        },
    });

    const mockUser2 = await prisma.mockEntity.upsert({
        where: { email: '2@mock.de' },
        update: {},
        create: {
            email: '2@mock.de',
            name: "Mockuser 2"
        },
    });

    console.log({ mockUser1, mockUser2 });
}

// execute the main function
main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        // close Prisma Client at the end
        await prisma.$disconnect();
    });
