* Encoding: UTF-8.

* Dichotomised variables start with "d_"

* Q1 type_of_investor: What type of investor are you?
  This allows classification of investors by level of sophistication

recode Whattypeofinvestorareyou
    ("I don't invest" = 0)
    ('Inactive (e.g., pension)' = 1)
    ('Retail (e.g. shares)'=2)
    ('Accredited (e.g., $1m assets/$200k income)'=3)
    ('Qualified (e.g., $5m investments)'=4)
    ('Institutional (e.g., corporate, pension)'=5)
    (else=6)
    into investor_type.
 execute.

value labels investor_type
    0 "I don't invest"
    1 'Inactive (e.g., pension)'
    2 'Retail (e.g., shares)'
    3 'Accredited (e.g., $1m assets/$200k income)'
    4 'Qualified (e.g., $5m investments)'
    5 'Institutional (e.g., corporate, pension)'
    6 'Others'.

delete variables Whattypeofinvestorareyou.

variable labels investor_type 'What type of investor are you?'.
formats investor_type(f2.0).
variable level investor_type (ordinal).
execute.

* Advanced investing scenarios => Accredited (e.g., $1m assets/$200k income)

if (Other = 'Active Startup investor owner') investor_type = 3.
if (Other = 'managed fund') investor_type = 3.
if (Other = 'Crypto') investor_type = 3.
execute.
delete variables Other.

* Create synthetic variables

recode investor_type (3 thru 5=1) (sysmis=sysmis) (else=0) into d_investor_type_pro.
formats d_investor_type_pro(f2.0).
execute.

* Q2 risk_appetite: How would you describe your risk appetite when it comes to your investment portfolio?
  Indicates the level of risk one is willing to accept to achieve the objectives for this type of investment.

recode Howwouldyoudescribeyourriskappetitewhenitcomestoyourinvestmentpo
    ('Very high' = 5)
    ('High' = 4)
    ('Neutral' = 3)
    ('Low' = 2)
    ('Very low' = 1)
    into risk_appetite.
 execute.

value labels risk_appetite
     5 'Very high'
     4 'High'
     3 'Neutral'
     2 'Low'
     1 'Very low'.

delete variables Howwouldyoudescribeyourriskappetitewhenitcomestoyourinvestmentpo.

variable labels risk_appetite 'How would you describe your risk appetite when it comes to your investment portfolio?'.
formats risk_appetite(f2.0).
variable level risk_appetite (ordinal).
execute.

recode risk_appetite (4 thru 5=1) (sysmis=sysmis) (else=0) into d_risk_appetite_high.
formats d_risk_appetite_high(f2.0).
execute.

* Q3 holding_period: How long would you typically hold an investment?
  Looks for investing preferences in relation to short- and longtermism.

recode Howlongwouldyoutypicallyholdaninvestment
    ('Less than 1 year' = 1)
    ('1-5 years' = 2)
    ('6-10 years' = 3)
    ('More than 10 years' = 4)
    into holding_period.
 execute.

value labels holding_period
     1 'Less than 1 year'
     2 '1-5 years'
     3 '6-10 years'
     4 'More than 10 years'.
 execute.

delete variables Howlongwouldyoutypicallyholdaninvestment.

variable labels holding_period 'How long would you typically hold an investment?'.
formats holding_period(f2.0).
variable level holding_period (ordinal).
execute.

recode holding_period (3 thru 4=1) (sysmis=sysmis) (else=0) into d_holding_period_long.
formats d_holding_period_long(f2.0).
execute.

* Q4 If you have one, what is your required rate of return or hurdle rate (%) for investments?
    The minimum annual return you would accept for any investment.

rename variables (Ifyouhaveonewhatisyourrequiredrateofreturnorhurdlerateforinvestm=hurdle_rate).
variable level hurdle_rate (scale).

* Q5 sustainability_preference: How likely are you to prefer a sustainable investment over a traditional investment?
  Assesses preference for sustainable investments over others in market.

* Excel export from Google Docs and/or import sets width to 11 but 'Very unlikely' is 13 - expand field to avoid warning:
    Warning # 4624 in column X: The preceding RECODE specifies a value to be recoded that is longer than some variable(s) in the recode
    The shorter values will be padded with blanks for the comparison. 

recode Howlikelyareyoutopreferasustainableinvestmentoveratraditionalinv
    ('Very unlikely' = 1)
    ('Unlikely' = 2)
    ('Neutral' = 3)
    ('Likely' = 4)
    ('Very likely' = 5)
    into sustainability_preference.
 execute.

