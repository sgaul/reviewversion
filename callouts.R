
#Refugee arrivals since 2003
ddply(subset(refugees, textbox14 >= 2000), 
      .(TownType),
      summarise,
      count = sum(textbox18))

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

