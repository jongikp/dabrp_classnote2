library(ggplot2)
ggplot(data=mpg)+
  geom_point(aes(displ,hwy,
                 colour = class))


if (!require("gapminder")) install.packages("gapminder")
library(gapminder)
str(gapminder)

p <- ggplot(gapminder,
            aes(x = gdpPercap, y = lifeExp))
summary(p)

p_point <- p + geom_point()
p_point

# 실습 (ggplot)

# af <- gapminder[(gapminder$country == "Afghanistan"),]
# af <- subset(gapminder, gapminder$country =="Afghanistan")
af <- gapminder %>% filter(country == "Afghanistan")
af

gap_af <- ggplot(af,
                 aes(x = year, y = lifeExp))
gap_af

p_line <- gap_af + geom_line()
p_line

# scale 변경하기

p_point

## x 값에 로그 씌우기
ggplot(gapminder) + geom_point(aes(x = log10(gdpPercap),
                                   y = lifeExp))

p_point_log10 <- p_point + scale_x_log10()
p_point_log10

# color 정보 입히기
(p_point_color <- p + 
    geom_point(aes(color = continent)))

summary(p + geom_point(alpha = (1/3), size = 3 ))
summary(p + geom_point(aes(alpha = (1/3), size = 3) ))

p + geom_point(alpha = (1/3), size = 3)

p_point + stat_smooth()

p_point + geom_smooth(lwd = 2,
                      se = FALSE,
                      method = "lm")

p_point_color + geom_smooth(lwd = 2, se = FALSE)

p + aes(color = continent) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE)

(lp <- ggplot(gapminder) + 
    geom_jitter(aes(x = year, y = lifeExp )))

# 실습2
## 1번
gap_pop <- ggplot(gapminder,
                  aes(x = pop))

gap_pop

p_his <- gap_pop + geom_histogram()
p_his

## 2번

gap_2 <- ggplot(gapminder,
                aes(x = continent, y = lifeExp))

gap_vio <- gap_2 + geom_violin()
gap_vio

gap_vio_mean <- gap_vio + 
                  stat_summary(color="blue", 
                       fun.y="mean", 
                       geom = "point")
gap_vio_mean

## 3번

gap_3 <- ggplot(gapminder,
                aes(x = continent))

gap_cont <- gap_3 + geom_bar()
gap_cont

###강사님 답안
continent_freq <- gapminder %>% count(continent)

gap_33 <- ggplot(continent_freq,
                aes(x = continent, y = n))

gap_cont <- gap_33 + geom_bar(stat = "identity")
# identity y를 값으로 사용하세요
gap_cont


## 4번

jcountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
plot4 <- gapminder %>% filter(country %in% jcountries) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()
plot4

### color 변수를 주어서 각각의 나라로 쪼갠다.(그룹핑)


fcon <- gapminder %>% filter(country == "Canada" 
                             | country == "Rwanda"
                             | country == "Cambodia"
                             | country == "Mexico")
fcon

fcon_2 <- ggplot(fcon,
                 aes(x = year, y = lifeExp, 
                     color = country))

gap_fcon <- fcon_2 + geom_line() + geom_point()
gap_fcon


# 지도 만들기

if (!require("ggmap")) {devtools::install_github("dkahle/ggmap")}
install.packages("dplyr")
library(dplyr)
library(ggmap)

## 실습3

loc <- "서울"
loc

wifi <- read.csv("./data/wifi.csv", encoding = "UTF-8")
wifi
summary(wifi)

mapse<-get_googlemap(loc, zoom = 11) %>% ggmap()
mapse + geom_point(wifi, aes(x=,y=, color=))


