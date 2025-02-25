% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict_forecast_wrappers.R
\name{predict_ses}
\alias{predict_ses}
\title{Use simple exponential smoothing to forecast data}
\usage{
predict_ses(
  df,
  response,
  ...,
  ret = c("df", "all", "error", "model"),
  scale = NULL,
  probit = FALSE,
  test_col = NULL,
  group_col = "iso3",
  group_models = TRUE,
  obs_filter = NULL,
  sort_col = "year",
  sort_descending = FALSE,
  pred_col = "pred",
  pred_upper_col = "pred_upper",
  pred_lower_col = "pred_lower",
  upper_col = "upper",
  lower_col = "lower",
  filter_na = c("all", "response", "predictors", "none"),
  type_col = NULL,
  types = "projected",
  source_col = NULL,
  source = NULL,
  replace_obs = c("missing", "all", "none")
)
}
\arguments{
\item{df}{Data frame of model data.}

\item{response}{Column name of response variable to be used as the input to the
forecast function.}

\item{...}{Additional arguments passed to the forecast function.}

\item{ret}{Character vector specifying what values the function returns. Defaults
to returning a data frame, but can return a vector of model error, the
model itself or a list with all 3 as components.}

\item{scale}{Either \code{NULL} or a numeric value. If a numeric value is provided,
the response variable is scaled by the value passed to scale prior to model
fitting and prior to any probit transformation, so can be used to put the
response onto a 0 to 1 scale. Scaling is done by dividing the response by
the scale and using the \code{\link[=scale_transform]{scale_transform()}} function. The response, as well
as the fitted values and confidence bounds are unscaled prior to error
calculation and returning to the user.}

\item{probit}{Logical value on whether or not to probit transform the response
prior to model fitting. Probit transformation is performed after any scaling
determined by \code{scale} but prior to model fitting. The response, as well as
the fitted values and confidence bounds are untransformed prior to error
calculation and returning to the user.}

\item{test_col}{Name of logical column specifying which response values to remove
for testing the model's predictive accuracy. If \code{NULL}, ignored. See \code{\link[=model_error]{model_error()}}
for details on the methods and metrics returned.}

\item{group_col}{Column name(s) of group(s) to use in \code{\link[dplyr:group_by]{dplyr::group_by()}} when
supplying type, calculating mean absolute scaled error on data involving
time series, and if \code{group_models}, then fitting and predicting models too.
If \code{NULL}, not used. Defaults to \code{"iso3"}.}

\item{group_models}{Logical, if \code{TRUE}, fits and predicts models individually onto
each \code{group_col}. If \code{FALSE}, a general model is fit across the entire data
frame.}

\item{obs_filter}{String value of the form "\verb{logical operator} \code{integer}"
that specifies the number of observations required to fit the model and
replace observations with predicted values. This is done in
conjunction with \code{group_col}. So, if \code{group_col = "iso3"} and
\code{obs_filter = ">= 5"}, then for this model, predictions will only be used
for \code{iso3} vales that have 5 or more observations. Possible logical operators
to use are \code{>}, \code{>=}, \code{<}, \code{<=}, \code{==}, and \code{!=}.\preformatted{If `group_models = FALSE`, then `obs_filter` is only used to determine when
predicted values replace observed values but **is not** used to restrict values
from being used in model fitting. If `group_models = TRUE`, then a model
is only fit for a group if they meet the `obs_filter` requirements. This provides
speed benefits, particularly when running INLA time series using `predict_inla()`.
}}

\item{sort_col}{Column name of column to arrange data by in \code{dplyr::arrange()},
prior to filtering for latest contiguous time series and producing the
forecast. Not used if \code{NULL}, defaults to \code{"year"}.}

\item{sort_descending}{Logical value on whether the sorted values from \code{sort_col}
should be sorted in descending order. Defaults to \code{FALSE}.}

\item{pred_col}{Column name to store predicted value.}

\item{pred_upper_col}{Column name to store upper bound of confidence interval
generated by the \code{predict_...} function. This stores the full set of generated
values for the upper bound.}

\item{pred_lower_col}{Column name to store lower bound of confidence interval
generated by the \code{predict_...} function. This stores the full set of generated
values for the lower bound.}

\item{upper_col}{Column name that contains upper bound information, including
upper bound of the input data to the model. Values from \code{pred_upper_col}
are put into this column in the exact same way the response is filled by \code{pred}
based on \code{replace_na} (only when there is a missing value in the response).}

\item{lower_col}{Column name that contains lower bound information, including
lower bound of the input data to the model. Values from \code{pred_lower_col}
are put into this column in the exact same way the response is filled by \code{pred}
based on \code{replace_na} (only when there is a missing value in the response).}

\item{filter_na}{Character value specifying how, if at all, to filter \code{NA}
values from the dataset prior to applying the model.  By default, all
observations with missing values are removed, although it can also remove
rows only if they have missing dependent or independent variables, or no
filtering at all.}

\item{type_col}{Column name specifying data type.}

\item{types}{Vector of length 3 that provides the type to provide to data
produced in the model. These values are only used to fill in type values
where the dependent variable is missing. The first value is given to missing
observations that precede the first observation, the second to those after
the last observation, and the third for those following the final observation.}

\item{source_col}{Column name containing source information for the data frame.
If provided, the argument in \code{source} is used to fill in where predictions
have filled in missing data.}

\item{source}{Source to add to missing values.}

\item{replace_obs}{Character value specifying how, if at all, observations should
be replaced by fitted values. Defaults to replacing only missing values,
but can be used to replace all values or none.}
}
\value{
Depending on the value passed to \code{ret}, either a data frame with
predicted data, a vector of errors from \code{\link[=model_error]{model_error()}}, a fitted model, or a list with all 3.
}
\description{
\code{predict_ses()} is a simple wrapper that uses simple exponential smoothing to
forecast data. For details surrounding the model fitting, please see
\code{\link[forecast:ses]{forecast::holt()}} and for more details on the augury function this wraps
around and the various arguments this function accepts, please see \code{\link[=predict_forecast]{predict_forecast()}}.
}
