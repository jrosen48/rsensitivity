% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkonfound.R
\name{pkonfound}
\alias{pkonfound}
\title{Perform sensitivity analysis for published studies}
\usage{
pkonfound(
  est_eff,
  std_err,
  n_obs,
  n_covariates = 1,
  alpha = 0.05,
  tails = 2,
  index = "RIR",
  nu = 0,
  n_treat = NULL,
  switch_trm = TRUE,
  model_type = "ols",
  a = NULL,
  b = NULL,
  c = NULL,
  d = NULL,
  two_by_two_table = NULL,
  test = "fisher",
  replace = "control",
  to_return = "print"
)
}
\arguments{
\item{est_eff}{the estimated effect (such as an unstandardized beta coefficient or a group mean difference)}

\item{std_err}{the standard error of the estimate of the unstandardized regression coefficient}

\item{n_obs}{the number of observations in the sample}

\item{n_covariates}{the number of covariates in the regression model}

\item{alpha}{probability of rejecting the null hypothesis (defaults to 0.05)}

\item{tails}{integer whether hypothesis testing is one-tailed (1) or two-tailed (2; defaults to 2)}

\item{index}{whether output is RIR or IT (impact threshold); defaults to "RIR"}

\item{nu}{what hypothesis to be tested; defaults to testing whether est_eff is significantly different from 0}

\item{n_treat}{the number of cases associated with the treatment condition; applicable only when model_type = "logistic"}

\item{switch_trm}{whether to switch the treatment and control cases; defaults to FALSE; applicable only when model_type = "logistic"}

\item{model_type}{the type of model being estimated; defaults to "ols" for a linear regression model; the other option is "logistic"}

\item{a}{cell is the number of cases in the control group showing unsuccessful results}

\item{b}{cell is the number of cases in the control group showing successful results}

\item{c}{cell is the number of cases in the treatment group showing unsuccessful results}

\item{d}{cell is the number of cases in the treatment group showing successful results}

\item{two_by_two_table}{table that is a matrix or can be coerced to one (data.frame, tibble, tribble) from which the a, b, c, and d arguments can be extracted}

\item{test}{whether using Fisher's Exact Test or A chi-square test; defaults to Fisher's Exact Test}

\item{replace}{whether using entire sample or the control group to calculate the base rate; default is the entire sample}

\item{to_return}{whether to return a data.frame (by specifying this argument to equal "raw_output" for use in other analyses) or a plot ("plot"); default is to print ("print") the output to the console; can specify a vector of output to return}
}
\value{
prints the bias and the number of cases that would have to be replaced with cases for which there is no effect to invalidate the inference
}
\description{
For published studies, this command calculates (1) how much bias there must be in an estimate to invalidate/sustain an inference; (2) the impact of an omitted variable necessary to invalidate/sustain an inference for a regression coefficient.
}
\examples{
# using pkonfound for linear models
pkonfound(2, .4, 100, 3)
pkonfound(-2.2, .65, 200, 3)
pkonfound(.5, 3, 200, 3)
pkonfound(-0.2, 0.103, 20888, 3, n_treat = 17888, model_type = "logistic")

pkonfound(2, .4, 100, 3, to_return = "thresh_plot")
pkonfound(2, .4, 100, 3, to_return = "corr_plot")

pkonfound_output <- pkonfound(2, .4, 200, 3,
  to_return = c("raw_output", "thresh_plot", "corr_plot")
)
summary(pkonfound_output)
pkonfound_output$raw_output
pkonfound_output$thresh_plot
pkonfound_output$corr_plot

# using pkonfound for a 2x2 table
pkonfound(a = 35, b = 17, c = 17, d = 38)
pkonfound(a = 35, b = 17, c = 17, d = 38, alpha = 0.01)
pkonfound(a = 35, b = 17, c = 17, d = 38, alpha = 0.01, switch_trm = FALSE)
pkonfound(a = 35, b = 17, c = 17, d = 38, test = "chisq")


}
