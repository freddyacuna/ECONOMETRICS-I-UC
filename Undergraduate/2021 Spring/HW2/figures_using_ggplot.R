ggplot(intermediate, aes(x = ln_gdp_60, y = ln_gdp_growth)) +
    geom_point(shape = 1) +
    geom_smooth(method=lm, se=FALSE, color = "red") +
    theme_bw() +
    ggtitle("A: Unconditional") +
    ylab("Log Growth rate: 1960 - 85") +
    xlab("Log output per working age adult: 1960")
    
    
y2 <- lm(ln_gdp_growth ~  ln_inv_gdp + ln_ndg, data = intermediate)$residuals
x2 <- lm(ln_gdp_60 ~  ln_inv_gdp + ln_ndg, data = intermediate)$residuals

panel_b <- tibble(y2, x2)


ggplot(panel_b, aes(x = x2, y = y2)) +
    geom_point(shape = 1) +
    geom_smooth(method=lm, se=FALSE, color = "red") +
    theme_bw() +
    ggtitle("B: Conditional on Saving and Population Growth") +
    ylab("Log Growth rate: 1960 - 85") +
    xlab("Log output per working age adult: 1960")


y3 <- lm(ln_gdp_growth ~  ln_inv_gdp + ln_ndg + ln_school, data = intermediate)$residuals
x3 <- lm(ln_gdp_60 ~  ln_inv_gdp + ln_ndg + ln_school, data = intermediate)$residuals

panel_c <- tibble(y3, x3)

ggplot(panel_c, aes(x = x3, y = y3)) +
    geom_point(shape = 1) +
    geom_smooth(method=lm, se=FALSE, color = "red") +
    theme_bw() +
    ggtitle("C: Conditional on Saving and Population Growth and Human Capital") +
    ylab("Log Growth rate: 1960 - 85") +
    xlab("Log output per working age adult: 1960")
