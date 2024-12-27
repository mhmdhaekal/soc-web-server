import { Hono } from "hono";
import { logger } from "hono/logger";
import { secureHeaders } from "hono/secure-headers";
import { get_db } from "./app/database/lib";
import { getConnInfo } from "hono/bun";

let app = new Hono();

app.use(secureHeaders());
app.use(logger());

app.get("/", async (c) => {
	let db = get_db();
	let ip_address = getConnInfo(c).remote.address;
	let all_packets = await db.query.packets.findMany();

	return c.json({
		status: 200,
		message: "Success Get All Packets",
		ip_address,
		data: {
			packets: all_packets,
		},
	});
});

export default {
	port: Bun.env.PORT ?? "3000",
	fetch: app.fetch,
};

