#' Sample visualizations for a palette
#'
#' Internal helper used during development to preview palettes. Not exported.
#' Requires \pkg{magick}, \pkg{ggstream}, \pkg{cowplot}, \pkg{dplyr}, and
#' \pkg{usmap} to be installed.
#'
#' @param palette_name Character. Name of the palette to preview.
#' @return Path to the saved SVG.
#' @keywords internal
test.plots.era <- function(palette_name){

  set.seed(1)

  plot <- c()
  added <- 0
  for (n in list(3, 6, 15)) {
    type <- if(n > length(era.brewer(palette_name))){"continuous"}else{"discrete"}

    test_pal <- era.brewer(palette_name, n, type)

    pie_plot <- ggplot() +
      geom_bar(aes(x=1:n, y=runif(n, 2, 3), fill=letters[1:n]), stat="identity") +
      coord_polar() +
      scale_x_continuous(expand = c(0, 0.04)) +
      scale_fill_manual(values=test_pal) +
      theme_void() +
      theme(legend.position = "none")

    stream <- data.frame(col=sort(rep(letters[1:n], 10)))

    stream_plot <- ggplot(data = stream) +
        geom_stream(aes(x=rep(1:10, n), y=runif(10*n, 0, 3), fill=col), extra_span = 0.15, linewidth=5) +
        scale_x_continuous(expand = c(0, 0.04)) +
        scale_fill_manual(values=test_pal) +
        theme_void() +
        theme(legend.position = "none")

    violin_plot <- ggplot() +
        geom_violin(aes(x=sort(rep(1:n, 15)), y=rnorm(15*n, 0, 0.75), fill=sort(rep(letters[1:n], 15))), color="transparent") +
        scale_x_continuous(expand = c(0, 0.04)) +
        scale_fill_manual(values=test_pal) +
        theme_void() +
        theme(legend.position = "none")

    bars_plot <- ggplot() +
      geom_bar(aes(x=rep(1:5, n), y=runif(5*n, 0, 5), fill=sort(rep(letters[1:n], 5))), stat="identity", position = "stack") +
      scale_x_continuous(expand = c(0, 0.04)) +
      scale_fill_manual(values=test_pal) +
      theme_void() +
      theme(legend.position = "none")

    grid <- plot_grid(pie_plot, stream_plot, violin_plot, bars_plot, ncol=1)
    plot <- plot_grid(plot, grid, rel_widths=c(added, 1))
    added <- added + 1
  }

  line_plot <-
    ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
    geom_point(size=2) +
    geom_smooth(method="lm", se=F, linewidth=2, formula=y~x) +
    scale_color_manual(values=era.brewer(palette_name, n=3)) +
    theme_cowplot() + theme(legend.position = "none") +
    theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.title.y=element_blank(), axis.text.y=element_blank())

  map_plot <-
    countydata %>%
    left_join(counties, by = "county_fips") %>%
    filter(state_name =="California") %>%
    ggplot(mapping=aes(long,lat,group = group, fill = horate)) +
    geom_polygon(color="black", linewidth=.25) +
    scale_fill_gradientn(colors = era.brewer(palette_name), limits = c(0.3591, 0.7867), breaks = seq(0.3591, 0.7867, length.out = 5)) +
    coord_fixed() +
    labs(fill="Homeownership rate") +
    theme_void() + theme(legend.title = element_blank(), legend.text = element_blank())

  image_plot = image_ggplot(image_read(paste0('dev/res/', mapping[palette_name])))
  palette_plot <- print.palette(era.brewer(palette_name))
  header <- plot_grid(image_plot, palette_plot, nrow=1)
  two_plots <- plot_grid(line_plot, map_plot, ncol=2)
  with_title <- plot_grid(header, plot, two_plots, ncol=1, rel_heights = c(1, 1, 1))

  path = paste0("man/figures/", palette_name, ".svg")
  suppressMessages(ggsave(filename=path, with_title, bg = "transparent"))
  return(path)
}
