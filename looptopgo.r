looptopgo=function(dataset){
	data=as.data.frame(dataset)
	updata=data%>%subset(log2FoldChange>1)
	downdata=data%>%subset(log2FoldChange< -1)
	upbm=matchgname(updata)
	downbm=matchgname(downdata)
	j=deparse(substitute(dataset))
	for(ont in c('BP','CC','MF')){
		upname=paste(j,'topgo',ont,'_up.csv',sep='')
		downname=paste(j,'topgo',ont,'_down.csv',sep='')
		upgenelist=upbm$pvalue
		names(upgenelist)=upbm$Gene_id
		downgenelist=downbm$pvalue
		names(downgenelist)=downbm$Gene_id
		upg2g=tapply(upbm$go_id,upbm$Gene_id,function(x)x)
		upgodat=new('topGOdata',ontology=ont,allGenes=upgenelist,geneSel=function(x){x<=0.05},annot=annFUN.gene2GO,gene2GO=upg2g)
		downg2g=tapply(downbm$go_id,downbm$Gene_id,function(x)x)
		downgodat=new('topGOdata',ontology=ont,allGenes=downgenelist,geneSel=function(x){x<=0.05},annot=annFUN.gene2GO,gene2GO=downg2g)
		upgotest=runTest(upgodat,statistic='fisher')
		downgotest=runTest(downgodat,statistic='fisher')
		upgotab=GenTable(upgodat,Fisher=upgotest,topNodes=length(upgotest@score),numChar=120)
		upgotab=upgotab%>%mutate(generatio=upgotab$Significant/length(sigGenes(upgodat)))
		downgotab=GenTable(downgodat,Fisher=downgotest,topNodes=length(downgotest@score),numChar=120)
		downgotab=downgotab%>%mutate(generatio=downgotab$Significant/length(sigGenes(downgodat)))
		write.csv(upgotab,upname)
		write.csv(downgotab,downname)
	}
}
