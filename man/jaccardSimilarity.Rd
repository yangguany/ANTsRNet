% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ssdUtilities.R
\name{jaccardSimilarity}
\alias{jaccardSimilarity}
\title{Jaccard similarity between two sets of boxes.}
\usage{
jaccardSimilarity(boxes1, boxes2)
}
\arguments{
\item{boxes1}{A 2-D array where each row corresponds to a single box
consisting of the format (xmin,xmax,ymin,ymax) or
(xmin,xmax,ymin,ymax,zmin,zmax)}

\item{boxes2}{A 2-D array where each row corresponds to a single box
consisting of the format (xmin,xmax,ymin,ymax) or
(xmin,xmax,ymin,ymax,zmin,zmax)}
}
\value{
the Jaccard simliarity
}
\description{
Function for determinining the Jaccard or iou (intersection over union)
similarity measure between two sets of boxes.
}
\author{
Tustison NJ
}
