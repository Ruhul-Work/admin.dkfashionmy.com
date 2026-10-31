-- Run this once against the existing `dk-international` database.
-- The countries table currently uses MyISAM, so country_id is indexed but is
-- intentionally not declared as a foreign key.

ALTER TABLE `divisions`
    ADD COLUMN `country_id` BIGINT UNSIGNED NULL AFTER `id`,
    ADD INDEX `divisions_country_id_index` (`country_id`);

UPDATE `divisions`
SET `country_id` = (
    SELECT `id`
    FROM `countries`
    WHERE `name` = 'Malaysia'
    LIMIT 1
)
WHERE `country_id` IS NULL;

ALTER TABLE `divisions`
    MODIFY COLUMN `country_id` BIGINT UNSIGNED NOT NULL;

ALTER TABLE `sales`
    ADD COLUMN `division_id` INT NULL AFTER `city`,
    ADD COLUMN `district_id` INT UNSIGNED NULL AFTER `division_id`,
    ADD COLUMN `upazila_id` INT UNSIGNED NULL AFTER `district_id`,
    ADD INDEX `sales_division_id_index` (`division_id`),
    ADD INDEX `sales_district_id_index` (`district_id`),
    ADD INDEX `sales_upazila_id_index` (`upazila_id`),
    MODIFY COLUMN `postal_code` VARCHAR(20) NULL;
