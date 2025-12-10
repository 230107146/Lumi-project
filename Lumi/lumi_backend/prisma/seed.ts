import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
    console.log('Seeding database...');

    // Admin user
    const adminPassword = await bcrypt.hash('admin123', 10);
    await prisma.user.upsert({
        where: { email: 'admin@lumi.com' },
        update: {},
        create: {
            email: 'admin@lumi.com',
            name: 'Admin User',
            password: adminPassword,
        },
    });

    // Example therapy questions/responses
    const therapyData = [
        { keyword: 'anxiety', response: 'Take deep breaths, focus on the present moment, and consider talking to a therapist.' },
        { keyword: 'depression', response: 'Reach out to a trusted friend or professional. Small daily goals can help.' },
        { keyword: 'addiction', response: 'Seek support groups or professional help, and avoid triggers.' },
        { keyword: 'stress', response: 'Try meditation, exercise, or journaling to relieve stress.' }
    ];

    for (const item of therapyData) {
        await prisma.therapy.upsert({
            where: { keyword: item.keyword },
            update: {},
            create: item
        });
    }

    console.log('Seeding complete.');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
