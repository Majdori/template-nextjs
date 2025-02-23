FROM node:20-slim

RUN apt-get update -y && \
    apt-get install -y openssl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN pnpm install

COPY . .

RUN pnpm dlx prisma generate

RUN pnpm run build

EXPOSE 3000

CMD ["pnpm", "run", "start"]
