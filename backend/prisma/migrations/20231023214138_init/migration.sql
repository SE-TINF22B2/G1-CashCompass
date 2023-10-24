-- CreateTable
CREATE TABLE "MockEntity" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,

    CONSTRAINT "MockEntity_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "MockEntity_email_key" ON "MockEntity"("email");
