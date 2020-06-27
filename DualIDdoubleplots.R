############################################
## The dual identity of Asian Americans
## Code for creating Figure 1 in manuscript
############################################

rm(list=ls(all=TRUE))
getwd()
setwd("return output from getwd()")


## Library Required Packages
library(ggplot2)


#######################################
## Create dataset for ggplot drawing ##
#######################################

pcreate <- function(coef.vec.1,se.vec.1,
coef.vec.2,se.vec.2, var.names,
axislim = c(-2,6), 
axisbreak = seq(-1.75,2.25,0.5),
legloc = c(0.86,0.1)){

# Drop NA Elements
cf1 <- coef.vec.1[-which(var.names=="")]
se1 <- se.vec.1[-which(var.names=="")]
cf2 <- coef.vec.2[-which(var.names=="")]
se2 <- se.vec.2[-which(var.names=="")]
vn <- var.names[-which(var.names=="")]

########### Factor Names (\n implies line break in the output)
fn <- c(rep("Other social \n group identities",which(var.names=="")[1]-1),
        rep("Political & socioeconomic \nfactors",which(var.names=="")[2]-which(var.names=="")[1]-1),
        rep("Ethnicity & cultural \nfactors",length(var.names)-which(var.names=="")[2]))
fn <- factor(fn,levels=unique(fn))

########### Type of wave
race <- rep(c("Pre-election wave","Post-election wave"),each=length(vn))
race <- factor(race, levels=c("Pre-election wave","Post-election wave"))

## Add titles and axis labels
prepost2016identities_ggplot <- # Combine Vectors into Dataset
gd <- data.frame(cf = c(cf1,cf2), # Coefficients
                 uCI = c(cf1+1.96*se1,cf2+1.96*se2), # Upper CI limits
                 lCI = c(cf1-1.96*se1,cf2-1.96*se2), # Lower CI limits
                 vn = rep(vn,2), # Variable names
                 fn = rep(fn,2), # Factor names
                 race = race # Race names
                 ) 

#####################
## Set Graph Theme ##
#####################

# Check ?theme for more details. There are more values that can be pre-set.

gtheme <-
  theme(text = element_text(size=10, colour="black"), # General Text Setting
        axis.text.x=element_text(colour="black"), # x axis labels text
        axis.text.y=element_text(colour="black"), # y axis labels text
        axis.title.x=element_text(size=11,vjust=-1.5), # x axis title text
        axis.title.y=element_text(size=11,vjust=1.5), # y axis title text
        plot.title=element_text(size=12,lineheight=.6, # plot title text
                                face="bold",vjust=2,hjust=0.5),
        plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"), # margins of the graph area *top, right, bottom, left
        panel.grid.major.x = element_blank(), # x axis grid line (major)
        panel.grid.major.y = element_line(colour = "grey90", linetype=2), # y axis grid line (major)
        panel.grid.minor.x = element_blank(), # x axis grid line (minor)
        panel.grid.minor.y = element_line(colour = "grey90", linetype=2), # y axis grid line
        panel.background = element_rect(fill=NA, colour="black", size=0.5, linetype=1), # plot panel area setting
        legend.background = element_rect(fill="white",colour="black"), # legend box setting
        legend.position = "bottom", # position of the legend: c(x,y) OR "top","bottom","left","right"
        legend.title=element_blank(), # Setting of the legend title
        legend.margin = margin(t=0.01,r=0.1,b=0.1,l=0.1,"cm"), # margins for legend box
        legend.key = element_rect(fill=NA,colour=NA), # legend keys settings
        legend.key.width = unit(1.2, "cm"), # size(width) of the legend keys
        strip.background = element_rect(fill=NA,colour=NA) # Setting of the facetted title area
        )

###############
## Draw Plot ##
###############

# How much gap do you need between two CI lines
gapwidth <- -0.5

# Draw Plot
p <- 
  # Basics: Set dataset and define variable names as X axis (flipped later)
  # *reorder command preserves the original order of variable names
  #  without this, the variable order becomes reversed alphabetical by default
  ggplot(data = gd, aes(x = reorder(vn, (length(vn)+1) - seq(1,length(vn),1)))) + 
  # Set Pre-defined Theme
  gtheme + 
  # In the output, flipp X axis and Y axis
  coord_flip() + 
  # The line that indicates 0
  geom_hline(aes(yintercept = 0),linetype = 1,colour = "grey50") +
  # Draw Points of Coefficient Value
  geom_point(aes(y = cf,shape = race),
             position=position_dodge(w = gapwidth),
             size=1.5) + 
  # Draw Confidence Interval
  geom_errorbar(aes(ymin = lCI, ymax = uCI,linetype = race), 
                position = position_dodge(w = gapwidth),
                width=0) +
  # Set Axis Limits and Breaks
  scale_y_continuous(limits = axislim, breaks = axisbreak)+
  #scale_x_continuous(limits=c(0,100),breaks=c(0,25,50,75,100)) + 
  # Set the point shape and line type for each race
  scale_shape_manual(name="Race",values=c(16,16))+
  scale_linetype_manual(name="Race",values=c(1,2))+
  # Define the position of legend box (can also be pre-defined)
  theme(legend.position = legloc) + 
  # Split cells by type of factors
  facet_grid(fn~.,margins=F,scales="free_y",space="free_y",switch="y") + 
  # Set the location of facetted strip titles (can also be pre-defined)
  theme(strip.placement = "outside",
        strip.text.y = element_text(size=11, angle=180, face="bold")) + 
  # Suppress axis titles
  xlab(NULL)+ylab(NULL)

return(p)

}


