
#Refugee arrivals since 2003
refugees <- read.csv('Arrivals by Destination and Natoinality.csv')
refugees <- subset(refugees, refugees$textbox12City %in% levels(towns$Town))
refugees$textbox12City <- factor(refugees$textbox12City)

refugees$textbox14 <- gsub(pattern = "CY ",replacement = "",refugees$textbox14)

refugees$TownType = ifelse(refugees$textbox12City == "Hartford","Hartford","Suburbs")


ddply(subset(refugees, textbox14 >= 2000), 
      .(TownType),
      summarise,
      count = sum(textbox18))

head(arrange(ddply(refugees,.(textbox6),
                   summarise,
                   count = sum(textbox18)),
             desc(count)), n = 10)

#Change in population from 2003 to 2012
gh <- read.csv("../regionalreport/data/greaterhartford.csv")
gh$poppoverty <- round((gh$poppovertyrate / 100) * gh$population,0)
towns <- read.csv("../regionalreport/data/hartford-towns.csv")
ddply(merge(subset(gh, period %in% c(2000, 2012)),
            towns,
            by.x = "city", by.y = "Town"),
      .(period,Towngroup), 
      summarise, 
      sumpop = sum(population),
      sumpoor = sum(poppoverty))

#Languages
languages <- read.csv('../reviewversion/Languages-all.csv', na.strings = c("**","-"))
districts <- read.csv("../regionalreport/data/hartford-districts.csv")
languages <- merge(languages, districts, by.x = "District.Name", by.y = "district")

#Language overall
unique(languages$Languages)

#Top 10 for all students
write.csv(
  head(arrange(ddply(languages, .(Languages), summarise,
                   all.students = sum(Number.of.Students.with.Non.English.Home.Language, na.rm = TRUE),
                   ell.students = sum(Number.of.ELL.Students, na.rm = TRUE)),
             desc(all.students)), n = 10),
  "../rawdata/toplanguages-all.csv",row.names = FALSE)

#Top 10 for ELL
write.csv(
  head(arrange(ddply(languages, .(Languages), summarise,
                     all.students = sum(Number.of.Students.with.Non.English.Home.Language, na.rm = TRUE),
                     ell.students = sum(Number.of.ELL.Students, na.rm = TRUE)),
               desc(ell.students)), n = 10),
  "../rawdata/toplanguages-ell.csv",row.names = FALSE)

#Age range for population over time
age_agg <- 
  merge(ddply(projections, .(AGE,Towngroup,YEAR), summarise, sum = sum(value)),
      ddply(projections, .(Towngroup,YEAR), summarise, sum = sum(value)),
      by = c("YEAR","Towngroup"))

age_agg$percent = age_agg$sum.x / age_agg$sum.y

write.csv(age_agg[c(1:3,6)],"../rawdata/agegroups.csv",row.names = FALSE)

#Affordable housing trends
appeals <- read.csv('../housingcost/appeals-list-2012.csv')

#appeals <- subset(appeals, appeals$Town %in% levels(towns$Town))

appeals12 <- subset(appeals, Year == 2012)

appeals$Town <-factor(appeals$Town, levels=appeals12[order(-appeals12$Percent.Affordable), 
                                                     "Town"])

ggplot(data = appeals, aes(y = Percent.Affordable, x = Year)) + 
  geom_line(aes(group = Town), colour = "blue", size = 0.8, alpha = 0.4) + 
  scale_y_continuous(labels = percent, breaks = c(0,.1,.3)) + 
  scale_x_continuous(breaks = c(2009,2011)) + 
  theme_minimal() +
  labs(y = "% affordable housing units", x = NULL) + 
  facet_wrap(~ Town, ncol = 5)

appeals_chg <- cast(subset(appeals, Year %in% c(2008, 2012))[c(1,3,10)], Town ~ Year)
names(appeals_chg) <- make.names(names(appeals_chg))
appeals_chg$change = appeals_chg$X2012 - appeals_chg$X2008

library(classInt)
jenks <- classIntervals(appeals_chg$change, 
                        n=3, style="fisher")
choropleth=merge(CTTowns, appeals_chg, by.x = "id", by.y="Town")
choropleth=choropleth[order(choropleth$order), ]
choropleth$change=cut(choropleth$change, 
                                  breaks=jenks$brks,
                                  include.lowest=T, dig.lab = T)
#Make the map
ggplot(data = choropleth, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = change)) + 
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  labs(x = NULL, y = NULL) + 
  coord_equal() +
  geom_polygon(data = CTTowns, colour = "grey", alpha = 0.5, fill = NA) +
  scale_fill_brewer(palette = "Purples", name = "Change in \n% Affordable\nHousing\n(2008 - 2012)") +
  theme_minimal() 

#Languages by district
langdist <- merge(read.csv('../reviewversion/Languages-by-district.csv', na.strings = c("**","-")),
                  read.csv('../reviewversion/ELL-by-district.csv', na.strings = c("**","-")))

langdist <- merge(langdist, districts, by.x = "District.ID", by.y = "districtid")
langdist$Percent.NonEnglish = round((langdist$Number.of.Students.with.Non.English.Home.Language / langdist$Total.Enrollment)*100,1)

write.csv(langdist,'../rawdata/percent-ELL-non-English.csv',row.names = F)

ggplot(data = ddply(langdist,.(School.Year),
                   summarise,
                   Percent.NonEnglish = weighted.mean(Percent.NonEnglish,Total.Enrollment, na.rm = T),
                   Percentage.ELL = weighted.mean(Percentage.ELL,Total.Enrollment, na.rm = T))) + 
  geom_line(aes(x = School.Year, y = Percentage.ELL, group = "")) + 
  geom_line(aes(x = School.Year, y = Percent.NonEnglish, group = "")) + 
  ylim(0,20) + 
  theme_minimal()
