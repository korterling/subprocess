#' Manage Subprocesses in R
#'
#' Cross-platform child process management modelled after Python's
#' `subprocess` module.
#'
#' @details This R package extends R's capabilities of starting and
#' handling child processes. It brings the capability of alternating
#' read from and write to a child process, communicating via signals,
#' terminating it and handling its exit status (return code).
#' 
#' With R's standard [base::system] and [base::system2]
#' functions one can start a new process and capture its output but
#' cannot directly write to its standard input. Another tool, the
#' [parallel::mclapply] function, is aimed at replicating
#' the current session and is limited to operating systems that come
#' with the `fork()` system call.
#' 
#'
#' @docType package
#' @name subprocess
#' @rdname subprocess
#' 
#' @references
#' http://github.com/lbartnik/subprocess
#' 
#' http://docs.python.org/3/library/subprocess.html
#'
NULL


.onLoad <- function (libname, pkgname)
{
  signals <<- as.list(known_signals())
  envir <- asNamespace(pkgname)
  
  mapply(name = names(signals),
         code = as.integer(signals),
         function (name, code) {
           suppressWarnings(assign(name, code, envir = envir, inherits = FALSE))
         })
}