############################## Identity plots. 

coef.vec.1<- c(4.42,1.84,1.19,NA,NA,-.18,.14,-.22,.38,.18,.24,NA,.52,-.22,-.95,-.19,-.91,-.43,.22,.22,NA)

se.vec.1 <-  c(.49,.43,.32,NA,NA,.28,.28,.26,.26,.29,.17,NA,.38,.31,.30,.30,.42,.26,.38,.29,NA)

coef.vec.2<- c(3.43, 1.67,.77,.05,NA,.11,-.15,-.09,-.40,-.43,.16,NA,-.22,.65,-.60,-.08,-.11,-.01,-.01,-.15,-.11)

se.vec.2 <-  c(.26,.25,.24,.17,NA,.16,.18,.25,.15,.22,.11,NA,.20,.17,.23,.15,.20,.17,.16,.15,.14)

# Outputs for variables w/ midpoint substitution.
#coef.vec.1<- c(4.43,1.62,NA,NA,NA,-.009,.26,-.25,.13,-.16,.29,NA,.34,-.35,-.98,-.52,-.83,-.44,.08,-.04,NA)
#se.vec.1 <-  c(.36,.31,NA,NA,NA,.21,.22,.22,.27,.25,.15,NA,.32,.27,.25,.28,.34,.22,.29,.24,NA)
#coef.vec.2<- c(2.66,1.21,.78,.22,NA,.12,-.13,-.06,-.36,-.38,.11,NA,-.17,.58,-.54,-.17,-.18,-.04,.05,.009,-.12)
#se.vec.2 <-  c(.19,.18,.17,.13,NA,.12,.14,.19,.14,.19,.09,NA,.16,.14,.19,.13,.17,.14,.14,.13,.12)


var.names <- c("Ethnic identity","American identity","Gender identity","Religious identity", "","Democrat","Republican","Education", "Income", "Age",
               "Female","","Chinese","Korean","Indian","Vietnamese","Japanese","Filipino","Asian language interview","US Born","Repeat taker")

prepost2016identities<- pcreate(coef.vec.1,se.vec.1,coef.vec.2,se.vec.2,var.names, 
                     axislim=c(-2,6), # left to right
                     axisbreak=seq(-2,6,1), # min, max, by
                     legloc=c(0.77,0.1)) # 0-1 from left, 0-1 from bottom

prepost2016identities

prepost2016identities_RR<- prepost2016identities+ 
ggtitle("Predictors of pan-Asian identity \n 2016 NAAS pre and post-election") + 
ylab("Ordered logit coefficients") # note that axes are flipped 
  
  
prepost2016identities_RR

###############
## Save Plot ##
###############

dev.off()
png("prepost2016identities_RR.png", height = 900, width = 1400, res=200)
prepost2016identities_RR
dev.off()

