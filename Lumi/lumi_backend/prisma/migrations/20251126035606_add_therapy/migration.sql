-- CreateTable
CREATE TABLE "Therapy" (
    "id" SERIAL NOT NULL,
    "category" TEXT NOT NULL,
    "keywords" TEXT NOT NULL,
    "response" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Therapy_pkey" PRIMARY KEY ("id")
);
