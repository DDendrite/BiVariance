# Bi-Metrics 🚲
 
> *"Are you straight or gay?"*
> *"Hold on, let me get my data."*
 
---
 
## Introduction
 
The "bi-cycle" is a phenomenon widely discussed in bisexual and queer communities: the way attraction to people of different genders tends to shift and fluctuate over time. For many bisexuals, these fluctuations can fuel insecurity — doubt about whether they are "really bisexual", anxiety in relationships, or the feeling that their sexuality doesn't match up with what they (or others) expect it to look like on any given day.
 
Despite being a common topic of conversation in online and offline queer spaces, the bi-cycle has received little formal academic attention. This project is an attempt to change that — or at least to kickstart the conversation about how it *could* be studied rigorously.
 
This repository contains all materials needed to start measuring your own bi-cycle as well as some material. It includes the daily diary dataset collected by the author, R scripts for structural equation modelling (SEM), a Shiny app for interactive SEM exploration, and a html-based tracker others can use to collect their own data.
 
---
 
## Background
 
Being bisexual isn't necessarily easy with the bigotry we face and varying attractions associated with what some call the "bi-cycle" doesn't make it much easier. Single bisexuals sometimes experience doubt about their sexuality when their attraction at a given moment doesn't match their expectations — or those of the people around them. Bisexuals in relationships face a different but related challenge: the fear (and the fear others have) that fluctuating attraction compromises commitment. These anxieties are well-documented in community discourse, and the bi-cycle is a central concept in making sense of them.
 
Measuring something like the bi-cycle is not straightforward. Attraction is unobservable. It is, in the language of statistics, a **latent variable** — something real and consequential, but not directly measurable. You can only get at it through the things it produces: feelings, fantasies, the way a stranger across a café might catch your eye. This makes it a natural candidate for **structural equation modelling (SEM)**, a family of multivariate statistical techniques designed precisely for situations where the variables you care about most are the ones you can't directly observe.
 
This project uses SEM — alongside daily diary data, confirmatory factor analysis, path analysis and MIMIC models to explore how attraction can be formally measured, and to look at what drives its fluctuations over time.
 
---
 
## The Project
 
### How It Started
 
It started, as many things do, with memes on Reddit. After finding the r/bisexual subreddit and recognizing the bi-cycle in its memes and discussions, tracking seemed like a funny idea. Over time, patterns seemed to emerge. Those patterns became hypotheses; those hypotheses became this project.
 
This is an independent, personal project. The author is not a psychologist or social scientist — they are a chemist who fell down a statistical rabbit hole and found it unexpectedly affirming. All tools used are free and open-source, and everything is shared here so that others can replicate, critique, and maybe even add to it. 
 
### Tracking
 
Data was collected via a daily diary method over approximately three years (2023–2025), yielding ~1,096 observations. Each day, the following was recorded:
 
- **Day of week** and **activity context** (work, gym, social, education, inactive, other)
- **Attraction, fantasy, lust, romantic interest and sexual activity** directed toward people of three gender categories: men (M), androgynous people (whatever their identity) (X), and women (F)
 
All variables are recorded as binary or ordinal indicators. This structure supports the use of polychoric correlations and weighted least squares estimation in SEM.
 
### Analysing Using SEM
 
The core analysis uses the `lavaan` package in R. The measurement model specifies three latent variables — **Attraction**, **Fantasy**, and **Lust** — each indicated by gender-specific observed items. The structural model then examines how daily context (work, gym, social activities, etc.) predicts these latent constructs, and how the constructs relate to each other.
 
A **MIMIC model** (Multiple Indicators, Multiple Causes) framework is also used to examine how background variables influence the latent factors while accounting for measurement error.
 
### Simulation Study
 
Because the estimation of SEM models can be challenging and often results in errors, a tiny simulation study was performed to find minimum number of days that needs to be tracked for estimated
 
### Tracker [still in development]
 
