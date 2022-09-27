# Sustainable Venture Capital

Permanent archive (**arXiv**): https://arxiv.org/abs/2209.10518

## Cover Page

> [Samuel James Johnston](https://samjohnston.org) <[samj@samj.net](mailto:samj@samj.net)>
> [S P Jain School of Global Management](https://spjain.org)
> 
> This dissertation is submitted for the degree of
> **Master of Business Administration (Executive)**
> *Specialisation in Finance*
> 2022

## Abstract
Sustainability initiatives are set to benefit greatly from the growing involvement of venture capital, in the same way that other technological endeavours have been enabled and accelerated in the post-war period. With the spoils increasingly being shared between shareholders and other stakeholders, this requires a more nuanced view than the finance-first methodologies deployed to date. Indeed, it is possible for a venture-backed sustainability startup to deliver outstanding results to society in general without returning a cent to investors, though the most promising outcomes deliver profit with purpose, satisfying all stakeholders in ways that make existing 'extractive' venture capital seem hollow.

To explore this nascent area, a review of related research was conducted and social entrepreneurs & investors interviewed to construct a questionnaire assessing the interests and intentions of current & future ecosystem participants. Analysis of 114 responses received via several sampling methods revealed statistically significant relationships between investing preferences and genders, generations, sophistication, and other variables, all the way down to the level of individual UN Sustainable Development Goals (SDGs).

## Metadata

| Variable | Value |
| :------- | :---- |
| Date: | May 7, 2022 |
| Comments: | Masters thesis. 114 pages, 18 figures |
| Subjects:	| **Computers and Society (cs.CY)**; General Economics (econ.GN) |
| ACM classes: | K.1; K.4.1; K.5.2 |
| Cite as: | [arXiv:2209.10518](https://arxiv.org/abs/2209.10518) [**cs.CY**] (or [arXiv:2209.10518v1](https://arxiv.org/abs/2209.10518v1) [**cs.CY**] for this version) |
| DOI: | https://doi.org/10.48550/arXiv.2209.10518 (arXiv-issued DOI via [DataCite](https://datacite.org)) |
| License: | Creative Commons Attribution-ShareAlike 4.0 International ([CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)) |

## Code

### Database

A company database ([Crunchbase](https://crunchbase.com)) was used to examine the state of the industry, however the data itself is subject to proprietary licenses and cannot be shared.

1. [database/recode.sps](database/recode.sps): This SPSS Syntax was used to recode the data from the company database (Crunchbase), exported as CSV.
1. [database/analysis.sps](database/analysis.sps): This SPSS Syntax was used to automatically execute the analysis itself, such that the survey data could be periodically updated as new responses were submitted.

### Survey

[IBM SPSS](https://www.ibm.com/sg-en/analytics/spss-statistics-software) 28.0.1.1 was used for the analytics of survey data collected using Typeform.

1. [survey/recode.sps](survey/recode.sps): This SPSS Syntax was used to recode the data received from the survey tool (Typeform), exported as Microsoft Excel and/or transmitted to Google Workspace. The exported Excel file may need to be opened and saved in Excel to avoid an SPSS error [“(2003) All sheets in Excel file appear to be empty.”].
1. [survey/analysis.sps](survey/analysis.sps): This SPSS Syntax was used to automatically execute the analysis itself, such that the survey data could be periodically updated as new responses were submitted.
