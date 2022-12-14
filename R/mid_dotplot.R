#' Middle MG/hap dot plot
#'
#' build_mid_dotplot() builds a central dot plot displaying the relationship
#' between haplotype combinations and the characteristic marker group alleles
#' that define them. Makes use of the $Hapfile information from a haplotype
#' object. This is an internal function called by crosshap_viz(), though can
#' be called separately to build a stand-alone plot (can be useful when patched
#' to a a peripheral plot).
#'
#' @param HapObject Haplotype object created by crosshap::run_haplotyping
#' @param hide_labels
#'
#' @export
#'
#' @return A ggplot2 object.
#'
#' @examples
#'
#' if (FALSE) {
#'      build_mid_dotplot(Haplotypes_MGmin30_E0.6, hide_labels = F)
#'}
#'

build_mid_dotplot <- function(HapObject, hide_labels) {
intersect <- HapObject$Hapfile %>%
  tidyr::gather(MG, present, 3:(base::ncol(.))) %>%
  dplyr::mutate(present = base::as.factor(present)) %>%
  dplyr::mutate(MG = base::as.numeric(stringr::str_remove(MG, "MG"))) %>%
  dplyr::mutate(present = gsub(as.factor(2),"ALT",
                               gsub(as.factor(1),"HET",
                                    gsub(as.factor(0),"REF",present)))) %>%
  dplyr::mutate(Allele = factor(present, levels = c("REF", "HET", "ALT")))

intersect_lines <- intersect %>%
  dplyr::filter(Allele == "ALT") %>%
  dplyr::group_by(hap) %>%
  dplyr::summarise(max = base::max(MG), min = base::min(MG)) %>%
  dplyr::mutate(min = base::as.character(min), max = base::as.character(max))

mid_dotplot <- ggplot2::ggplot() +
  ggplot2::geom_segment(data = intersect_lines, col = "grey", linewidth = 1.5,
               ggplot2::aes(x = hap, xend = hap, y = min, yend = max)) +
  ggplot2::geom_point(data = intersect, col = 'black', pch = 21,
             ggplot2::aes(hap, base::as.character(MG), fill = Allele, size= 2)) +
  ggplot2::scale_fill_manual(values = c('white','black','grey')) +
  ggplot2::theme_minimal() +
  ggplot2::theme(legend.direction = 'horizontal',
                 legend.justification = "left",
        plot.margin = ggplot2::unit(c(0,0,0,0), "cm"),
        plot.title = ggplot2::element_blank(),
        axis.text.x = ggplot2::element_text(size = 10, face = 'bold', color = 'black'),
        axis.text.y = ggplot2::element_text(size = 10, face = 'bold', color = 'black'),
        legend.title = ggplot2::element_text(size = 10),
        legend.text = ggplot2::element_text(size = 7),
        legend.key.size = ggplot2::unit(7, "mm"),
 #       axis.title = ggplot2::element_blank()
 ) +
  ggplot2::ylab("Marker Group") +
  ggplot2::xlab("Haplotype combination") +
  ggplot2::guides('size' = "none",
                  fill = ggplot2::guide_legend(override.aes = list(size = 5), title = "Allele")) +
  ggplot2::scale_y_discrete(limits = rev, position = "left",
                   labels = c(paste0("MG",base::as.character(base::max(intersect$MG):1))))

if(hide_labels == T){
  return(mid_dotplot + ggplot2::theme(legend.position = "none"))
} else {
  return(mid_dotplot)
}
}
