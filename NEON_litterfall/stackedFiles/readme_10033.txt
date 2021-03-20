###################################
########### Disclaimer ############
This is the most recent readme publication based on all site-date combinations used during stackByTable.
Information specific to the query, including sites and dates, has been removed. The remaining content reflects general metadata for the data product.
All files used during stacking are listed at the bottom of this document, which includes the data publication dates.
##################################

This data package been produced by and downloaded from the National Ecological Observatory Network, managed cooperatively by Battelle. These data are provided under the terms of the NEON data policy at http://data.neonscience.org/data-policy. 

DATA PRODUCT INFORMATION
------------------------

ID: NEON.DOM.SITE.DP1.10033.001

Name: Litterfall and fine woody debris production and chemistry

Description: Dry weight of litterfall and fine woody debris collected from elevated and ground traps, sorted to functional group, as well as periodic measurements of litter chemistry and stable isotopes.

NEON Science Team Supplier: TOS

Abstract: This data product contains the quality-controlled, native sampling resolution data from NEON's Litterfall and fine woody debris sampling. Litter is defined as material that is dropped from the forest canopy and has a butt end diameter <2cm and a length <50 cm; this material is collected in elevated 0.5m2 PVC traps. Fine woody debris is defined as material that is dropped from the forest canopy and has a butt end diameter <2cm and a length >50 cm; this material is collected in ground traps as longer material is not reliably collected by the elevated traps. Following field collection, each sample is sorted by functional group, dried and weighed. After sorting litter by functional group, needles and leaves from elevated traps from select bouts are sent for chemical analysis, with excess material archived in the NEON Biorepository and available upon request. For additional details, see the user guides, protocols, and science design listed in the Documentation section below. Products resulting from this sampling include mass of litterfall and fine woody debris by functional group as well as litter chemistry and stable isotope ratios. Summary tables of external lab precision and accuracy are included in the expanded package.

Latency:
The expected time from data and/or sample collection in the field to data publication is as follows, for each of the data tables (in days) in the downloaded data package. See the Data Product User Guides for more information.

bgc\_CNiso\_externalSummary: 30

lig_externalSummary: 30

ltr_chemistrySubsampling: 60

ltr_fielddata: 60

ltr_litterCarbonNitrogen: 270

ltr_litterLignin: 180

ltr_massdata: 60

ltr_pertrap: 30

Brief Design Description: Each qualifying tower plot in forested ecosystems has 0-2 elevated traps and 1-2 ground traps deployed. Ground traps are sampled annually. Sampling interval of elevated litter traps is variable by dominant overstory vegetation. Deciduous forests are sampled once in the spring then multiple times during fall senescence; evergreen and coniferous forests are sampled year round at monthly intervals. Traps are consistent with those used by the Smithsonian Center for Tropical Forest Science (CTFS). Mass data for each collection event are measured separately for functional groups: Leaves, Needles, Twigs/branches, Woody material, Seeds, Flowers and other non-woody reproductive structures, Other, and Mixed (unsorted). Once every five years, leaf and needle samples from elevated traps from a single collection event are analyzed for carbon and nitrogen concentrations and stable isotopes as well as lignin concentrations.

Brief Study Area Description: These data are collected at NEON terrestrial sites with overstory vegetation.

Keywords: fine woody debris, plant productivity, production, turnover, detritus, biomass, senescent, carbon cycle, net primary productivity (NPP), vegetation, litterfall, leaves, litter, gross primary productivity (GPP)


DATA PACKAGE CONTENTS
---------------------

This data product contains up to 8 data tables:

ltr_fielddata - Field collection details and sample tracking
ltr_chemistrySubsampling - Identifiers for subsamples created for chemical analyses or archive
ltr_massdata - Dry mass of litter and fine woody debris components per trap per bout
ltr_pertrap - Record of trap establishment, contains date, trap type and location
ltr_litterCarbonNitrogen - External lab analysis of carbon and nitrogen concentrations in litter
ltr_litterLignin - External lab analysis of lignin concentrations in litter
bgc_CNiso_externalSummary - Long-term uncertainty values for analysis of carbon and nitrogen concentrations and stable isotopes
lig_externalSummary - Long-term uncertainty values for lignin analysis in plant tissue
If data are unavailable for the particular sites and dates queried, some tables may be absent.
Basic download package definition: The basic data package includes the primary measurements.

Expanded download package definition: The expanded data package contains all the basic package data, plus additional tables containing analytical laboratory precision and accuracy.

FILE NAMING CONVENTIONS
-----------------------

NEON data files are named using a series of component abbreviations separated by periods. File naming conventions for NEON data files differ between NEON science teams. A file will have the same name whether it is accessed via the data portal or the API.

NEON observational systems (OS) data files: NEON.DOM.SITE.DPL.PRNUM.REV.DESC.YYYY-MM.PKGTYPE.GENTIME.csv

