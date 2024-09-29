matchgname=function(dataset){
        require(biomaRt)
        mart=useMart('plants_mart','zmays_eg_gene',host='https://plants.ensembl.org')
        databm=getBM(attributes=c('ensembl_gene_id','entrezgene_accession','go_id','interpro','interpro_description','chromosome_name','name_1006'),filters='ensembl_gene_id',values=rownames(dataset),mart=mart)
	datahub=AnnotationDbi::select(org,keys=as.character(databm$entrezgene_accession),keytype='ENTREZID',columns=c('GENENAME'))
	databm$GENENAME=datahub$GENENAME
        merged=merge(dataset,databm,by.x='row.names',by.y='ensembl_gene_id')
        colnames(merged)[1]='Gene_id'
        return(merged)
}