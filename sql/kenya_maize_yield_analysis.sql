/* 
Project: Kenya Maize Yield Risk Analysis (2000–2023)
Data Source: FAOSTAT
Purpose:
- Prepare yield data
- Calculate average yield
- Identify downside years
- Compute yield shortfall metrics
*/

-- 1. Select maize yield data for Kenya
SELECT
    year,
    value AS yield_kg_per_ha
FROM public.kenya_maize_yield_trend
WHERE item = 'Maize'
  AND element = 'Yield'
ORDER BY year;


-- 2. Compute long-term average yield
SELECT
    AVG(value) AS avg_yield_kg_per_ha
FROM public.kenya_maize_yield_trend
WHERE item = 'Maize'
  AND element = 'Yield';


-- 3. Identify downside yield years (below average)
WITH avg_yield AS (
    SELECT AVG(value) AS avg_yield
    FROM public.kenya_maize_yield_trend
    WHERE item = 'Maize'
      AND element = 'Yield'
)
SELECT
    t.year,
    t.value AS yield_kg_per_ha,
    (a.avg_yield - t.value) AS yield_shortfall_kg_per_ha
FROM public.kenya_maize_yield_trend t
CROSS JOIN avg_yield a
WHERE t.element = 'Yield'
  AND t.value < a.avg_yield
ORDER BY t.year;

-- 4. Estimate national yield loss (tonnes)
SELECT
    year,
    yield_shortfall_kg_per_ha,
    area_harvested_ha,
    (yield_shortfall_kg_per_ha * area_harvested_ha) / 1000 
        AS national_yield_loss_tonnes
FROM public.maize_yield_loss_view;