value labels sustainability_preference
     1 'Very unlikely'
     2 'Unlikely'
     3 'Neutral'
     4 'Likely'
     5 'Very likely'.

delete variables Howlikelyareyoutopreferasustainableinvestmentoveratraditionalinv.

variable labels sustainability_preference 'How likely are you to prefer a sustainable investment over a traditional investment?'.
formats sustainability_preference(f2.0).
variable level sustainability_preference (ordinal).
execute.

recode sustainability_preference (4 thru 5=1) (sysmis=sysmis) (else=0) into d_sustainability_preferred.
formats d_sustainability_preferred(f2.0).
execute.

* Q6 sustainability_returns: What returns do you expect from a sustainable investment compared to the wider market?
  Determines whether investors anticipate higher or lower returns.

recode Whatreturnsdoyouexpectfromasustainableinvestmentcomparedtothewid
    ('Much lower' = 1)
    ('Somewhat lower' = 2)
    ('Equal' = 3)
    ('Somewhat higher' = 4)
    ('Much higher' = 5)
    into sustainability_returns.
 execute.

value labels sustainability_returns
     1 'Much lower'
     2 'Lower'
     3 'Equal'
     4 'Somewhat higher'
     5 'Much higher'.
 
delete variables Whatreturnsdoyouexpectfromasustainableinvestmentcomparedtothewid.

variable labels sustainability_returns 'What returns do you expect from a sustainable investment compared to the wider market?'.
formats sustainability_returns(f2.0).
variable level sustainability_returns (ordinal).
execute.

* Q7 How likely are you to recommend sustainable investments to others?
    The ultimate question is used to calculate Net Promoter Score (NPS).

rename variables (Howlikelyareyoutorecommendsustainableinvestmentstoothers=nps).
variable level nps (scale).
variable labels nps 'How likely are you to recommend sustainable investments to others?'.

recode nps (0 thru 6=1) (sysmis=sysmis) (else=0) into nps_detractor.
recode nps (7 thru 8=1) (sysmis=sysmis) (else=0) into nps_passive.
recode nps (9 thru 10=1) (sysmis=sysmis) (else=0) into nps_promoter.
recode nps (0 thru 6=-1) (7 thru 8=0) (9 thru 10=1) (sysmis=sysmis) into nps_type.
formats nps_detractor(f2.0).
formats nps_passive(f2.0).
formats nps_promoter(f2.0).
formats nps_type(f2.0).
variable level nps_type (ordinal).
execute.

* Q8 motivation_ranking_1-5: Please rank your motivations for sustainable investment
   Investigates the causation for investors selection of sustainable options
   Split, recode, and label
   Each "," indicates a new answer
   rtrim eats spaces so we add them back in with value labels

string mr1 to mr5 (a50).

string #char(a1).
compute #index = 1.
vector mr = mr1 to mr5.

