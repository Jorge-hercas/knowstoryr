

#' Set API key in enviroment
#'
#' @param token
#'
#' @return
#' @export
#'
#' @examples
set_token <- function(token){
  Sys.setenv(token = token)
}

#' Data extraction from knowstory server
#'
#' @param token API KEY (can be in global enviroment)
#' @param file_path document path. Should be a local path
#' @param fields list with parameters to extract. Require name, description and type (value type. Can be a number, string, boolean, date)
#'
#' @return
#' @export
#'
#' @examples
#' token <- "XXXXXXXXXXXXXXXXXXXXX"
#' set_token(token)
#'
#' fields_to_extract <- list(
#'   list(
#'     name = "Placas",
#'     description = "Placas string",
#'     type = "String"
#'   ),
#'   list(
#'     name = "Clase",
#'     description = "Clase string",
#'     type = "String"
#'   ),
#'   list(
#'     name = "Marca",
#'     description = "Marca string",
#'     type = "String"
#'   ),
#'   list(
#'     name = "Year",
#' description = "Year number",
#'  type = "Number"
#' )
#' )
#'
#' data_request(file_path = 'document/path/local', fields = fields_to_extract)
data_request <- function(token = Sys.getenv("token"), file_path, fields){

  library(httr)
  library(jsonlite)

  headers <- c('Authorization' = paste('Bearer', token, sep=' '))
  url <- 'https://api.reformhq.com/v1/api/extract'

  x <-
    POST(url,
         add_headers(headers),
         body = list(fields_to_extract = toJSON(fields_to_extract, auto_unbox = TRUE),
                     document = upload_file(file_path)))

  return(content(x))

}