A web-based HTML tracker is included so that others can collect their own daily diary data in the same format. The tracker runs entirely in the browser — no installation required — and allows users to export their data as a CSV file compatible with the R scripts and Shiny app provided here.
 
### SEM App [still in development]
 
An interactive R Shiny application allows users to import their own CSV data and run the full SEM pipeline without writing any code. The app includes:
 
- **Descriptive statistics** — stacked proportional bar charts of attraction by gender, displayed in bi flag colours (pink, purple, blue)
- **MIMIC model** — a three factor MIMIC model with five in-built predictors and the ability to add your own
- **Full results** — structural estimates, fit measures, and residuals
- **Calendar view** — a day-by-day heatmap of gender-bias scores in bi flag colours
- **CSV downloads** — parameter estimates, fit measures, and model coefficients
 
The app ships with embedded example data (2023–2025) so it can be explored immediately without uploading anything.
 
### Essay [in progress]

An essay documenting the intricacies of the project and its results in more detail.

---
 
## Contents of the Repository
 
```
BiVariance/
│
NEEDS TO BE UPDATED ONCE DONE

```

### R Scripts
 
Standalone scripts with various analyses. Loads `lavaan`, reads the CSV, casts all variables as ordered factors, specifies and fits the model using WLSMV, and exports parameter estimates, coefficients, fit measures, and residuals to CSV.
 
### Shiny app which does the same under the hood [still in development]

Shiny application. Requires `shiny`, `lavaan`, `DT`, `shinythemes`, and `semPlot`. Launches a full interactive interface with data upload, visualisation, SEM output, and download options.
 
### Tracker [still in development]
 
`bicyle_tracker_final.html` — a self-contained browser-based tracker. Open it in any modern browser to start logging daily data. No server or installation required. Data can be exported as CSV for use with the scripts and app above.
 
### Data

- The original dataset that started this project and was used to further develop it. 
- Simulation data used to determine the minimum number of observations needed to analyse this yourself.

---
 
## Installation
 
### R and RStudio
 
Download and install [R](https://cran.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/) (free).
 
### Download the package

Download the package and extract it to a desired location.

### Prerequisites: installing required packages
 
Run the "Prerequisites" script and choose which packages you do and don't need for your purposes.
 
### Running the SEM script

Simply open the scripts from the folder with Rstudio.
 
### Running the Shiny app [still in development]
 
Same as the scripts. The app will open in your browser. You can use the embedded example data immediately, or upload your own CSV exported from the tracker.
 
### Using the tracker [still in development]
 
Open the tracker in any modern browser (Chrome, Firefox, Safari, Edge). No installation or internet connection required. Your data is stored locally in your browser until you export it.
 
---
 
## Notes on the data and methods
 
A few things worth keeping in mind:
 
- **Data collected by a person is specific to them ,it is not possible to draw conclusions from that data about bisexuals in general.** 
- **The analyses are exploratory and proof-of-concept in nature**; no claims are made about bisexuals in general.
- **Self-report limitations apply.** Daily diary data is subject to recall bias, mood effects, and the general messiness of asking someone to quantify something as slippery as attraction.
- **The measurement model is theory-driven but not validated on an independent sample.** The Monte Carlo study addresses robustness, but external validation awaits future research.
- **Gender categories.** The three gender categories used (M, X, F) are a practical simplification. Be aware that gender is more complex than this, and that different bisexuals will parse their attractions differently. Nobody owes you a specific gender presentation or pattern of attraction.
 
---
 
## Acknowledgements
 
This project draws on community knowledge from the r/bisexual subreddit and wider bi/queer online spaces, as well as the published literature on bisexual identity, measurement of sexual orientation, and structural equation modelling. All software used is free and open-source. A full bibliography is available in the accompanying essay.
 
---
 
## Licence

GNU Public License Version 3
 
---
 
*"The only relationships I've successfully maintained are within this dataset."*
Under construction
