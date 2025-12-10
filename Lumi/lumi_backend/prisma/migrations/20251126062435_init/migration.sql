/*
  Warnings:

  - You are about to drop the column `category` on the `Therapy` table. All the data in the column will be lost.
  - You are about to drop the column `keywords` on the `Therapy` table. All the data in the column will be lost.
  - Added the required column `keyword` to the `Therapy` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Therapy" DROP COLUMN "category",
DROP COLUMN "keywords",
ADD COLUMN     "keyword" TEXT NOT NULL;
