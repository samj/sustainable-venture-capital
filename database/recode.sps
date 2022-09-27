* Encoding: UTF-8.

* Extract year from dates (XDATE)

compute LastFundingYear = xdate.year(LastFundingDate).
compute FoundedYear = xdate.year(FoundedDate).
compute ExitYear = xdate.year(ExitDate).
compute ClosedYear = xdate.year(ClosedDate).
formats LastFundingYear FoundedYear ExitYear ClosedYear(f4.0).

compute d_sustainability = (char.index(upcase(IndustryGroups),'SUSTAINABILITY') > 0).
compute d_region_us = (char.index(upcase(HeadQuartersLocation),'UNITED STATES') > 0).
compute d_region_latam = (char.index(upcase(HeadQuartersRegions),'LATIN AMERICA') > 0).
compute d_region_eu = (char.index(upcase(HeadQuartersRegions),'EUROPEAN UNION') > 0).
compute d_region_apac = (char.index(upcase(HeadQuartersRegions),'APAC') > 0).
execute.

formats d_sustainability d_region_us d_region_latam d_region_eu d_region_apac (f4.0).

* Acquisition status

compute acquirer = (char.index(upcase(AcquisitionStatus),'MADE ACQUISITIONS') > 0).
compute acquiree = (char.index(upcase(AcquisitionStatus),'WAS ACQUIRED') > 0).
execute.
formats acquirer acquiree(f2.0).

* Diversity
    
compute diversity_women = (char.index(upcase(DiversitySpotlightUSOnly),'WOMEN') > 0).
compute diversity_black = (char.index(upcase(DiversitySpotlightUSOnly),'BLACK') > 0).
compute diversity_hispanic = (char.index(upcase(DiversitySpotlightUSOnly),'HISPANIC') > 0).
compute diversity_asian = (char.index(upcase(DiversitySpotlightUSOnly),'ASIAN') > 0).
formats diversity_women diversity_black diversity_hispanic diversity_asian(f2.0).
execute.

compute diversity=0.
if diversity_women=1 diversity=1.
if diversity_black=1 diversity=1.
if diversity_hispanic=1 diversity=1.
if diversity_asian=1 diversity=1.
formats diversity(f2.0).
execute.

* Number of employees

recode NumberofEmployees ('1-10'=1) ('11-50'=2) ('51-100'=3) ('101-250'=4) ('251-500'=5) 
    ('501-1000'=6) ('1001-5000'=7) ('5001-10000'=8) ('10001+'=9) INTO employees. 
execute.
formats employees(f2.0).

value labels employees
    1 '1-10'
    2 '11-50'
    3 '51-100'
    4 '101-250'
    5 '251-500'
    6 '501-1000'
    7 '1001-5000'
    8 '5001-10000'
    9 '10001+'.

* Estimated revenue range
    
recode EstimatedRevenueRange ('Less than $1M'=1) ('$1M to $10M'=2) ('$10M to $50M'=3) ('$50M to $100M'=4) ('$100M to $500M'=5) 
    ('$500M to $1B'=6) ('$1B to $10B'=7) INTO revenue. 
execute.
formats revenue(f2.0).

value labels revenue
    1 'Less than $1M'
    2 '$1M to $10M'
    3 '$10M to $50M'
    4 '$50M to $100M'
    5 '$100M to $500M'
    6 '$500M to $1B'
    7 '$1B to $10B'.

* Initial Public Offerings (IPOs)

recode IPOStatus ('Private'=0) ('Public'=1) into ipo. 
variable labels  ipo 'IPO'.
formats ipo(f2.0).

compute moic_ipo = ValuationatIPOCurrencyinUSD / TotalEquityFundingAmountCurrencyinUSD.
compute moic_acq = PriceCurrencyinUSD / TotalEquityFundingAmountCurrencyinUSD.
execute.

    
