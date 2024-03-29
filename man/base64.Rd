% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base64.R
\name{base64}
\alias{base64}
\alias{base64_dec}
\alias{base64_enc}
\alias{base64url_enc}
\alias{base64url_dec}
\title{Encode/decode base64}
\usage{
base64_dec(input)

base64_enc(input)

base64url_enc(input)

base64url_dec(input)
}
\arguments{
\item{input}{string or raw vector to be encoded/decoded}
}
\description{
Simple in-memory base64 encoder and decoder. Used internally for converting
raw vectors to text. Interchangeable with encoder from \code{base64enc} or
\code{openssl} package.
}
\details{
The \link{base64url_enc} and \link{base64url_dec} functions use a variation of base64
that substitute characters \verb{+/}  for \verb{-_} respectively, such that the output
does not require URL-encoding. See also section 5 of rfc4648.
}
\examples{
str <- base64_enc(serialize(iris, NULL))
out <- unserialize(base64_dec(str))
stopifnot(identical(out, iris))
}
