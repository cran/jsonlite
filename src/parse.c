/*
   This function uses the YAJL tree parser to parse the entire document
   before converting it to an R list. It might be faster to use the YAJL
   callback mechanism instead to construct the R list immediately while
   parsing the JSON. But that looks very complicated.

*/

#include <Rinternals.h>
#include <string.h>
#include <yajl_tree.h>

SEXP ParseObject(yajl_val node);
SEXP ParseArray(yajl_val node);
SEXP ParseValue(yajl_val node);

SEXP R_parse(SEXP x) {
    /* get data from R */
    const char* json = translateCharUTF8(asChar(x));
    yajl_val node;
    char errbuf[1024];

    node = yajl_tree_parse(json, errbuf, sizeof(errbuf));

    /* parse error handling */
    if (!node) {
      error(errbuf);
    }

    return(ParseValue(node));
}

SEXP ParseValue(yajl_val node){
  if(YAJL_IS_NULL(node)){
    return R_NilValue;
  }
  if(YAJL_IS_STRING(node)){
    SEXP tmp = PROTECT(allocVector(STRSXP, 1));
    SET_STRING_ELT(tmp, 0, mkCharCE(YAJL_GET_STRING(node),  CE_UTF8));
    UNPROTECT(1);
    return tmp;
  }
  if(YAJL_IS_INTEGER(node)){
    long long int val = YAJL_GET_INTEGER(node);
    /* see .Machine$integer.max in R */
    if(val > 2147483647 || val < -2147483647){
      return(ScalarReal(val));
    } else {
      return(ScalarInteger(val));
    }
  }
  if(YAJL_IS_DOUBLE(node)){
    return(ScalarReal(YAJL_GET_DOUBLE(node)));
  }
  if(YAJL_IS_NUMBER(node)){
    /* A number that is not int or double (very rare) */
    return(mkString(YAJL_GET_NUMBER(node)));
  }
  if(YAJL_IS_TRUE(node)){
    return(ScalarLogical(1));
  }
  if(YAJL_IS_FALSE(node)){
    return(ScalarLogical(0));
  }
  if(YAJL_IS_OBJECT(node)){
    return(ParseObject(node));
  }
  if(YAJL_IS_ARRAY(node)){
    return(ParseArray(node));
  }
  error("Invalid YAJL node type.");
}

SEXP ParseObject(yajl_val node){
  int len = YAJL_GET_OBJECT(node)->len;
  SEXP keys = PROTECT(allocVector(STRSXP, len));
  SEXP vec = PROTECT(allocVector(VECSXP, len));
  for (int i = 0; i < len; ++i) {
    SET_STRING_ELT(keys, i, mkCharCE(YAJL_GET_OBJECT(node)->keys[i], CE_UTF8));
    SET_VECTOR_ELT(vec, i, ParseValue(YAJL_GET_OBJECT(node)->values[i]));
  }
  setAttrib(vec, R_NamesSymbol, keys);
  UNPROTECT(2);
  return vec;
}

SEXP ParseArray(yajl_val node){
  int len = YAJL_GET_ARRAY(node)->len;
  SEXP vec = PROTECT(allocVector(VECSXP, len));
  for (int i = 0; i < len; ++i) {
    SET_VECTOR_ELT(vec, i, ParseValue(YAJL_GET_ARRAY(node)->values[i]));
  }
  UNPROTECT(1);
  return vec;
}

