require("tidyr")
require("dplyr")
require("ggplot2")
require("jsonlite")
require("RCurl")
require("grid")

# creating visualizations
p1 = dplyr::filter(df, X13.1_AdultHeadBodyLen_mm != -999, X8.1_AdultForearmLen_mm != -999) %>% 
  ggplot() + geom_point(aes(x=X13.1_AdultHeadBodyLen_mm, y=X8.1_AdultForearmLen_mm, color = MSW05_Order)) +
  scale_color_discrete (guide=guide_legend(title = "Order")) +
  labs(x="Adult Head Body Length (mm)", y="Adult Forearm Length (mm)", size=20)


p2 = ggplot(data = df) + 
  geom_point(aes(x = MSW05_Order, y =X13.1_AdultHeadBodyLen_mm, color = MSW05_Order, alpha=0.5)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  labs(title= "Adult Body Head Size", y = "Adult Body Head Size (mm)", x = "Order Classification") +
  theme(axis.text.x=element_text(size=10, vjust=0.5)) +
  theme(axis.text.y=element_text(size=20, hjust=0.5)) +
  theme(plot.title = element_text(size=22)) +
  scale_fill_discrete(name="Orders")

cleardf <- dplyr::filter(df, X17.1_MaxLongevity_m != -999)
onlydf <- dplyr::select(cleardf, MSW05_Order, X17.1_MaxLongevity_m)
groupdf <- dplyr::group_by(onlydf, MSW05_Order)
alphadf <- dplyr::arrange(onlydf, MSW05_Order)

groupdf$MSW05_Order <- factor(alphadf$MSW05_Order,labels = c("Afrosoricida", "Artiodactyla", "Carnivora", "Cetacea", "Chiroptera","Cingulata", "Dasyuromorphia", "Dermoptera", "Didelphimorphia", "Diprotodontia","Erinaceomorpha", "Hyracoidea", "Lagomorpha", "Macroscelidea", "Microbiotheria","Monotremata", "Notoryctemorphia", "Peramelemorphia", "Perissodactyla", "Pholidota","Pilosa", "Primates", "Proboscidea", "Rodentia", "Scandentia","Sirenia", "Soricomorpha", "Tubulidentata"))

p3 = ggplot(data=alphadf, aes(x=MSW05_Order, y=X17.1_MaxLongevity_m, color=MSW05_Order)) + geom_boxplot() + ggtitle("Longevity of Orders") + labs(x = "Order") + labs (y = "Longevity in Months") + theme(axis.text.x = element_text(angle = 90, hjust = 1))

p4 = dplyr::filter(df, X23.1_SexualMaturityAge_d != -999 & X17.1_MaxLongevity_m > 0) %>% 
  ggplot() +
  geom_point(aes(x=X17.1_MaxLongevity_m, y=X23.1_SexualMaturityAge_d, color=MSW05_Order)) +
  scale_color_discrete (guide=guide_legend(title = "Order", keywidth = 5, keyheight = 2)) +
  theme(legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  theme(axis.text.x=element_text(size=20), axis.text.y=element_text(size=20)) +
  theme(axis.title=element_text(size=20,face="bold")) +
  # theme(labs.text.x=element_text(size=20), axis.text.y=element_text(size=20)) +
  # theme(labs.text.x=element_text(size=20), y=element_text(size=20)) +
  labs(x="Max Longevity (months)", y="Sexual Maturity Age (days)", size=20)

# set up png
png("dv.project2.png", width = 25, height = 20, units = "in", res = 128)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))

# print plots
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(p3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(p4, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))

dev.off()
