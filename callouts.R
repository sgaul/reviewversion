
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
             desc(all.students)), n = 30),
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

#Voter turnout for the state
voting <- read.csv('../reviewversion/voting.csv')

ddply(subset(voting, Type == "Municipal"),
      .(Date), 
      summarise,
      Percentage.Checked.as.Having.Voted =
        weighted.mean(Percentage.Checked.as.Having.Voted,
                      Names.on.Official.Check.List..Active.,na.rm = TRUE))

write.csv(ddply(merge(subset(voting, Type == "Municipal"),towns,by = "Town"),
                .(Towngroup, Date), summarise,
                Percentage.Checked.as.Having.Voted =
                  weighted.mean(Percentage.Checked.as.Having.Voted,
                                Names.on.Official.Check.List..Active.,na.rm = TRUE)),
          '../rawdata/voter-turnout.csv',
          row.names = FALSE)

#Total unemployment figures
laus <- read.csv("../regionalreport/data/laus.csv")
towns <- read.csv("../regionalreport/data/hartford-towns.csv")
laus <- merge(laus, towns)
laus <- cast(laus, Year + Town + Towngroup + Date ~ Type, value = "Value")

ddply(subset(ddply(laus, .(Year, Town, Towngroup), summarise,
             EMP = mean(EMP, na.rm = T),
             LF = mean(LF, na.rm = T),
             UN = mean(UN, na.rm = T)),
       Year == 2013),
      .(Towngroup),
      summarise,
      EMP = sum(EMP, na.rm = T),
      LF = sum(LF, na.rm = T),
      UN = sum(UN, na.rm = T))

#Race / ethnicity changes
demo <- read.csv('../reviewversion/race-ethnicity.csv')
demo <- merge(demo,towns)

demo_agg <- melt(ddply(demo, .(Towngroup, Year), summarise,
      White = sum(White.alone.or.in.combination.with.one.or.more.other.races),
      Black = sum(Black.or.African.American.alone.or.in.combination.with.one.or.more.other.races),
      Asian = sum(Asian.alone.or.in.combination.with.one.or.more.other.races),
      Latino = sum(Hispanic.or.Latino.)), id.vars = c("Towngroup","Year"))

#By town group
ggplot(data = demo_agg, aes(x = Year, y = value)) + 
  geom_line(aes(group = Towngroup, colour = Towngroup)) + 
  facet_wrap(~ variable, scales = "free") +
  theme_minimal() + 
  labs(x = NULL, y = "Population") + 
  scale_y_continuous(labels = comma)

#By race
ggplot(data = demo_agg, aes(x = Year, y = value)) + 
  geom_line(aes(group = variable, colour = variable)) + 
  facet_wrap(~ Towngroup) +
  theme_minimal() + 
  labs(x = NULL, y = "Population") + 
  scale_y_continuous(labels = comma)

#Majority-minority
majmin <- ddply(demo, .(Town, Year), summarise,
      White = sum(White.alone.or.in.combination.with.one.or.more.other.races),
      Black = sum(Black.or.African.American.alone.or.in.combination.with.one.or.more.other.races),
      Asian = sum(Asian.alone.or.in.combination.with.one.or.more.other.races),
      Latino = sum(Hispanic.or.Latino.))

majmin$minority = (1 - majmin$White / (majmin$Black + majmin$Asian + majmin$Latino + majmin$White))

#Load map
library(maps)
library(maptools)
CTTowns <- readShapeSpatial(fn="../townshp/wgs84/townct_37800_0000_2010_s100_census_1_shp_wgs84")

#Fortify and order the CTTowns to allow ggmap to use that
CTTowns <- fortify(CTTowns, region = "NAME10")

library(classInt)
jenks <- classIntervals(majmin$minority, 
                        n=3, style="fisher")
choropleth=merge(CTTowns, majmin, by.x = "id", by.y="Town")
choropleth=choropleth[order(choropleth$order), ]
choropleth$minority= cut(choropleth$minority, breaks=jenks$brks, include.lowest=T, dig.lab = T)
#Make the map
ggplot(data = choropleth, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = minority)) + 
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  labs(x = NULL, y = NULL) + 
  coord_equal() +
  geom_polygon(data = CTTowns, colour = "grey", alpha = 0.5, fill = NA) +
  scale_fill_brewer(palette = "Purples", name = "% non-white") +
  theme_minimal(base_size = 16) + 
  facet_wrap(~ Year, ncol = 1)

#By town
demo <- melt(ddply(demo, .(Town, Year), summarise,
                       White = sum(White.alone.or.in.combination.with.one.or.more.other.races),
                       Black = sum(Black.or.African.American.alone.or.in.combination.with.one.or.more.other.races),
                       Asian = sum(Asian.alone.or.in.combination.with.one.or.more.other.races),
                       Latino = sum(Hispanic.or.Latino.)), id.vars = c("Town","Year"))

ggplot(data = demo, aes(x = Year, y = value)) + 
  geom_line(aes(group = variable, colour = variable)) + 
  facet_wrap(~ Town, scales = "free") +
  theme_minimal() + 
  labs(x = NULL, y = "Population") + 
  scale_y_continuous(labels = comma)

#Re-entry factoid

reentry <- read.csv("../hodgepodge/reentry.csv")
reentry <- melt(reentry, id = c("TOWN","YEAR"))
reentry <- ddply(reentry, .(YEAR, TOWN), summarise, value = sum(value))

towns$TOWN = toupper(towns$Town)
reentry <- merge(reentry, towns, by = "TOWN")
ddply(reentry, .(Towngroup, YEAR), summarise, sum = sum(value))

#Job growth again
qcew <- read.csv('../mockup/qcewannual-t.csv')

qcew <- rbind(qcew,
              ddply(subset(qcew,naicsector > 100), .(area,series,year), summarise,
                    naicsector = 31,
                    sectortitle = "Manufacturing",
                    value = sum(value)))

jobgrowth <- cast(subset(qcew, series == "Employees" &
                           area == "North Central" &
                           naicsector < 100 & 
                           year %in% c(2013, 2003, 1993, 2008, 2012)),
                  sectortitle ~ year)
names(jobgrowth) <- make.names(names(jobgrowth))
jobgrowth$growth20yr = jobgrowth$X2013 / jobgrowth$X1993 - 1
jobgrowth$growth10yr = jobgrowth$X2013 / jobgrowth$X2003 - 1
jobgrowth$growth5yr = jobgrowth$X2013 / jobgrowth$X2008 - 1
jobgrowth$growth1yr = jobgrowth$X2013 / jobgrowth$X2012 - 1

write.csv(jobgrowth,'jobgrowth.csv',row.names = F)

ggplot(data = subset(qcew, series == "Employees" &
                       area == "North Central" & value > 10000), 
       aes(y = value, x = year)) + 
  geom_line(aes(group = area)) +
  theme_minimal(base_size = 16) +
  labs(y = "Number of employees", x = NULL) +
  scale_x_continuous(breaks = c(1993,2003,2013)) +
  scale_y_continuous(labels = comma, lim = c(10000,100000)) + 
  facet_wrap(~ sectortitle, ncol = 3)