CREATE TABLE `packets` (
	`packet_id` text PRIMARY KEY NOT NULL,
	`source_ip` text,
	`destination_ip` text,
	`source_port` integer,
	`destination_port` integer,
	`payload` blob,
	`timestamp` integer,
	`protocol` text,
	`packet_size` integer,
	`payload_entropy` real
);
