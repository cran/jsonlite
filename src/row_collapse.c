#include <Rdefines.h>
#include <Rinternals.h>
#include <stdlib.h>

SEXP C_collapse_object(SEXP x, SEXP y);
SEXP C_collapse_array(SEXP x);
SEXP C_collapse_array_pretty_inner(SEXP x, SEXP indent);
SEXP C_collapse_object_pretty(SEXP x, SEXP y, SEXP indent);

SEXP C_row_collapse_object(SEXP names, SEXP m, SEXP indent){
  //get matrix dimensions
  int *dims = INTEGER(getAttrib(m, install("dim")));
  int x = dims[0];
  int y = dims[1];

  //allocate the output vector
  SEXP out = PROTECT(allocVector(STRSXP, x));
  SEXP vec = PROTECT(allocVector(STRSXP, y));
  for(int i = 0; i < x; i++) {
    for(int j = 0; j < y; j++) {
      SET_STRING_ELT(vec, j, STRING_ELT(m, j*x + i));
    }
    if(asInteger(indent) == NA_INTEGER){
      SET_STRING_ELT(out, i, asChar(C_collapse_object(names, vec)));
    } else {
      SET_STRING_ELT(out, i, asChar(C_collapse_object_pretty(names, vec, indent)));
    }
  }
  UNPROTECT(2);
  return out;
}


SEXP C_row_collapse_array(SEXP m, SEXP indent){
  //get matrix dimensions
  int *dims = INTEGER(getAttrib(m, install("dim")));
  int x = dims[0];
  int y = dims[1];

  //allocate the output vector
  SEXP out = PROTECT(allocVector(STRSXP, x));
  SEXP vec = PROTECT(allocVector(STRSXP, y));
  for(int i = 0; i < x; i++) {
    for(int j = 0; j < y; j++) {
      SET_STRING_ELT(vec, j, STRING_ELT(m, j*x + i));
    }
    if(asInteger(indent) == NA_INTEGER){
      SET_STRING_ELT(out, i, asChar(C_collapse_array(vec)));
    } else {
      SET_STRING_ELT(out, i, asChar(C_collapse_array_pretty_inner(vec, indent)));
    }
  }
  UNPROTECT(2);
  return out;
}
