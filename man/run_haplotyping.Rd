% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_haplotyping_wrapper.R
\name{run_haplotyping}
\alias{run_haplotyping}
\title{Cluster SNPs and identify haplotypes}
\usage{
run_haplotyping(
  vcf,
  LD,
  pheno,
  metadata = NULL,
  epsilon = c(0.2, 0.4, 0.6, 0.8, 1),
  MGmin,
  minHap = 9,
  hetmiss_as = "allele",
  het_as = "alt",
  keep_outliers = F
)
}
\arguments{
\item{vcf}{Input VCF for region of interest.}

\item{LD}{Pairwise correlation matrix of SNPs in region (e.g. from PLINK).}

\item{pheno}{Input numeric phenotype data for each individual.}

\item{metadata}{Metadata input (optional).}

\item{epsilon}{Epsilon values for clustering SNPs with DBscan.}

\item{MGmin}{Minimum SNPs in marker groups, MinPts parameter for DBscan.}

\item{minHap}{Minimum nIndividuals in a haplotype combination.}

\item{hetmiss_as}{If hetmiss_as = "allele", heterozygous-missing SNPs './N'
are recoded as 'N/N', if hetmiss_as = "miss", the site is recoded as missing.}

\item{het_as}{If het_as = "alt", heterozygous SNPs are recoded 'REF/ALT' are
recoded as 'ALT/ALT' to reduce number of unique haplotypes, if het_as =
"het", they are kept as 'REF/ALT'.}

\item{keep_outliers}{When FALSE, marker group smoothing is performed to
remove outliers.}
}
\value{
A comprehensive haplotyping S3 object (HapObject) for each provided
epsilon value, needed for run_clustree() and crosshap_viz().
}
\description{
run_haplotyping() performs density-based clustering of SNPs in region of
interest to identify marker groups. Individuals are classified by haplotype
combination based on shared combinations of marker group alleles. Returns a
comprehensive haplotyping object (HapObject), which can be used as input to
build clustering tree for epsilon optimization using run_clustree(), and
can be visualized with reference to phenotype and metadata using
crosshap_viz().
}
\examples{

if (FALSE) {
     run_haplotyping(vcf, LD, pheno, metadata, MGmin = 30)
}

}
