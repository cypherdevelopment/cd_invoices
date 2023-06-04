CREATE TABLE `invoices` (
	`title` VARCHAR(15) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`amount` INT(8) NULL DEFAULT NULL,
	`playerid` INT(3) NULL DEFAULT NULL,
	`invoiceno` VARCHAR(7) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'