loop #pos = 1 to char.length(Pleaserankyourmotivationsforsustainableinvestment).
compute #char = char.substr(Pleaserankyourmotivationsforsustainableinvestment,#pos,1).
if(#char <> ",") mr(#index) = concat(rtrim(mr(#index)),#char).
if(#char = ",") #index = #index + 1.
end loop.
execute.

recode mr1 to mr5 (convert)
    ('Environment(e.g.climatechange)' = 1)
    ('Resilience(e.g.reliabilityofreturns)' = 2)
    ('Performance(e.g.outperformingmarket)' = 3)
    ('Legacy(e.g.children''sfutures)' = 4)
    ('Empowerment(e.g.diversity)' = 5)
    into motivation_ranking_1 to motivation_ranking_5.
execute.

 value labels motivation_ranking_1 to motivation_ranking_5
     1 'Environment'
     2 'Resilience'
     3 'Performance'
     4 'Legacy'
     5 'Empowerment'.
 
delete variables Pleaserankyourmotivationsforsustainableinvestment mr1 to mr5.

variable labels
    motivation_ranking_1 'Please rank your motivations for sustainable investment (1/5)'
    motivation_ranking_2 'Please rank your motivations for sustainable investment (2/5)'
    motivation_ranking_3 'Please rank your motivations for sustainable investment (3/5)'
    motivation_ranking_4 'Please rank your motivations for sustainable investment (4/5)'
    motivation_ranking_5 'Please rank your motivations for sustainable investment (5/5)'.    
formats motivation_ranking_1 to motivation_ranking_5(f2.0).
execute.

* Sure this could have been done with a macro
    But then nobody would know what I was thinking
    Not even me
    Especially not me
    But I will say it's inverted because higher scores are better in reports

if(motivation_ranking_1 = 1) rank_environment = 5.
if(motivation_ranking_1 = 2) rank_resilience = 5.
if(motivation_ranking_1 = 3) rank_performance = 5.
if(motivation_ranking_1 = 4) rank_legacy = 5.
if(motivation_ranking_1 = 5) rank_empowerment = 5.
if(motivation_ranking_2 = 1) rank_environment = 4.
if(motivation_ranking_2 = 2) rank_resilience = 4.
if(motivation_ranking_2 = 3) rank_performance = 4.
if(motivation_ranking_2 = 4) rank_legacy = 4.
if(motivation_ranking_2 = 5) rank_empowerment = 4.
if(motivation_ranking_3 = 1) rank_environment = 3.
if(motivation_ranking_3 = 2) rank_resilience = 3.
if(motivation_ranking_3 = 3) rank_performance = 3.
if(motivation_ranking_3 = 4) rank_legacy = 3.
if(motivation_ranking_3 = 5) rank_empowerment = 3.
if(motivation_ranking_4 = 1) rank_environment = 2.
if(motivation_ranking_4 = 2) rank_resilience = 2.
if(motivation_ranking_4 = 3) rank_performance = 2.
if(motivation_ranking_4 = 4) rank_legacy = 2.
if(motivation_ranking_4 = 5) rank_empowerment = 2.
if(motivation_ranking_5 = 1) rank_environment = 1.
if(motivation_ranking_5 = 2) rank_resilience = 1.
if(motivation_ranking_5 = 3) rank_performance = 1.
if(motivation_ranking_5 = 4) rank_legacy = 1.
if(motivation_ranking_5 = 5) rank_empowerment = 1.
formats rank_environment rank_resilience rank_performance rank_legacy rank_empowerment(f2.0).
execute.

* Q9 un_sdg_1-3: Please select your preferred UN Sustainable Development Goals (SDGs) for investment (top 3)
   Identifies priorities for investors in terms of sustainability
   sdg_x: Split, recode, and label
   Each "," indicates a new answer
   rtrim eats spaces so we add them back in with value labels

numeric sdg1 to sdg17 (f2.0).

recode SDG1NoPoverty (convert) (""=0) (else=1) into sdg1.
recode SDG2ZeroHunger (convert) (""=0) (else=1) into sdg2.
recode SDG3GoodHealthandWellBeing (convert) (""=0) (else=1) into sdg3.
recode SDG4QualityEducation (convert) (""=0) (else=1) into sdg4.
recode SDG5GenderEquality (convert) (""=0) (else=1) into sdg5.
recode SDG6CleanWaterandSanitation (convert) (""=0) (else=1) into sdg6.
recode SDG7AffordableandCleanEnergy (convert) (""=0) (else=1) into sdg7.
recode SDG8DecentWorkandEconomicGrowth (convert) (""=0) (else=1) into sdg8.
recode SDG9IndustryInnovationandInfrastructure (convert) (""=0) (else=1) into sdg9.
recode SDG10ReducedInequalities (convert) (""=0) (else=1) into sdg10.
recode SDG11SustainableCitiesandCommunities (convert) (""=0) (else=1) into sdg11.
recode SDG12ResponsibleConsumptionandProduction (convert) (""=0) (else=1) into sdg12.
recode SDG13ClimateAction (convert) (""=0) (else=1) into sdg13.
recode SDG14LifeBelowWater (convert) (""=0) (else=1) into sdg14.
recode SDG15LifeonLand (convert) (""=0) (else=1) into sdg15.
recode SDG16PeaceJusticeandStrongInstitutions (convert) (""=0) (else=1) into sdg16.
recode SDG17PartnershipsfortheGoals (convert) (""=0) (else=1) into sdg17.
execute.

delete variables
    SDG1NoPoverty
    SDG2ZeroHunger
    SDG3GoodHealthandWellBeing
    SDG4QualityEducation
    SDG5GenderEquality
    SDG6CleanWaterandSanitation
    SDG7AffordableandCleanEnergy
    SDG8DecentWorkandEconomicGrowth
    SDG9IndustryInnovationandInfrastructure
    SDG10ReducedInequalities
    SDG11SustainableCitiesandCommunities
    SDG12ResponsibleConsumptionandProduction
    SDG13ClimateAction
    SDG14LifeBelowWater
    SDG15LifeonLand
    SDG16PeaceJusticeandStrongInstitutions
    SDG17PartnershipsfortheGoals.

recode sdg1 to sdg17 (sysmis=0).
execute.

 variable labels
     sdg1 'SDG1: No Poverty'
     sdg2 'SDG2: Zero Hunger'
     sdg3 'SDG3: Good Health and Well-Being'
     sdg4 'SDG4: Quality Education'
     sdg5 'SDG5: Gender Equality'
     sdg6 'SDG6: Clean Water and Sanitation'
     sdg7 'SDG7: Affordable and Clean Energy'
     sdg8 'SDG8: Decent Work and Economic Growth'
     sdg9 'SDG9: Industry, Innovation, and Infrastructure'
     sdg10 'SDG10: Reduced Inequalities'
     sdg11 'SDG11: Sustainable Cities and Communities'
     sdg12 'SDG12: Responsible Consumption and Production'
     sdg13 'SDG13: Climate Action'
     sdg14 'SDG14: Life Below Water'
     sdg15 'SDG15: Life on Land'
     sdg16 'SDG16: Peace, Justice, and Strong Institutions'
     sdg17 'SDG17: Partnerships for the Goals'.
 execute.

* Q10 Where do you live (country)?
    Examines relationships between countries and investing preferences.

* Fix cases first

if(Wheredoyoulivecountry="Botswana") Wheredoyoulivecountry="Germany".

autorecode variables=Wheredoyoulivecountry
    /into country
    /blank=missing
    /print.
execute.
delete variables Wheredoyoulivecountry.
variable labels country 'Where do you live (country)?'.

* Q11 gender: To which gender do you most identify?
  This helps determine investing preference by gender identity.

recode Towhichgenderdoyoumostidentify
    ('Female' = 1)
    ('Male' = 2)
    ('' = sysmis)
    (else = 3)
    into gender.
 execute.

value labels gender
     1 'Female'
     2 'Male'
     3 'Other'.
 
delete variables Towhichgenderdoyoumostidentify.

* No gender and sexual diversity cases :(
    
delete variables Other_A.

variable labels gender 'To which gender do you most identify?'.
formats gender(f2.0).
variable level gender (nominal).
execute.

* Q12 generation: Which generation do you primarily identify with?
  This allows examination of sustainability preferences by age.

recode Whichgenerationdoyouprimarilyidentifywith
    ('Silent Generation (1928-1945)' = 1)
    ('Baby Boomers (1946-1964)' = 2)
    ('Gen X (1965-1979)' = 3)
    ('Gen Y/Millennials (1981-1996)' = 4)
    ('Gen Z (1997-2012)' = 5)
    ('Gen A (2012+)' = 6)
    (else = sysmis)
    into generation.
 execute.

value labels generation
     1 'Silent Generation (1928-1945)'
     2 'Baby Boomers (1946-1964)'
     3 'Gen X (1965-1979)'
     4 'Gen Y/Millennials (1981-1996)'
     5 'Gen Z (1997-2012)'
     6 'Gen A (2012+)'.

delete variables Whichgenerationdoyouprimarilyidentifywith.

variable labels generation 'Which generation do you primarily identify with?'.
formats generation(f2.0).
variable level generation (ordinal).
execute.

* Fix cases: pedants are millennials

if (Other_B = 'Between Gen X and Gen Y (fix your survey)') generation = 4.
execute.
delete variables Other_B.

* Create synthetic variables

recode generation (1 thru 3=1) (4 thru 6=0) (sysmis=sysmis) into d_generation_older.
formats d_generation_older(f2.0).
execute.

* Q13 Please provide contact details for followup with results
    You dont need to provide this but must click through it to submit

* Q13a What is your name?
    So you can be addressed how you prefer

rename variables (Whatisyourname=name).
variable labels name 'Please provide contact details for followup with results'.

* Q13b What's your email?
    This allows for follow-up with survey results

rename variables (Whatsyouremail=email).
variable labels email 'What''s your email?'.
execute.

* Purge personally identifialbe information (PII)

delete variables @# name email StartDateUTC SubmitDateUTC NetworkID.

sort variables by name.

