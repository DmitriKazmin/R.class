innate <- innate[order(match(innate$SUBGROUP,
                             c("INTERFERON/ANTIVIRAL SENSING", 
                               "INFLAMMATORY/TLR/CHEMOKINES",
                               "ANTIGEN PRESENTATION", 
                               "DC ACTIVATION", 
                               "NK CELLS", 
                               "MONOCYTES", 
                               "NEUTROPHILS"))), ]
innate$NAME <- factor(innate$NAME, levels <- rev(unique(innate$NAME)))
ggplot(innate,  aes(x = time, y = NAME)) + 
  geom_point(aes(size = ABS.NES, colour = Direction, alpha=Significant)) + 
  scale_alpha_discrete(range=c(0.15, 0.6)) + 
  scale_radius(trans="exp", range = c(1,25)) + 
  scale_colour_manual(values=fill) + 
  theme(axis.text.x = element_text(angle=90, hjust=1), axis.title.x=element_blank(), axis.title.y=element_blank()) + 
  ggtitle(label="RRR vaccination, Innate modules") +
  theme(panel.background = element_blank())