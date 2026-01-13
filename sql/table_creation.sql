DROP TABLE IF EXISTS kenya_maize_production;

CREATE TABLE kenya_maize_production (
    domain TEXT,
    area_code_m49 INT,
    area TEXT,
    element_code INT,
    element TEXT,
    item TEXT,
    year INT,
    unit TEXT,
    value NUMERIC
);
SELECT
    column_name,
    data_type,
    ordinal_position
FROM information_schema.columns
WHERE table_name = 'kenya_maize_production'
ORDER BY ordinal_position;
