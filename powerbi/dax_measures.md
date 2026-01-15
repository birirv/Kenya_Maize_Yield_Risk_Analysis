# Power BI DAX Measures – Kenya Maize Yield Risk Analysis

#1. Average Yield (kg/ha)

Average Yield (kg/ha) =
AVERAGE('public kenya_maize_yield_trend'[Yield (kg/ha)])

#2. Yield Shortfall (kg/ha)
Yield Shortfall (kg/ha) = 
VAR LongTermAvgYield =
    CALCULATE(
        AVERAGE('public kenya_maize_yield_trend'[yield_kg_per_ha]),
        ALL('public kenya_maize_yield_trend')
    )
RETURN
IF(
    'public kenya_maize_yield_trend'[yield_kg_per_ha] < LongTermAvgYield,
    LongTermAvgYield
        - 'public kenya_maize_yield_trend'[yield_kg_per_ha],
    BLANK()
)

#3. Yield at Risk 90% (kg/ha)
Yield at Risk 90% (kg/ha) = 
VAR FilteredTable = 
    FILTER(        
        'public kenya_maize_yield_trend',
        'public kenya_maize_yield_trend'[Yield Shortfall (kg/ha)] > 0
    )
RETURN
    PERCENTILEX.INC(
        FilteredTable,
        'public kenya_maize_yield_trend'[Yield Shortfall (kg/ha)],
        0.90
    )
    //The maximum yield loss (kg/ha) that will not be exceeded with 90% confidence 

#4. Yield at Risk 95% (kg/ha)
Yield at Risk 95% (kg/ha) = 
VAR FilteredTable = 
    FILTER(
        'public kenya_maize_yield_trend',
        'public kenya_maize_yield_trend'[Yield Shortfall (kg/ha)] > 0
    )
RETURN
    PERCENTILEX.INC(
        FilteredTable,
        'public kenya_maize_yield_trend'[Yield Shortfall (kg/ha)],
        0.95
    )
    //The maximum yield loss (kg/ha) that will not be exceeded with 95% confidence interval
