FROM jarredsumner/bun:edge
WORKDIR /app
COPY package.json package.json
COPY bun.lockb bun.lockb
RUN bun install
RUN bun run build
COPY . .
EXPOSE 3000
ENTRYPOINT ["bun", ".output/server/index.mjs"]