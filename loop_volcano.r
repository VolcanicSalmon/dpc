lapply(unique(rescompare_symbol),function(compare){
 tmpres=rescompare_symbol[rescompare_symbol$comparison==compare,]
 p=EnhancedVolcano(tmpres,lab=tmpres$SYMBOL,pCutoff=0.05,FCcutoff=1,x='log2FoldChange',y='padj',title=compare)
 ggsave(paste0('res',compare,'_volca.pdf'),plot=p)
 print(p)}
 )
