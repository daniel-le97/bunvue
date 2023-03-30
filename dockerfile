FROM oven/bun as deps
WORKDIR /app
COPY package.json package.json
COPY bun.lockb bun.lockb
RUN bun install


FROM oven/bun as build
WORKDIR /app
COPY --from=deps /app .
COPY . .
RUN bun run build


FROM node:18.11.0-alpine as Runner
WORKDIR /app

# copy in everything we need to run the service
COPY ./package.json ./
COPY --from=build /app/dist ./dist

ENV NODE_ENV=production
EXPOSE 3000
ENTRYPOINT ["node", ".output/server/index.mjs"]