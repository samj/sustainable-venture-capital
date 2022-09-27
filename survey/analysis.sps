* Encoding: UTF-8.

* Establish working directory

cd '/Users/samj/Library/CloudStorage/OneDrive-Personal/Education/MBA/ABR/Survey/'.

* Specify file path (make sure extension is included)

get file='dataset.sav'.
    
* Demographics

FREQUENCIES VARIABLES=gender generation investor_type
  /PIECHART PERCENT
  /FORMAT=LIMIT(10)
  /ORDER=ANALYSIS.    

* Countries

FREQUENCIES VARIABLES=country
  /PIECHART PERCENT
  /FORMAT=DFREQ LIMIT(10)
  /ORDER=ANALYSIS.

* Holding period

FREQUENCIES VARIABLES=holding_period
  /STATISTICS=MEAN MEDIAN MODE
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

* Hurdle rate

EXAMINE VARIABLES=hurdle_rate
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL
  /ID=hurdle_rate.

* Net Promoter Score (NPS)

FREQUENCIES VARIABLES=nps
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=nps_type
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

* Motivation rankings
    
DESCRIPTIVES VARIABLES=rank_environment rank_resilience rank_performance rank_legacy 
    rank_empowerment 
  /STATISTICS=MEAN SUM STDDEV VARIANCE 
  /SORT=MEAN (D).

* Sustainable Development Goals (SDGs)
    
GRAPH
  /BAR(SIMPLE)=SUM(sdg17) SUM(sdg16) SUM(sdg15) SUM(sdg14) SUM(sdg13) SUM(sdg12) SUM(sdg11)
    SUM(sdg10) SUM(sdg9) SUM(sdg8) SUM(sdg7) SUM(sdg6) SUM(sdg5) SUM(sdg4) SUM(sdg3) SUM(sdg2)
    SUM(sdg1)
  /MISSING=LISTWISE.
    
CROSSTABS
  /TABLES=gender BY sdg1 sdg2 sdg3 sdg4 sdg5 sdg6 sdg7 sdg8 sdg9 sdg10 sdg11 sdg12 sdg13 sdg14
    sdg15 sdg16 sdg17
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=d_generation_older BY sdg1 sdg2 sdg3 sdg4 sdg5 sdg6 sdg7 sdg8 sdg9 sdg10 sdg11 sdg12 sdg13 sdg14
    sdg15 sdg16 sdg17
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL.

* Motivation for sustainable investments is independent of age (χ2 (1) = 2.030; P = 0.154)

CROSSTABS
  /TABLES=d_generation_older BY motivation_ranking_1
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Investor professionalism is dependent on generation (χ2 (1) = 18.675; P = <0.001)

CROSSTABS
  /TABLES=d_generation_older BY d_investor_type_pro
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Preference for sustainable investments is independent of gender (χ2 (1) = 1.432; P = 0.231)

CROSSTABS
  /TABLES=gender BY d_sustainability_preferred
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Preference for sustainable investments is independent of age (χ2 (1) = 2.030; P = 0.154)

CROSSTABS
  /TABLES=d_generation_older BY d_sustainability_preferred
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Preference for sustainable investments is independent of holding period (χ2 (1) = 0.835; P = 0.361)

CROSSTABS
  /TABLES=d_holding_period_long BY d_sustainability_preferred
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Preference for sustainable investments is dependent on professionalism of investor (χ2 (1) = 4.966; P = 0.040)

CROSSTABS
  /TABLES=d_investor_type_pro BY d_sustainability_preferred
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Preference for sustainable investments is independent of risk appetite (χ2 (1) = 1.419; P = 0.234)

CROSSTABS
  /TABLES=d_risk_appetite_high BY d_sustainability_preferred
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Preference for sustainable investments is dependent on NPS answer (χ2 (2) = 33.670; P < 0.001)

CROSSTABS
  /TABLES=nps_type BY d_sustainability_preferred
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* One sample t-test (Gender)
    Even popluation of females (1) and males (2) with no others (3) averages 1.5

T-TEST 
  /TESTVAL=1.5 
  /MISSING=ANALYSIS 
  /VARIABLES=gender 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

* Independent samples t-test (Gender)

T-TEST GROUPS=gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=nps risk_appetite investor_type holding_period sustainability_preference hurdle_rate
    sustainability_returns
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Independent samples t-test (Generation)

T-TEST GROUPS=d_generation_older(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=nps risk_appetite investor_type holding_period sustainability_preference hurdle_rate
    sustainability_returns
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Independent samples t-test (Holding Period)

T-TEST GROUPS=d_holding_period_long(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=nps risk_appetite investor_type holding_period sustainability_preference hurdle_rate
    sustainability_returns
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Independent samples t-test (Professional)

T-TEST GROUPS=d_investor_type_pro(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=nps risk_appetite investor_type holding_period sustainability_preference hurdle_rate
    sustainability_returns
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Independent samples t-test (Sustainability Preferred)
    Those who prefer sustainable investments also expect higher returns from them

T-TEST GROUPS=d_sustainability_preferred(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=nps risk_appetite investor_type holding_period sustainability_preference hurdle_rate
    sustainability_returns
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

T-TEST GROUPS=d_risk_appetite_high(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=nps risk_appetite investor_type holding_period sustainability_preference hurdle_rate
    sustainability_returns
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* APA formatting
    
OUTPUT MODIFY
  /SELECT TABLES
  /IF COMMANDS=["Frequencies(LAST)"] SUBTYPES="Frequencies"
  /TABLECELLS SELECT=[VALIDPERCENT CUMULATIVEPERCENT] APPLYTO=COLUMN HIDE=YES
  /TABLECELLS SELECT=[TOTAL] SELECTCONDITION=PARENT(VALID MISSING) APPLYTO=ROW HIDE=YES
  /TABLECELLS SELECT=[VALID] APPLYTO=ROWHEADER UNGROUP=YES
  /TABLECELLS SELECT=[PERCENT] SELECTDIMENSION=COLUMNS FORMAT="PCT" APPLYTO=COLUMN
  /TABLECELLS SELECT=[COUNT] APPLYTO=COLUMNHEADER REPLACE="N"
  /TABLECELLS SELECT=[PERCENT] APPLYTO=COLUMNHEADER REPLACE="%".

* Sustainable Development Goals (SDG) histogram

MRSETS
  /MDGROUP NAME=$sdgs LABEL='UN Sustainable Development Goals (SDGs)' CATEGORYLABELS=VARLABELS
    VARIABLES=sdg1 sdg2 sdg3 sdg4 sdg5 sdg6 sdg7 sdg8 sdg9 sdg10 sdg11 sdg12 sdg13 sdg14 sdg15 sdg16
    sdg17 VALUE=1
  /DISPLAY NAME=[$sdgs].

CTABLES 
  /VLABELS VARIABLES=$sdgs DISPLAY=LABEL 
  /TABLE $sdgs [COUNT F40.0] 
  /CATEGORIES VARIABLES=$sdgs ORDER=D KEY=COUNT EMPTY=INCLUDE 
  /CRITERIA CILEVEL=95.

