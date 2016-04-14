library(qqman)
GWAS <- read.csv("ladies.csv")

#change factor to char.
GWAS$CHR_ID <- as.character(GWAS$CHR_ID)

#replace chrM with 17
#GWAS[GWAS$CHR_ID=="chrM","CHR_ID"] <- "17"


#char. to number
GWAS$CHR_ID <- as.numeric(GWAS$CHR_ID)


#do for plot group project allele frequencies
manhattan(GWAS, chr="CHR_ID", bp="CHR_POS", p="REP3_FINAL", snp="SNP_ID_CURRENT", ylim=c(0, 1.2), logp=FALSE, ylab="change of allele frequency", genomewideline = FALSE, suggestiveline = FALSE, chrlabs=c(1:16, "chrM"), col =c(1:16, "red", "blues9"))



png("rep3_manhattan.png", height=400, width=1000)
manhattan(GWAS, chr="CHR_ID", bp="CHR_POS", p="REP3_FINAL", snp="SNP_ID_CURRENT", ylim=c(0, 1.2), logp=FALSE, ylab="change of allele frequency", genomewideline = FALSE, suggestiveline = FALSE, chrlabs=c(1:16, "chrM"), col =c(1:16, "red", "blues9"))
abline(h=c(0.350), col="blue")
dev.off()