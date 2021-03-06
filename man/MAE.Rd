% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/superResolutionUtilities.R
\name{MAE}
\alias{MAE}
\title{Mean absolute error of a single image or between two images.}
\usage{
MAE(x, y = NULL)
}
\arguments{
\item{x}{input image.}

\item{y}{input image.}
}
\value{
the mean absolute error
}
\description{
Mean absolute error of a single image or between two images.
}
\examples{

library( ANTsR )

r16 <- antsImageRead( getANTsRData( 'r16' ) )
r85 <- antsImageRead( getANTsRData( 'r85' ) )
maeValue <- MAE( r16, r85 )

}
\author{
Avants BB (from redr)
}
