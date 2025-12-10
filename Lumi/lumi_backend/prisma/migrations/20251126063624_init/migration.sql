/*
  Warnings:

  - A unique constraint covering the columns `[keyword]` on the table `Therapy` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Therapy_keyword_key" ON "Therapy"("keyword");
