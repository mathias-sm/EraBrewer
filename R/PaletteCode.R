# List of Color Palettes and the order in which they are printed

#' Era Palettes
#'
#' A named list of color palettes inspired by Taylor Swift's eras. Each entry
#' is a list of length two: a character vector of hex codes, and an integer
#' vector giving the preferred order in which the colors should be drawn for
#' discrete palettes of increasing size.
#'
#' @format A named list with one entry per palette.
#' @return A named list; each element is itself a list of length two: a
#'   character vector of hex codes and an integer vector giving the curated
#'   order-of-use for discrete subsets.
#' @examples
#' names(EraPalettes)
#' EraPalettes[["Lover2"]]
#' @export
EraPalettes <- list(
  Red1 =               list(c("#1E0502", "#2A0A04", "#370702", "#460902", "#5D1103", "#832F20", "#AC6356", "#CCA199", "#E9D9D7"), c(5,7,1,9,3,6,8,2,4)),
  Red2 =               list(c("#4D5F63", "#370702", "#48402B", "#C89E82", "#914622", "#C1CFC4"),                                  c(1,3,5,6,2,4)),
  NineteenEightyNine = list(c("#C34533", "#A55D38", "#CFA176", "#CACCC7", "#8CACC4", "#7AA1BD", "#5A88AE"),                       c(1,5,3,6,4,7,2)),
  Showgirl1 =          list(c("#642921", "#613A1B", "#D07C40", "#6B7237", "#448363"),                                             c(5, 1, 3, 4, 2)),
  Showgirl2 =          list(c("#B74C2D", "#DC673E", "#CCB178", "#EAEDC4", "#C1DCBF", "#7BB594", "#448363"),                       c(1, 7, 3, 5, 2, 6, 5)),
  SpeakNow1 =          list(c("#E2CFD8", "#C2A2B4", "#945791", "#7F407E", "#6B2D6D", "#421B4C", "#1C1120"),                       c(2, 6, 1,7,4,5,3)),
  SpeakNow2 =          list(c("#F9DAC1", "#C27045", "#7E391D", "#29130F", "#050303"),                                             c(3, 1, 4, 5, 2)),
  TorturedPoet =       list(c("#EDECE8", "#E1DED7", "#B7B0A6", "#7F776D", "#443D35", "#342D26", "#2C251F"),                       c(3,6,4,1,5,7,2)),
  Fearless =           list(c("#FAF2C8", "#EFDCA8", "#E0C082", "#B58F51", "#8A6737", "#664525", "#4B3220"),                       c(7,3,5,1,6,4,2)),
  Evermore1 =          list(c("#D9BFAB", "#C3A38A", "#928171", "#514741", "#1D171B", "#51292A", "#451A11", "#71311D", "#AD5D3B"), c(5,2,9,7,4,8,1,6,3)),
  Evermore2 =          list(c("#1D171B", "#451A11", "#71311D", "#AD5D3B", "#DD936E", "#D9BFAB"),                                  c(4,3,6,1,5,2)),
  Reputation =         list(c("#FEFEFE", "#BFBFBF", "#5D5D5D", "#2B2B2B", "#050505"),                                             c(5,3,1,2,4)),
  Lover1 =             list(c("#BF567F", "#FCB3C3", "#FEEFC6", "#815F51", "#4478AC"),                                             c(1, 5, 3, 4, 2)),
  Lover2 =             list(c("#BF567F", "#FAAFD3", "#D9A8E8", "#6CB4DC", "#4478AC"),                                             c(1, 5, 3, 4, 2)),
  TaylorSwift =        list(c("#142B1A", "#486833", "#689739", "#30C97E", "#29ADDE", "#2297B8", "#23677E"),                       c(3,7,5,1,4,2,6)),
  Midnight1 =          list(c("#02091C", "#1B2541", "#354167", "#50658A", "#64829D", "#829EB1", "#A9B3C0"),                       c(7,2,6,4,1,5,3)),
  Midnight2 =          list(c("#411D30", "#5F2732", "#9A383C", "#BC7E6A", "#CBCBCD", "#7191A9", "#3D5F82", "#2B4159", "#202D3C"), c(2, 8, 4, 6, 1, 9, 3, 7, 5))
)

# Internal: palette name -> cover image filename used by test.plots.era
mapping <- c(
  Lover1 = "Lover.png",
  Lover2 = "Lover.png",
  Showgirl1 = "Showgirl.png",
  Showgirl2 = "Showgirl.png",
  SpeakNow1 = "Speak_now.png",
  SpeakNow2 = "Speak_now.png",
  TorturedPoet = "Tortured_Poets.png",
  Fearless = "Fearless.png",
  Evermore1 = "Evermore.png",
  Evermore2 = "Evermore.png",
  Reputation = "Reputation.png",
  NineteenEightyNine = "1989.png",
  Red1 = "Red.png",
  Red2 = "Red.png",
  TaylorSwift = "Taylor_swift.png",
  Midnight1 = "Midnights.png",
  Midnight2 = "Midnights.png"
)

