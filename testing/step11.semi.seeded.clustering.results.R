options(width=180)

arg1<-commandArgs(trailingOnly = T)
fn.arff<-arg1[1]
fn.seeds<-arg1[2]
fn.memb<-arg1[3]
fn.csv<-gsub("arff","csv",fn.arff)

print(fn.arff)
print(fn.seeds)
print(fn.memb)

memb.res<-read.table(fn.memb)
memb.res.ordered<-memb.res[order(memb.res[,2]),]
ind.seeds<-read.table(fn.seeds)[,1]
dat.csv<-read.csv(fn.csv)

print(dim(dat.csv))
print(dim(memb.res.ordered))
print(head(memb.res.ordered))

#lab.pred<-rep("",nrow(memb.res.ordered))
lab.pred<-memb.res.ordered[,1]+1
lab.pred[ind.seeds]<-memb.res.ordered[seq(length(ind.seeds)),1]+1
lab.pred[-ind.seeds]<-memb.res.ordered[-seq(length(ind.seeds)),1]+1
lab.ori<-c(as.character(dat.csv[ind.seeds,3]),
	as.character(dat.csv[-ind.seeds,3]))
print(table(lab.ori,lab.pred))
print(table(dat.csv[,3],lab.pred))

str.unq<-unique(as.character(dat.csv[ind.seeds,3]))
vec1<-table(dat.csv[ind.seeds,3]==str.unq[lab.pred][ind.seeds])
cat(c("accuracy=",vec1,rev(vec1)[1]/sum(vec1),"\n"))

############################################
fn.png.b4<-gsub("arff","before.png",fn.arff)
png(fn.png.b4,width=1000,height=1000)
	x<-dat.csv[,1]
	y<-dat.csv[,2]

	col1<- lab.pred
	print(table(dat.csv[,3],lab.pred))

	plot(x,y,type='n',main=fn.png.b4)
	points(x[-ind.seeds],y[-ind.seeds],col=8,pch=16,cex=0.8)

	col.seeds<-col1[ind.seeds]
	points(x[ind.seeds],y[ind.seeds],col=col.seeds,pch=16,cex=1.5)

	lab.2<-sort(unique(lab.pred))
	col.2<-col1[match(lab.2,lab.pred)]
	legend("top", str.unq[lab.2], pch = 16, col=col.2)

dev.off()


############################################
fn.png.aft<-gsub("arff","after.png",fn.arff)
png(fn.png.aft,width=1000,height=1000)
	x<-dat.csv[,1]
	y<-dat.csv[,2]

	col1<- lab.pred
	print(table(dat.csv[,3],lab.pred))

	plot(x,y,type='n',main=fn.png.aft)

	points(x[-ind.seeds],y[-ind.seeds],col=col1[-ind.seeds],pch=16,cex=.8)
	col.seeds<-col1[ind.seeds]
	points(x[ind.seeds],y[ind.seeds],col=col.seeds,pch=16,cex=1.5)

	lab.2<-sort(unique(lab.pred))
	col.2<-col1[match(lab.2,lab.pred)]
	legend("top", str.unq[lab.2], pch = 16, col=col.2)
dev.off()

