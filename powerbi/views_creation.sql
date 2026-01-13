CREATE OR REPLACE VIEW kenya_maize_yield_trend AS
SELECT 
    year,
    value AS yield_kg_per_ha
FROM kenya_maize_production
WHERE element = 'Yield'
ORDER BY year;
