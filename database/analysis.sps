* Encoding: UTF-8.

* Crunchbase analysis
    Load the appropriate dataset before running each command

* Total funding independent of sustainability

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=TotalEquityFundingAmountCurrencyinUSD 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Total employees independent of sustainability
    
T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=employees 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Sustainability companies rank higher in CB Rank
    
T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=CBRankCompany 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* CB Rank 90-day trend independent of sustainability.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=TrendScore90Days 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* IPO independent of sustainability? Only 6 total/2 sustainability IPOs though

CROSSTABS 
  /TABLES=d_sustainability BY ipo 
  /FORMAT=AVALUE TABLES 
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

* Sustainability companies were not more likely to acquire others, but they were significantly less likely to be acquired.

CROSSTABS 
  /TABLES=d_sustainability BY acquirer acquiree 
  /FORMAT=AVALUE TABLES 
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

* Sustainability companies were not more likely to be active in IP.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=IPqweryIPActivityScore 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Sustainability companies were not (quite) built with less tech.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=BuiltWithActiveTechCount 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* SEMrush Global Traffic Rank was (barely) independent of sustainability status.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=SEMrushGlobalTrafficRank 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Number of investors & lead investors and funding rounds & last funding amount were independent of sustainability status.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=NumberofInvestors NumberOfLeadInvestors NumberOfFundingRounds LastEquityFundingAmount
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Number of articles was independent of sustainability status.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=NumberofArticles 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Sustainability companies had significantly fewer founders.

T-TEST GROUPS=d_sustainability(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=NumberofFounders 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Revenue independent of sustainability status.

CROSSTABS 
  /TABLES=d_sustainability BY revenue 
  /FORMAT=AVALUE TABLES 
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

* Diversity independent of sustainability status.

CROSSTABS 
  /TABLES=d_sustainability BY diversity BY d_region_us 
  /FORMAT=AVALUE TABLES 
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

* 5.19X (vs 5.70X0) median moic at sustainability IPO (40/10,704 vs 812/)
    
EXAMINE VARIABLES=moic_ipo 
  /PLOT BOXPLOT STEMLEAF 
  /COMPARE GROUPS 
  /STATISTICS DESCRIPTIVES 
  /CINTERVAL 95 
  /MISSING LISTWISE 
  /NOTOTAL
  /ID moic_ipo.

* 3.54x (vs 7.54x) median moic at sustainability acquisition

EXAMINE VARIABLES=moic_acq 
  /PLOT BOXPLOT STEMLEAF 
  /COMPARE GROUPS 
  /STATISTICS DESCRIPTIVES 
  /CINTERVAL 95 
  /MISSING LISTWISE 
  /NOTOTAL
  /ID moic_acq.

