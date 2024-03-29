// NOT EDIT : use sh/gen/sql_func.coffee gen

import { UNSAFE } from "@w5/pg/PG";

export default (
	client_id,
	ip,
	browser_name,
	browser_ver,
	os_name,
	os_ver,
	device_vendor,
	device_model,
) => {
	console.log({
		client_id,
		ip,
		browser_name,
		browser_ver,
		os_name,
		os_ver,
		device_vendor,
		device_model,
	});
	return UNSAFE(
		"SELECT client_new($1,$2,$3,$4,$5,$6,$7,$8)",
		client_id,
		ip,
		browser_name,
		browser_ver || 0,
		os_name,
		os_ver || 0,
		device_vendor,
		device_model,
	);
};
