ont="BP"
for (i in subsets){
subup=paste(i,"topgo",ont,"_up.csv",sep='')

subdown=paste(i,"topgo",ont,"_down.csv",sep='')

subupdat=read.csv(subup)

subdowndat=read.csv(subdown)

subupdat=subupdat%>%mutate(change='up')

subdowndat=subdowndat%>%mutate(change='down')%>%mutate(Significant=Significant*(-1))

subbothdat=rbind(subupdat,subdowndat)

ggplot(subbothdat[subbothdat$Fisher=="< 1e-30",],aes(y=Term,x=Significant,
fill=as.numeric(abs(Significant/Annotated)),scale(scale=0.5)))+geom_bar(stat='identity')+labs(fill="gene ratio")+
theme(text=element_text(size=16))+ggtitle(basename(i),"Bological processes")
ggsave(paste(i,"bpbar.pdf",sep=''),width=10,height=8,dpi=150,units="in",device="pdf")
}