#' Generate a color palette
#'
#' Returns a vector of colors drawn from one of the palettes in
#' \code{\link{EraPalettes}}. Supports both discrete (curated subsets) and
#' continuous (interpolated) palettes.
#'
#' @param palette_name Character. Name of the palette; must be one of
#'   \code{names(EraPalettes)}.
#' @param n Integer. Number of colors to return. Defaults to the full palette
#'   length.
#' @param type One of \code{"discrete"} or \code{"continuous"}. If omitted,
#'   chosen automatically: \code{"continuous"} when \code{n} exceeds the
#'   palette length, otherwise \code{"discrete"}.
#' @param direction \code{1} for the standard order, \code{-1} for reversed.
#' @param override_order Logical. If \code{TRUE}, return colors in their stored
#'   order rather than the curated order-of-use for the requested \code{n}.
#' @param return_hex Logical. If \code{TRUE}, also prints the hex codes.
#'
#' @return An object of class \code{"palette"}: a character vector of hex
#'   codes with the palette name stored as an attribute.
#'
#' @examples
#' # Discrete palette using the curated order-of-use
#' era.brewer("Lover2", n = 3)
#'
#' # Continuous interpolation when n exceeds the stored palette length
#' era.brewer("Showgirl2", n = 50, type = "continuous")
#'
#' # Reverse direction
#' era.brewer("Fearless", direction = -1)
#'
#' # Plug into a ggplot2 manual scale
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() +
#'   scale_color_manual(values = era.brewer("Lover2", n = 3))
#' @export
era.brewer <- function(palette_name, n, type = c("discrete", "continuous"), direction = c(1, -1), override_order = FALSE, return_hex = FALSE) {

  `%notin%` <- Negate(`%in%`)

  palette <- EraPalettes[[palette_name]]

  if (is.null(palette) || is.numeric(palette_name)) {
    stop("Palette does not exist.")
  }

  if (missing(n)) {
    n <- length(palette[[1]])
  }

  if (missing(direction)) {
    direction <- 1
  }

  if (direction %notin% c(1, -1)) {
    stop("Direction not valid. Please use 1 for standard palette or -1 for reversed palette.")
  }

  if (missing(type)) {
    if (n > length(palette[[1]])) {
      type <- "continuous"
    } else {
      type <- "discrete"
    }
  }

  type <- match.arg(type)

  if (type == "discrete" && n > length(palette[[1]])) {
    stop("Number of requested colors greater than what discrete palette can offer, \n use continuous instead.")
  }

  continuous <- if (direction == 1) {
    grDevices::colorRampPalette(palette[[1]])(n)
  } else {
    grDevices::colorRampPalette(rev(palette[[1]]))(n)
  }

  discrete <- if (direction == 1 & override_order == FALSE) {
    palette[[1]][which(palette[[2]] %in% c(1:n) == TRUE)]
  } else if (direction == -1 & override_order == FALSE) {
    rev(palette[[1]][which(palette[[2]] %in% c(1:n) == TRUE)])
  } else if (direction == 1 & override_order == TRUE) {
    palette[[1]][1:n]
  } else {
    rev(palette[[1]])[1:n]
  }

  out <- switch(type,
    continuous = continuous,
    discrete = discrete
  )
  if (isTRUE(return_hex)) print(out)
  structure(out, class = "palette", name = palette_name)
}

#' Print a palette
#'
#' S3 method for objects of class \code{"palette"}. Renders the palette as a
#' row of colored tiles labeled with the palette name.
#'
#' @param x A \code{"palette"} object as returned by \code{\link{era.brewer}}.
#' @param ... Unused.
#'
#' @return A \code{ggplot} object: a row of colored tiles labeled with the
#'   palette name. Rendered when auto-printed at the top level or when
#'   further composed with \code{ggplot2} layers.
#'
#' @examples
#' print(era.brewer("Lover2"))
#' @importFrom ggplot2 .data
#' @export
print.palette <- function(x, ...) {
  n <- length(x)
  df <- data.frame(color = x, xpos = seq_len(n))

  ggplot2::ggplot(df, ggplot2::aes(x = .data$xpos, y = 1, fill = .data$color)) +
    ggplot2::geom_tile() +
    ggplot2::scale_fill_identity() +
    ggplot2::annotate("label",
                      x = (n + 1) / 2, y = 1,
                      label = attr(x, "name"),
                      size = 8, family = "serif",
                      fill = ggplot2::alpha("white", 0.8)) +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none")
}
