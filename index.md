---
title       : Review version of top indicators
subtitle    : Hartford regional indicators
author      : 
job         : Community Indicators Project
framework   : io2012        # {io2012, html5slides, shower, dzslides, minimal ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
ext_widgets : {rCharts: ["libraries/nvd3"]} 
mode        : selfcontained # {standalone, draft}

--- &twocol
## Outline of indicators

*** =left
Snapshot / demographics
* Population / diversity
* Commuting patterns
* School enrollment
* Income levels or poverty rates

Education
* 3rd grade reading
* High school graduation rate
* Chronic absenteeism

*** =right
Workforce / economy / talent
* Educational attainment
* Unemployment rate
* Job growth (need to add)

Quality of life / community
* Home-ownership / affordable housing
* Crime rate
* Voter turnout

---
## Key themes

1. Regionalism
2. Suburbanization of poverty
3. Concentration of poverty in Hartford
4. Achievement gap
5. Middle skills gap
6. Aging workforce
7. Civic health
8. Global region

---
## Flat population growth

Themes: regionalism, suburbanization of poverty  
Key points: population loss in Hartford, flat population growth in suburbs



 
 

<div id = 'chart1' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart1()
    });
    function drawchart1(){  
      var opts = {
 "dom": "chart1",
"width":    700,
"height":    425,
"x": "period",
"y": "sumpop",
"group": "Towngroup",
"type": "lineChart",
"id": "chart1" 
},
        data = [
 {
 "period": 1900,
"Towngroup": "Hartford",
"sumpop": 79850,
"sumpoor": null 
},
{
 "period": 1900,
"Towngroup": "Rural",
"sumpop": 5136,
"sumpoor": null 
},
{
 "period": 1900,
"Towngroup": "Suburban",
"sumpop": 30970,
"sumpoor": null 
},
{
 "period": 1900,
"Towngroup": "Urban periphery",
"sumpop": 43141,
"sumpoor": null 
},
{
 "period": 1910,
"Towngroup": "Hartford",
"sumpop": 98915,
"sumpoor": null 
},
{
 "period": 1910,
"Towngroup": "Rural",
"sumpop": 5386,
"sumpoor": null 
},
{
 "period": 1910,
"Towngroup": "Suburban",
"sumpop": 33905,
"sumpoor": null 
},
{
 "period": 1910,
"Towngroup": "Urban periphery",
"sumpop": 55132,
"sumpoor": null 
},
{
 "period": 1920,
"Towngroup": "Hartford",
"sumpop": 138036,
"sumpoor": null 
},
{
 "period": 1920,
"Towngroup": "Rural",
"sumpop": 5803,
"sumpoor": null 
},
{
 "period": 1920,
"Towngroup": "Suburban",
"sumpop": 38294,
"sumpoor": null 
},
{
 "period": 1920,
"Towngroup": "Urban periphery",
"sumpop": 71399,
"sumpoor": null 
},
{
 "period": 1930,
"Towngroup": "Hartford",
"sumpop": 164072,
"sumpoor": null 
},
{
 "period": 1930,
"Towngroup": "Rural",
"sumpop": 6162,
"sumpoor": null 
},
{
 "period": 1930,
"Towngroup": "Suburban",
"sumpop": 43919,
"sumpoor": null 
},
{
 "period": 1930,
"Towngroup": "Urban periphery",
"sumpop": 104324,
"sumpoor": null 
},
{
 "period": 1940,
"Towngroup": "Hartford",
"sumpop": 166267,
"sumpoor": null 
},
{
 "period": 1940,
"Towngroup": "Rural",
"sumpop": 6641,
"sumpoor": null 
},
{
 "period": 1940,
"Towngroup": "Suburban",
"sumpop": 51271,
"sumpoor": null 
},
{
 "period": 1940,
"Towngroup": "Urban periphery",
"sumpop": 120848,
"sumpoor": null 
},
{
 "period": 1950,
"Towngroup": "Hartford",
"sumpop": 177397,
"sumpoor": null 
},
{
 "period": 1950,
"Towngroup": "Rural",
"sumpop": 8524,
"sumpoor": null 
},
{
 "period": 1950,
"Towngroup": "Suburban",
"sumpop": 66268,
"sumpoor": null 
},
{
 "period": 1950,
"Towngroup": "Urban periphery",
"sumpop": 166002,
"sumpoor": null 
},
{
 "period": 1960,
"Towngroup": "Hartford",
"sumpop": 162178,
"sumpoor": null 
},
{
 "period": 1960,
"Towngroup": "Rural",
"sumpop": 12973,
"sumpoor": null 
},
{
 "period": 1960,
"Towngroup": "Suburban",
"sumpop": 117468,
"sumpoor": null 
},
{
 "period": 1960,
"Towngroup": "Urban periphery",
"sumpop": 253926,
"sumpoor": null 
},
{
 "period": 1970,
"Towngroup": "Hartford",
"sumpop": 158017,
"sumpoor":          26863 
},
{
 "period": 1970,
"Towngroup": "Rural",
"sumpop": 17505,
"sumpoor": null 
},
{
 "period": 1970,
"Towngroup": "Suburban",
"sumpop": 168469,
"sumpoor": null 
},
{
 "period": 1970,
"Towngroup": "Urban periphery",
"sumpop": 325916,
"sumpoor": null 
},
{
 "period": 1980,
"Towngroup": "Hartford",
"sumpop": 136392,
"sumpoor":          34371 
},
{
 "period": 1980,
"Towngroup": "Rural",
"sumpop": 19542,
"sumpoor":           1219 
},
{
 "period": 1980,
"Towngroup": "Suburban",
"sumpop": 196648,
"sumpoor":           5675 
},
{
 "period": 1980,
"Towngroup": "Urban periphery",
"sumpop": 315897,
"sumpoor":          14358 
},
{
 "period": 1990,
"Towngroup": "Hartford",
"sumpop": 139739,
"sumpoor":          38428 
},
{
 "period": 1990,
"Towngroup": "Rural",
"sumpop": 21729,
"sumpoor":            705 
},
{
 "period": 1990,
"Towngroup": "Suburban",
"sumpop": 226612,
"sumpoor":           5341 
},
{
 "period": 1990,
"Towngroup": "Urban periphery",
"sumpop": 321324,
"sumpoor":          11873 
},
{
 "period": 2000,
"Towngroup": "Hartford",
"sumpop": 121578,
"sumpoor":          37203 
},
{
 "period": 2000,
"Towngroup": "Rural",
"sumpop": 23271,
"sumpoor":            958 
},
{
 "period": 2000,
"Towngroup": "Suburban",
"sumpop": 249706,
"sumpoor":           7736 
},
{
 "period": 2000,
"Towngroup": "Urban periphery",
"sumpop": 326765,
"sumpoor":          19044 
},
{
 "period": 2010,
"Towngroup": "Hartford",
"sumpop": 124775,
"sumpoor":          40053 
},
{
 "period": 2010,
"Towngroup": "Rural",
"sumpop": 25909,
"sumpoor":           1205 
},
{
 "period": 2010,
"Towngroup": "Suburban",
"sumpop": 270796,
"sumpoor":           9245 
},
{
 "period": 2010,
"Towngroup": "Urban periphery",
"sumpop": 336031,
"sumpoor":          26451 
},
{
 "period": 2015,
"Towngroup": "Hartford",
"sumpop": 125999,
"sumpoor": null 
},
{
 "period": 2015,
"Towngroup": "Rural",
"sumpop": 38388,
"sumpoor": null 
},
{
 "period": 2015,
"Towngroup": "Suburban",
"sumpop": 277497,
"sumpoor": null 
},
{
 "period": 2015,
"Towngroup": "Urban periphery",
"sumpop": 341742,
"sumpoor": null 
},
{
 "period": 2020,
"Towngroup": "Hartford",
"sumpop": 126656,
"sumpoor": null 
},
{
 "period": 2020,
"Towngroup": "Rural",
"sumpop": 38911,
"sumpoor": null 
},
{
 "period": 2020,
"Towngroup": "Suburban",
"sumpop": 282476,
"sumpoor": null 
},
{
 "period": 2020,
"Towngroup": "Urban periphery",
"sumpop": 346788,
"sumpoor": null 
},
{
 "period": 2025,
"Towngroup": "Hartford",
"sumpop": 126185,
"sumpoor": null 
},
{
 "period": 2025,
"Towngroup": "Rural",
"sumpop": 39463,
"sumpoor": null 
},
{
 "period": 2025,
"Towngroup": "Suburban",
"sumpop": 286373,
"sumpoor": null 
},
{
 "period": 2025,
"Towngroup": "Urban periphery",
"sumpop": 350406,
"sumpoor": null 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .x(function(d) { return d[opts.x] })
          .y(function(d) { return d[opts.y] })
          .width(opts.width)
          .height(opts.height)
         
        chart
  .forceY([      0, 3.5e+05 ])
          
        chart.xAxis
  .axisLabel("Year")

        
        
        chart.yAxis
  .tickFormat(function(d) {return d3.format(',.0f')(d)})
  .axisLabel("Population")
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>


---
## Aging population (?)

Themes: regionalism, aging workforce  
Key points: aging population in suburbs, talent pipeline from Hartford

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1.png) 


--- 
## Linguistic diversity

Themes: Global region, achievement gap, suburbanization of poverty   
Key points: Suburbs more diverse, ELL students in public school systems.

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 


--- 
## School choice unique to region

Themes: Regionalism, disparities  
Key points: Integration through school system, districts not the same as towns.

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3.png) 


--- 
## Everyone commutes, mostly to Hartford

Themes: Regionalism, background for aging workforce  
Key points: Every town sends workers to Hartford; job center

![image](../mockup/commute-patterns.png)

--- 
## Suburbanization of poverty

Themes: suburbanization of poverty  
Key points: Poverty growing fastest in suburbs

![plot of chunk unnamed-chunk-4](assets/fig/unnamed-chunk-4.png) 


--- 
## Income inequality

Themes: suburbanization, concentration of poverty  
Key points: Affluent suburbs, inner-ring suburbs have many low-income neighborhoods

![plot of chunk unnamed-chunk-5](assets/fig/unnamed-chunk-5.png) 


--- 
## Achievement gap starts early

Themes: Achievement gap, global region  
Key points: Everybody improving, but gaps remain for subgroups

![plot of chunk unnamed-chunk-6](assets/fig/unnamed-chunk-6.png) 

--- 
## Chronic absenteeism an early warning sign

Themes: Suburbanization of poverty  
Key points: Some rural districts with high rates, otherwise same as others

![plot of chunk unnamed-chunk-7](assets/fig/unnamed-chunk-7.png) 

--- 
## High-school graduation rising, but with gaps

Themes: Achievement gap, middle skills gap  
Key points: HS graduates are talent pipeline, need to address disparities

![plot of chunk unnamed-chunk-8](assets/fig/unnamed-chunk-8.png) 

--- 
## Skilled workforce now, but need to look ahead

Themes: Middle skills jobs, Achievement gap  
Key points: Connect workforce to schools, aging workforce

![plot of chunk unnamed-chunk-9](assets/fig/unnamed-chunk-9.png) 

--- 
## Jobs (key sectors > 20K employees in region)

Themes: Middle skills jobs, aging workforce  
Key points: Eroding regional strengths in finance and manufacturing, growth in healthcare

![plot of chunk unnamed-chunk-10](assets/fig/unnamed-chunk-10.png) 


--- 
## Manufacturing jobs (> 50 establishments)

Themes: Middle skills jobs, aging workforce  
Key points: Which manufacturing businesses are growing in the region?

![plot of chunk unnamed-chunk-11](assets/fig/unnamed-chunk-11.png) 


--- 
## Youth unemployment highest

Themes: Aging workforce, middle skills gap  
Key points: 16 to 24 cohort are opportunity youth, future workforce

![plot of chunk unnamed-chunk-12](assets/fig/unnamed-chunk-12.png) 


--- 
## Home ownership sign of civic health (replace w/ map)

Themes: Civic health, concentration of poverty  
Key points: Housing market divided, higher mobility in Hartford

![plot of chunk unnamed-chunk-13](assets/fig/unnamed-chunk-13.png) 


--- 
## Affordable housing

Themes: Concentration of poverty  
Key points: Affordable housing limited to few towns

![plot of chunk unnamed-chunk-14](assets/fig/unnamed-chunk-14.png) 


--- 
## Hartford safest in 30 years

Themes: Civic health  
Key points: Progress on reducing crime, perception v. reality

![plot of chunk unnamed-chunk-15](assets/fig/unnamed-chunk-15.png) 


--- 
## Voter turnout another measure of civic health

Themes: Civic health  
Key points: Connect to home-ownership

![plot of chunk unnamed-chunk-16](assets/fig/unnamed-chunk-16.png) 


