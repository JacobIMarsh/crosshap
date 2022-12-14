#' XXSummary TablesXX
#'
#' XXNeeds updating.XX
#'
#' @param HapObject Haplotype object created by run_haplotyping().
#'
#' @export
#'
#' @return A list containing two ggplot objects.
#'
#' @examples
#'
#' if (FALSE) {
#'     XX
#' }
#'

build_summary_tables <- function(HapObject){

no0Varfile <- HapObject$Varfile %>% dplyr::filter(MGs != 0)

q <- dplyr::left_join(
no0Varfile %>% dplyr::count(MGs) %>% dplyr::rename(nSNP = 'n'),
stats::aggregate(no0Varfile$percdiff,
                 base::list(pre_leftplotdata$MGs),
                 mean) %>% dplyr::rename(MGs = 'Group.1', percdiff = 'x') %>%
  tibble::as_tibble(),
by = "MGs") %>%
  dplyr::left_join(

stats::aggregate(no0Varfile$meanr2,
                 base::list(pre_leftplotdata$MGs),
                 mean) %>% dplyr::rename(MGs = 'Group.1', meanR2 = 'x') %>%
  tibble::as_tibble(),
by = "MGs") %>%
  dplyr::left_join(
    stats::aggregate(no0Varfile$AltAF,
                       base::list(pre_leftplotdata$MGs),
                       mean) %>% dplyr::rename(MGs = 'Group.1', AltAF = 'x') %>%
      tibble::as_tibble(),
    by = "MGs") %>%
  dplyr::mutate_if(is.double, function(x){round(x, digits = 2)})

x <- gridExtra::tableGrob(q %>% tibble::column_to_rownames('MGs'),
                          theme = ggpp::ttheme_gtstripes(
  colhead = list(bg_params = list(fill = "white"),
                 fg_params = list(fontface = 2L)),
  rowhead = list(bg_params = list(fill = "white"),
                 fg_params = list(fontface = 2L))
))


zbot <- gtable::gtable_add_grob(x,
                             grobs = grid::segmentsGrob( # line across the bottom
                               x0 = grid::unit(0,"npc"),
                               y0 = grid::unit(0,"npc"),
                               x1 = grid::unit(1,"npc"),
                               y1 = grid::unit(0,"npc"),
                               gp = gpar(lwd = 1)),
                             t = 5, b = nrow(x), l = 2, r = ncol(x))

ztop <- gtable::gtable_add_grob(zbot,
                        grobs = grid::segmentsGrob( # line across the bottom
                          x0 = grid::unit(0,"npc"),
                          y0 = grid::unit(1,"npc"),
                          x1 = grid::unit(1,"npc"),
                          y1 = grid::unit(1,"npc"),
                          gp = grid::gpar(lwd = 1)),
                        t = 2, b = 2, l = 2, r = ncol(zbot))

zall <- gtable::gtable_add_grob(ztop,
                        grobs = grid::segmentsGrob( # line across the bottom
                          x0 = grid::unit(0,"npc"),
                          y0 = grid::unit(1,"npc"),
                          x1 = grid::unit(1,"npc"),
                          y1 = grid::unit(1,"npc"),
                          gp = grid::gpar(lwd = 1)),
                        t = 1, b = 1, l = 2, r = ncol(ztop))

MGtable <- ggplot2::ggplot() + zall + ggplot2::theme_minimal()

#########DONE 1

phen <- HapObject$Indfile %>%
  dplyr::filter(hap != 0) %>%
  dplyr::group_by(hap) %>%
  dplyr::summarise(phenav = mean_na.rm(Pheno)) %>%
  tidyr::spread(hap, phenav) %>%
  tibble::as_tibble() %>%
  dplyr::mutate_if(is.double, function(x){signif(x, 3)}) %>%
  dplyr::mutate_if(is.double, as.character) %>%
  dplyr::mutate(rname = "Pheno") %>%
  tibble::column_to_rownames("rname")


temp_meta <- suppressMessages(HapObject$Indfile %>%
                                   dplyr::group_by(hap, Metadata) %>%
                                   dplyr::summarise(counts = length(Metadata)) %>%
                                   dplyr::filter(hap != 0) %>%
                              tidyr::spread('hap', 'counts'))
temp_meta$Metadata[is.na(temp_meta$Metadata)] <- "NA"
temp_meta[is.na(temp_meta)] <- 0
meta <- tibble::column_to_rownames(temp_meta, "Metadata") %>% as.matrix()

n <- HapObject$Hapfile %>%
  dplyr::select(hap, n) %>%
  tidyr::spread(hap, n) %>%
  tibble::as_tibble() %>%
  dplyr::mutate(rname = "nTotal") %>%
  tibble::column_to_rownames("rname")

hapdat <- rbind(phen, meta, n)

y <- gridExtra::tableGrob(hapdat,
                          theme = ggpp::ttheme_gtstripes(
                            colhead = list(bg_params = list(fill = "white"),
                                           fg_params = list(fontface = 2L)),
                            rowhead = list(bg_params = list(fill = "white"),
                                           fg_params = list(fontface = 2L))
                          ))


ybot <- gtable::gtable_add_grob(y,
                                grobs = grid::segmentsGrob( # line across the bottom
                                  x0 = grid::unit(0,"npc"),
                                  y0 = grid::unit(0,"npc"),
                                  x1 = grid::unit(1,"npc"),
                                  y1 = grid::unit(0,"npc"),
                                  gp = gpar(lwd = 1)),
                                t = 5, b = nrow(y), l = 2, r = ncol(y))

ytop <- gtable::gtable_add_grob(ybot,
                                grobs = grid::segmentsGrob( # line across the bottom
                                  x0 = grid::unit(0,"npc"),
                                  y0 = grid::unit(1,"npc"),
                                  x1 = grid::unit(1,"npc"),
                                  y1 = grid::unit(1,"npc"),
                                  gp = grid::gpar(lwd = 1)),
                                t = 2, b = 2, l = 2, r = ncol(ybot))

yall <- gtable::gtable_add_grob(ytop,
                                grobs = grid::segmentsGrob( # line across the bottom
                                  x0 = grid::unit(0,"npc"),
                                  y0 = grid::unit(1,"npc"),
                                  x1 = grid::unit(1,"npc"),
                                  y1 = grid::unit(1,"npc"),
                                  gp = grid::gpar(lwd = 1)),
                                t = 1, b = 1, l = 2, r = ncol(ytop))

haptable <- ggplot2::ggplot() + yall + ggplot2::theme_minimal()

return(list(zall, yall))
}
