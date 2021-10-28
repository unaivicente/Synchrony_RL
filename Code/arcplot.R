library(reshape2)
library(reshape)
library(tidyverse)
library(igraph)
library(colorRamps)
library(ggplot2)
library(wesanderson)
library(arcdiagram)
library(tidygraph)
library(ggraph)


hypothesys <- c('NEW1','NEW','NEWBhv1','NEWBhv','NEWAdjH','NEWAdjL')
freq <- c('4', '8', '13', '38','N_4','N_8','N_13','N_38' )

hyp <- expand.grid(a = hypothesys)
fdf <- expand.grid(a = freq)

for (h in 1:nrow(hyp)){
    for (f in 1:nrow(fdf)){
   
    grph <- read.csv(sprintf('%s_Results_dyadmatrixALL_%s.csv', hyp$a[h], fdf$a[f]), sep=',', header=TRUE)
    ord <- read.csv("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/NEW/order.csv", sep = ';', header= FALSE)
    colnames(ord) <- c('Elec1','Elec2','Order','Connection')

    grph$Connection <- str_replace(grph$Connection, "[[:punct:][:blank:]]+", ":")
    grph$Elec1 <- gsub('(.*):.*','\\1',grph$Connection)#Extract Elec1
    grph$Elec2 <- gsub('.*:(.*)','\\1',grph$Connection)#EXtract Elec2

    #Extract mastoids M1-M2
    grph <- grph[!(grph$Elec1 == 'M1'|grph$Elec2 == 'M1'),]
    grph <- grph[!(grph$Elec1 == 'M2'|grph$Elec2 == 'M2'),]

    grph <- merge(grph, ord)
    grph <- grph[order(grph$Order),]
    rownames(grph) <- 1:nrow(grph)


    #Distinguish families and Electrodes
    grph$family1 <- recode(grph$Elec1, "Fp1"="fronp", "Fp2"="fronp", "F7"="fron", "F3"="fron", "Fz"="fron", "F4"="fron",
                       "F8"="fron","FC5"="fronc", "FC1"="fronc", "FC2"="fronc", "FC6"="fronc", "C3"="cen", "Cz"="cen",
                       "C4"="cen","CP5"="cenpar", "CP1"="cenpar", "CP2"="cenpar", "CP6"="cenpar", "P7"="par", "P3"="par",
                       "Pz"="par","P4"="par","P8"="par", "POz"="paroc", "Oz"="occ")
    grph$family2 <- recode(grph$Elec2, "Fp1"="fronp", "Fp2"="fronp", "F7"="fron", "F3"="fron", "Fz"="fron", "F4"="fron",
                       "F8"="fron","FC5"="fronc", "FC1"="fronc", "FC2"="fronc", "FC6"="fronc", "C3"="cen", "Cz"="cen",
                       "C4"="cen","CP5"="cenpar", "CP1"="cenpar", "CP2"="cenpar", "CP6"="cenpar", "P7"="par", "P3"="par",
                       "Pz"="par","P4"="par","P8"="par", "POz"="paroc", "Oz"="occ")

    grph$Elec1 <- recode(grph$Elec1, "Fp1"="Fp1_1", "Fp2"="Fp2_1", "F7"="F7_1", "F3"="F3_1", "Fz"="Fz_1", "F4"="F4_1", 
                     "F8"="F8_1","FC5"="FC5_1", "FC1"="FC1_1", "FC2"="FC2_1", "FC6"="FC6_1", "C3"="C3_1", "Cz"="Cz_1", 
                     "C4"="C4_1","CP5"="CP5_1", "CP1"="CP1_1", "CP2"="CP2_1", "CP6"="CP6_1", "P7"="P7_1", "P3"="P3_1", 
                     "Pz"="Pz_1","P4"="P4_1","P8"="P8_1", "POz"="POz_1", "Oz"="Oz_1")

    grph$Elec2 <- recode(grph$Elec2, "Fp1"="Fp1_2", "Fp2"="Fp2_2", "F7"="F7_2", "F3"="F3_2", "Fz"="Fz_2", "F4"="F4_2", 
                     "F8"="F8_2","FC5"="FC5_2", "FC1"="FC1_2", "FC2"="FC2_2", "FC6"="FC6_2", "C3"="C3_2", "Cz"="Cz_2", 
                     "C4"="C4_2","CP5"="CP5_2", "CP1"="CP1_2", "CP2"="CP2_2", "CP6"="CP6_2", "P7"="P7_2", "P3"="P3_2", 
                     "Pz"="Pz_2","P4"="P4_2","P8"="P8_2", "POz"="POz_2", "Oz"="Oz_2")

    grph$Elec1 <- factor(grph$Elec1, levels = unique(grph$Elec1))
    grph$Elec2 <- factor(grph$Elec2, levels = unique(grph$Elec2))

    grph_n <- grph[,c(2:3,7)]
    grph_n$Null_Hyp <- !grph_n$Null_Hyp

    # Build the incidence matrix in which the graph will be based
    inc_mat <- xtabs(Null_Hyp ~ ., grph_n)

    # Build graph network
    net <- graph_from_incidence_matrix(inc_mat)

    # Make Vertex families to introduce attributes in the network
    vertexfam <- grph[grph$Null_Hyp==FALSE,]
    vertexfam <- vertexfam[,c(2:3,10:11)]
    
    vert1 <- vertexfam[!duplicated(vertexfam$Elec1),]
    vert2 <- vertexfam[!duplicated(vertexfam$Elec2),]
    vert2 <- vert2[order(vert2$Elec2),]

    # Write attributes into the "net" graph object
    for (i in 1:length(V(net))){
      tvrtx <- V(net)[i]$name
      if (isTRUE(tvrtx %in% vert1$Elec1) == TRUE) {
        temp <- vert1[vert1$Elec1 == tvrtx,]
        V(net)[i]$family <- temp[1,3] #family 1
        V(net)[i]$group <- "1" #group
    
      }else if (isTRUE(tvrtx %in% vert2$Elec2) == TRUE) {
        temp <- vert2[vert2$Elec2 == tvrtx,]
        V(net)[i]$family <- temp[1,4] #family 2
        V(net)[i]$group <- "2" #group
      }else{
        next
      }
    }
    
    # #List of all electrodes
    elec <- c("Fp1","Fp2","F7","F3","Fz","F4","F8","FC5","FC1","FC2","FC6","C3","Cz","C4","CP5","CP1","CP2","CP6","P7","P3","Pz","P4","P8","POz","Oz",NA,NA,
              "Fp1","Fp2","F7","F3","Fz","F4","F8","FC5","FC1","FC2","FC6","C3","Cz","C4","CP5","CP1","CP2","CP6","P7","P3","Pz","P4","P8","POz","Oz")
    
    
    edgelist <- get.edgelist(net)
    # get vertex labels
    label <- get.vertex.attribute(net, "name")
    # get vertex groups
    group <- get.vertex.attribute(net, "group")
    # get family
    family <- get.vertex.attribute(net, "family")
    # get vertex degree
    degrees <- degree(net)

    if (nrow(vertexfam) > 0){
        # data frame with groups, degree, labels and id
        nodes <- data.frame(group, label, degrees, family)
        nodes$family <- factor(nodes$family, levels = unique(nodes$family))
        nodes$label <- factor(nodes$label, levels = unique(nodes$label))
        vec <- rep(NA, length(nodes))
        nodes <- rbind(nodes[1:25, ], vec, vec, nodes[- (1:25), ]) #in between the first nodes add a dummy
        nodes <- as_tibble(nodes)
        

        # prepare data for edges
        edges <- as_tibble(edgelist, .name_repair = 'unique')
        
        #link families to first output families
        edgescolor <- edges
        colnames(edgescolor) <- c('Elec1','Elec2')
        edgescolor$edgefam <- recode(edgescolor$Elec1, "Fp1_1"="fronp", "Fp2_1"="fronp", "F7_1"="fron", "F3_1"="fron", "Fz_1"="fron", "F4_1"="fron",
                                        "F8_1"="fron","FC5_1"="fronc", "FC1_1"="fronc", "FC2_1"="fronc", "FC6_1"="fronc", "C3_1"="cen", "Cz_1"="cen",
                                        "C4_1"="cen","CP5_1"="cenpar", "CP1_1"="cenpar", "CP2_1"="cenpar", "CP6_1"="cenpar", "P7_1"="par", "P3_1"="par",
                                        "Pz_1"="par","P4_1"="par","P8_1"="par", "POz_1"="paroc", "Oz_1"="occ")
        edges$fam <- edgescolor$edgefam
        
        #prepare color palette
        palette <- wes_palette("Zissou1", (length(unique(nodes$family))-1), type = "continuous")
        
        net.tidy <- tbl_graph(nodes = nodes, edges = edges, directed = TRUE, node_key = "label")
  
        plot <- ggraph(net.tidy, layout = "linear") + 
                geom_edge_arc(alpha = 0.5) + 
                              #, aes(color = fam)) +
                #scale_edge_colour_manual(values = palette) +
                scale_edge_width(range = c(0.2, 2)) +
                scale_colour_manual(values= palette) +
                geom_node_point(aes(size = degrees, color = family)) +
                geom_node_text(aes(label = elec), angle = 90, hjust = 1, nudge_y = -0.5, size = 3) +   
                coord_cartesian(clip = "off") + 
                theme_graph(base_family = 'Helvetica') +
                theme(legend.position = "right")

         ggsave(sprintf('arc_%s_dyadmatrixALL_%s.pdf', hyp$a[h], fdf$a[f]), plot, device = cairo_pdf, width = 30, height = 20, units="cm")
        }else{
          next
      }
  }
}


