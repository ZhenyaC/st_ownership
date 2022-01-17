library(plotly)
#df<-read.csv("test3")
#df$hover <- with(df, paste(state, '<br>', "Beef", beef, "Dairy", dairy, "<br>",
                         #  "Fruits", total.fruits, "Veggies", total.veggies,
                         #  "<br>", "Wheat", wheat, "Corn", corn))
CODE<- read_csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")



l <- list(color = toRGB("grey"), width = 0.5)

g <-list(
  scope = "south america",
  visible = F,
  showcountries = T,
  countrycolor = toRGB("Purple"),
  resolution = 50,
  showland = TRUE,
  landcolor = toRGB("#e5ecf6")

)
fig <- plot_geo(pct_ch_per_county)

fig <- fig %>% add_trace(
  z = ~pct_ch, color = ~pct_ch, colors = 'Blues',
  text = ~country, locations = ~CODE, marker = list(line = l)
)

#fig <- plot_ly(type = 'scattergeo', mode = 'markers')
fig <- fig %>% layout(geo = g, title = "2021/2020 Spread Change (%)")
fig
 
  