The definitions of component abbreviations are below. See NEON.DOC.002651: NEON Data Product Numbering Convention, located at http://data.neonscience.org/documents for more information.

General conventions, used for all data products:
   NEON: denotes the organizational origin of the data product and identifies the product as operational; data collected as part of a special data collection exercise are designated by a separate, unique alphanumeric code created by the PI.

   DOM: a three-character alphanumeric code, referring to the domain of data acquisition (D01 - D20).

   SITE: a four-character alphanumeric code, referring to the site of data acquisition; all sites are designated by a standardized four-character alphabetic code.

   DPL: a three-character alphanumeric code, referring to data product processing level;

   PRNUM: a five-character numeric code, referring to the data product number (see the Data Product Catalog at http://data.neonscience.org/data-product-catalog).

   REV: a three-digit designation, referring to the revision number of the data product. The REV value is incremented by 1 each time a major change is made in instrumentation, data collection protocol, or data processing such that data from the preceding revision is not directly comparable to the new.

   HOR: a three-character designation, referring to measurement locations within one horizontal plane. For example, if five surface measurements were taken, one at each of the five soil array plots, the number in the HOR field would range from 001-005. 

   VER: a three-character designation, referring to measurement locations within one vertical plane. For example, if eight air temperature measurements are collected, one at each tower vertical level, the number in the VER field would range from 010-080. If five soil temperature measurements are collected below the soil surface, the number in the VER field would range from 501-505. 

   TMI: a three-character designation, referring to the temporal representation, averaging period, or coverage of the data product (e.g., minute, hour, month, year, sub-hourly, day, lunar month, single instance, seasonal, annual, multi-annual). 000 = native resolution, 001 = native resolution (variable or regular) or 1 minute, 002 = 2 minute, 005 = 5 minute, 015 = 15 minute, 030 = 30 minute, 060 = 60 minutes or 1 hour, 100 = approximately once per minute at stream sites and once every 5-10 minutes at buoy sites (lakes/rivers), 101-103 = native resolution of replicate sensor 1, 2, and 3 respectively, 999 = Sensor conducts measurements at varied interval depending on air mass, 01D = 1 day, 01M = 1 month, 01Y = 1 year.

   DESC: an abbreviated description of the data file or table.

   YYYY-MM: the year and month of the data in the file.

   PKGTYPE: the type of data package downloaded. Options are 'basic', representing the basic download package, or 'expanded',representing the expanded download package (see more information below).

   GENTIME: the date-time stamp when the file was generated, in UTC. The format of the date-time stamp is YYYYMMDDTHHmmSSZ.

Time stamp conventions:
   YYYY: Year
   YY: Year, last two digits only
   MM: Month: 01-12
   DD: Day: 01-31
   T: Indicator that the time stamp is beginning
   HH: Hours: 00-23
   mm: Minutes: 00-59
   SS: Seconds: 00-59
   Z: Universal Time Coordinated (Universal Coordinated Time), or UTC

ADDITIONAL INFORMATION
----------------------

Data products that are a source of this data product:

Data products that are derived from this data product:

Other related data products (by sensor, protocol, or variable measured):
NEON.DOM.SITE.DP1.10031.001, Litter chemical properties
NEON.DOM.SITE.DP1.10101.001, Litter stable isotopes

Obfuscation of Personnel Information: At times it is important to know which data were collected by particular observers. In order to protect privacy of NEON technicians while also providing a way to consistently identify different observers, we obfuscate each NEON personnel name by internally linking it to a unique string identifier (e.g., Jane Doe=ByrziN0LguMJHnInl2NM/trZeA5h+c0) and publishing only the identifier.

CHANGE LOG
----------

Issue Date: 2020-11-19
Issue: Safety measures to protect personnel during the COVID-19 pandemic resulted in reduced or eliminated sampling activities for extended periods at NEON sites. Data availability may be reduced during this time.
       Date Range: 2020-03-23 to 2021-06-01
       Location(s) Affected: All
Resolution Date: 
Resolution: 

Issue Date: 2021-02-16
Issue: Severely limited elevated litter trap collection for the 2020 season. Because of extended litter collection periods due to sampling limitations during COVID restrictions, the incidence of litter trap disturbance by resident black bears was unusually high. Over 2 collection bouts (40 traps total), only 5 traps were successfully collected in both bouts. It is not recommended these data be used to calculate productivity for the 2020 sampling year at GRSM.
       Date Range: 2020-01-01 to 2021-01-01
       Location(s) Affected: GRSM
Resolution Date: 2021-02-16
Resolution: 

Issue Date: 2020-12-01
Issue: Due to a miscommunication, samples analyzed for carbon (C) and nitrogen (N) concentrations and stable isotopes were not re-dried prior to weighing and analysis at the external lab. While all NEON litterfall samples are dried at 65C in the domain labs, they are sometimes then stored in paper bags or coin envelopes for weeks to months before being ground, transferred to vials, and shipped. During this time they may accumulate moisture, especially in humid areas. Subsequent testing revealed that %C data are likely underestimated by 1.5-2.5% due to this lack of re-drying prior to analysis. As vegetation samples tend to have high %C (20% - 55%), this bias may have only minor impacts on many analyses, but is something for end users to keep in mind. For the other parameters (%N, C:N, d15N, d13C), testing suggests there were no detectable differences between re-dried samples and originals.
       Date Range: 2016-01-01 to 2020-08-15
       Location(s) Affected: All sites with litterfall chemistry measurements in this date range, with the exception of GUAN and PUUM whose tissues were re-dried for permitting/quarantine reasons.
Resolution Date: 2020-11-10
Resolution: Affected data have been flagged with dataQF = dryingProtocolError in the `ltr_litterCarbonNitrogen` table. For sample analysis dates starting in November 2020, all carbon-nitrogen samples are re-dried at 65C prior to analysis to drive out any residual moisture and improve data accuracy for % C. Samples collected in 2020 may have been analyzed before or after the change; check dataQF to determine which individual samples are affected.

Issue Date: 2020-10-02
Issue: Until October 2020, litter biomass, chemistry, and stable isotopes were published as separate data products.
       Date Range: 2016-01-01 to 2020-10-06
       Location(s) Affected: All terrestrial sites.
Resolution Date: 2020-10-06
Resolution: In October 2020, data tables for chemistry and isotopes were bundled with the sampling and biomass data tables in a single data product for improved usability. This applies to all existing and future data.

Issue Date: 2020-01-01
Issue: Discontinued litterfall sampling as some plots.
       Date Range: 2016-01-01 to 2020-01-01
       Location(s) Affected: D01-BART, D01-HARV, D02-SCBI, D02-SERC, D03-JERC, D05-TREE, D05-UNDE, D07-GRSM, D07-ORNL, D08-TALL
Resolution Date: 2020-06-08
Resolution: In January 2020, litter traps were removed from a subset of plots at sites where data analyses indicated reliable site level estimates of litter production were possible with a reduced number of plots. Plots to continue sampling for litterfall were selected to maintain spatial balance across the Tower airshed. In June 2020, plot selection at these sites was revised to prioritize stratification across vegetation types.

ADDITIONAL REMARKS
------------------

Queries for this data product will return data from all dates for `ltr_pertrap` (which may be established many years before a litter collection event), whereas the other tables will be subset to data collected during the date range specified. The protocol dictates that each trap is established once (one expected record per `ltr_pertrap.trapID`). A record from `ltr_pertrap` may have zero or more child records in `ltr_fielddata.trapID`, depending on the date range of the data downloaded; a given `ltr_fielddata.trapID` is expected to be sampled zero or one times per collectDate (local time). A record from `ltr_fielddata` may have zero (if no litter collected) or more child records in `ltr_massdata` depending on the functional groups contained in the trap and whether reweighing occurred for QA purposes. A record from `ltr_massdata` may have zero (if not sent for chemistry analyses) or one child record in `ltr_chemistrySubsampling`. Chemistry subsamples may appear one or more times in `ltr_litterCarbonNitrogen` and `ltr_litterLignin`, depending on whether analytical replicates were conducted or if C and N were analyzed separately. Duplicates may exist where protocol and/or data entry aberrations have occurred; users should check carefully for anomalies before joining tables.

NEON DATA POLICY AND CITATION GUIDELINES
----------------------------------------

Please visit http://data.neonscience.org/data-policy for more information about NEON's data policy and citation guidelines.

DATA QUALITY AND VERSIONING
---------------------------

The data contained in this file are considered provisional. Updates to the data, QA/QC and/or processing algorithms over time will occur on an as-needed basis.  Please check back to this site for updates tracked in change logs.  Query reproducibility on provisional data cannot be guaranteed. 
 
Starting in 2020 or earlier, NEON will begin to offer static versions of each data product, annotated with a globally unique identifier. Versioned IS and OS data will be produced by reprocessing each IS and OS data product from the beginning of the data collection period to approximately 12-18 months prior to the reprocessing date (to allow for calibration checks, return of external lab data, etc.). The reprocessing step will use the most recent QA/QC methods and processing algorithms. Versioned AOP data will be produced by reprocessing the entire AOP archive as advances in algorithms and processing technology are incorporated. This will typically occur in the northern winter months, between flight season peaks, and will be on the order of every 3 to 5 years in frequency.

POST STACKING README DOCUMENTATION
----------------------------------

Each row contains the readme filename used during stackByTable

NEON.D02.SERC.DP1.10033.001.readme.20210123T023002Z.txt
NEON.D02.SERC.DP1.10033.001.readme.20210308T211740Z.txt
NEON.D02.SERC.DP1.10033.001.readme.20210308T212134Z.txt
NEON.D02.SERC.DP1.10033.001.readme.20210308T212011Z.txt
NEON.D02.SERC.DP1.10033.001.readme.20210308T214426Z.txt
