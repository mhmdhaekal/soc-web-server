import {
	sqliteTable,
	text,
	integer,
	blob,
	real,
} from "drizzle-orm/sqlite-core";

export const packets = sqliteTable("packets", {
	packetId: text("packet_id").primaryKey(),
	sourceIp: text("source_ip"),
	destinationIp: text("destination_ip"),
	sourcePort: integer("source_port"),
	destinationPort: integer("destination_port"),
	payload: blob(),
	timestamp: integer(),
	protocol: text(),
	packetSize: integer("packet_size"),
	payloadEntropy: real("payload_entropy"),
});
