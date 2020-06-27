###############################################
## The dual identity of Asian Americans
## Code for creating Figure 2 & 3 in manuscript, 
## also Figure 2 in supplementary materials
###############################################

rm(list=ls(all=TRUE))
getwd()
setwd("return output from getwd()")

## Library Required Packages
library(ggplot2)


############################### Function for Single Model Plot

# Use this for identity graphs in main text
pcreate_single <- function(coef.vec.1,se.vec.1,var.names,
                           model.name = "DV = Choose co-ethnic candidate",
                           axislim = c(-4,3), 
                           axisbreak = seq(-4,3,1),
                           legloc = c(0.86,0.1)){
  
# Use this for the linked fate graphs in Supplementary
pcreate_single <- function(coef.vec.1,se.vec.1,var.names,
                             model.name = "DV = Choose co-ethnic candidate",
                             axislim = c(-2,6), 
                             axisbreak = seq(-2.,6,1),
                             legloc = c(0.86,0.1)){
    
# Drop NA Elements
cf1 <- coef.vec.1[-which(var.names=="")]
se1 <- se.vec.1[-which(var.names=="")]
vn <- var.names[-which(var.names=="")]
  
### These are labels for the "Asian Congress", starts on line 132.
########### Political outcome groups (\n implies line break in the output)
fn <- c(rep("Race & ethnic identities",which(var.names=="")[1]-1),
          rep("Political & socioeconomic \nfactors",which(var.names=="")[2]-which(var.names=="")[1]-1),
          rep("Ethnicity & cultural \nfactors",length(var.names)-which(var.names=="")[2]))
fn <- factor(fn,levels=unique(fn))
  
#### These are labels for "2016linkedfate", starts on line 169.
fn <- c(rep("Other social \n group identities",which(var.names=="")[1]-1),
          rep("Political/SES \nfactors",which(var.names=="")[2]-which(var.names=="")[1]-1),
          rep("Ethnicity/Cultural \nfactors ",length(var.names)-which(var.names=="")[2]))
fn <- factor(fn,levels=unique(fn))
  
# Combine Vectors into Dataset
gd <- data.frame(cf = cf1, # Coefficients
                   uCI = cf1+1.96*se1, # Upper CI limits
                   lCI = cf1-1.96*se1, # Lower CI limits
                   vn = vn, # Variable names
                   fn = fn#, # Factor names
                   #race = race # Race names.
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
  gapwidth <- 0.5
  
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
    geom_point(aes(y = cf), #,shape = race
               position=position_dodge(w = gapwidth),
               size=1.5) + 
    # Draw Confidence Interval
    geom_errorbar(aes(ymin = lCI, ymax = uCI), #,linetype = race
                  position = position_dodge(w = gapwidth),
                  width=0) +
    # Set Axis Limits and Breaks
    scale_y_continuous(limits = axislim, breaks = axisbreak)+
    #scale_x_continuous(limits=c(0,100),breaks=c(0,25,50,75,100)) + 
    # Set the point shape and line type for each race
    # scale_shape_manual(name="Race",values=c(16,16))+
    # scale_linetype_manual(name="Race",values=c(1,2))+
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


###################################################################
#### This is with NAAS DV: Ethnic Congress (Figure 2 in manuscript)

coef.vec.1<- c(-.27,-.34,-1.10,NA,.48,.57,.21,-.08,-.70,-.25,NA,-1.44,-.64,-.73,-2.14,-.59,-1.18,1.50,-.24)

se.vec.1 <-  c(.28,.41,.30,NA,.31,.38,.41,.37,.52,.23,NA,.44,.38,.44,.44,.47,.43,.44,.45)

#These are coefficients for models run w/ midpoint substituion. 
#coef.vec.1<- c(-.32,-.48,-1.17,NA,.41,.44,.09,-.09,-.58,-.30,NA,-1.45,-.49,-.69,-2.03,-.53,-1.11,1.37,-.14)
#se.vec.1 <-  c(.26,.40,.27,NA,.28,.35,.37,.35,.51,.22,NA,.41,.37,.41,.42,.45,.40,.43,.43)


var.names <- c("Both strong","Only strong pan-Asian", "Both weak","","Democrat","Republican","Education", "Income", "Age",
               "Female","","Chinese","Korean","Indian","Vietnamese","Japanese","Filipino","Asian language interview","US Born")


## Length of var.names above does not match coef.vec.1 and se.vec.1, 
## so I just create temporal the vector with the same length.
#var.names <- c(paste("Cat A",seq(1,7,1)),"",
#             paste("Cat B",seq(1,14,1)),"",
#              paste("Cat C",seq(1,4,1)))


ethniccongress<- pcreate_single(coef.vec.1,se.vec.1,var.names,
                                model.name="DV = Choose co-ethnic candidate",legloc=c(0.82,0.08))
ethniccongress

## if you don't want the legend
ethniccongress_wolegend <- pcreate_single(coef.vec.1,se.vec.1,var.names,model.name="DV = Choose co-ethnic candidate",
                                          legloc="none")
ethniccongress_wolegend

## Add titles and axis labels
ethniccongress_RR <- 
  ethniccongress_wolegend + 
  ggtitle("Predictors of support for co-ethnic \n congressional representatives") + 
  ylab("Ordered logit coefficients") # note that axes are flipped
ethniccongress_RR

##################################################################
#### This is with NAAS DV: Asian Congress (Figure 3 in manuscript)


coef.vec.1<- c(1.14,.58, .03,NA,.33,-.02,.48,.12,-.15,-.14,NA,-.80,.72,-.45,-.86,-.55,-.50,.16,-.09)

se.vec.1 <-  c(.52,.55,.53,NA,.28,.29,.42,.31,.44,.25,NA,.52,.41,.45,.46,.66,.43,.41,.33)

#These are coefficients for models run w/ midpoint substituion. 
#coef.vec.1<- c(.95,.31,-.20,NA,.29,-.17,.36,.13,-.01,-.16,NA,-.89,.80,-.49,-.85,-.56,-.53,.04,-.16)
#se.vec.1 <-  c(.52,.54,.54,NA,.28,.31,.39,.30,.43,.24,NA,.49,.40,.42,.45,.60,.41,.43,.33)

var.names <- c("Both strong", "Only strong ethnicity","Both weak","","Democrat","Republican","Education", "Income", "Age",
               "Female","","Chinese","Korean","Indian","Vietnamese","Japanese","Filipino","Asian language interview","US Born")


## Length of var.names above does not match coef.vec.1 and se.vec.1, 
## so I just create temporal the vector with the same length.
#var.names <- c(paste("Cat A",seq(1,7,1)),"",
#             paste("Cat B",seq(1,14,1)),"",
#              paste("Cat C",seq(1,4,1)))


asiancongress<- pcreate_single(coef.vec.1,se.vec.1,var.names,
                                model.name="DV = Choose co-ethnic candidate",legloc=c(0.82,0.08))
asiancongress

## if you don't want the legend
asiancongress_wolegend <- pcreate_single(coef.vec.1,se.vec.1,var.names,model.name="DV = Choose co-ethnic candidate",
                                          legloc="none")
asiancongress_wolegend

## Add titles and axis labels
asiancongress_RR <- 
  asiancongress_wolegend + 
  ggtitle("Predictors of support for AAPI \n congressional representatives") + 
  ylab("Ordered logit coefficients") # note that axes are flipped
asiancongress_RR

#########################################################################
#### This is with 2016 NAAS DV: linked fate (Figure 2 in supplementary)

coef.vec.1<- c(4.70,.61,-.51,-.05,.14,.24,NA,-.21,-.20,.52,-.07,-.57,-.25,NA,.33,.45,-.09,.37,.22,.16,-.35,-.18,.34)
se.vec.1 <-  c(.26,.22,.22,.21,.17,.15,NA,.15,.16,.26,.14,.20, .11,NA,.24,.17,.20,.22,.24,.16,.22,.16,.14)

#These are coefficients for models run w/ midpoint substituion. 
#coef.vec.1<- c(4.28,.43,-.16,.04,.05,.13,NA,-.05,-.02,.32,-.08,-.57,-.20,NA,.25,.50,-.01,.35,.19,.21,-.26,-.09,.27)
#se.vec.1 <-  c(.21,.17,.17,.16,.15,.14,NA,.13,.13,.20,.13,.17, .09,NA,.21,.16,.18,.18,.21,.14,.19,.15,.12)


var.names <- c("Ethnic linked fate", "Pan-Asian identity","Ethnic identity","American identity","Gender identity","Religious identity","","Democrat","Republican","Education", "Income", "Age",
               "Female","","Chinese","Korean","Indian","Vietnamese","Japanese","Filipino","Asian language interview","US Born","Repeat taker")


## Length of var.names above does not match coef.vec.1 and se.vec.1, 
## so I just create temporal the vector with the same length.
#var.names <- c(paste("Cat A",seq(1,7,1)),"",
#             paste("Cat B",seq(1,14,1)),"",
#              paste("Cat C",seq(1,4,1)))


## if you don't want the legend
linkedfate2016_wolegend <- pcreate_single(coef.vec.1,se.vec.1,var.names, model.name="DV = Choose co-ethnic candidate",
                                    legloc="none")
linkedfate2016_wolegend

## Add titles and axis labels
linkedfate2016_wlab <- 
  linkedfate2016_wolegend+ 
  ggtitle("Predictors of pan-Asian \n linked fate \n 2016 post-election wave") + 
  ylab("Ordered logit coefficients") # note that axes are flipped
linkedfate2016_wlab

###############
## Save Plot ##
###############


png("ethniccongress_RR", height = 900, width = 1400, res=200)
ethniccongress_RR
dev.off()

dev.off()
png("asiancongress_RR", height = 900, width = 1400, res=200)
asiancongress_RR
dev.off()

png("2016post_linkedfate_RR", height = 900, width = 1400, res=200)
linkedfate2016_wlab
dev.off()