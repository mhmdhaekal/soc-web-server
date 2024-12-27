FROM oven/bun:alpine AS base

WORKDIR /app

FROM base AS install

RUN mkdir -p /temp/dev /temp/prod

COPY package.json bun.lock bunfig.toml /temp/dev/
COPY package.json bun.lock bunfig.toml /temp/prod/

RUN cd /temp/dev && bun install --frozen-lockfile

RUN cd /temp/prod && bun install --frozen-lockfile --production

FROM base AS prerelease

COPY --from=install /temp/dev/node_modules ./node_modules

COPY . .

FROM base AS release

COPY --from=install /temp/prod/node_modules ./node_modules
COPY --from=prerelease /app/app ./app
COPY --from=prerelease /app/drizzle ./drizzle
COPY --from=prerelease /app/migrate.ts ./migrate.ts
COPY --from=prerelease /app/package.json ./package.json
COPY --from=prerelease /app/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --from=prerelease /app/index.ts ./index.ts

RUN chmod +x /usr/local/bin/entrypoint.sh
ENV NODE_ENV=production
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["bun", "run", "index.ts"]
