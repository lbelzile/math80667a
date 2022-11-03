

AA21_mw <- AA21_m |>
  tidyr::pivot_wider(names_from = stimulus,
                     values_from = latency)
# Model with each variable with a different mean
mlm <- lm(cbind(real, GAN1, GAN2) ~ 1,
          data = AA21_mw)
anova(mlm, X = ~1, test = "Spherical")
library(emmeans)
emm_mlm <- emmeans(mlm, specs = "rep.meas") 
emm_mlm |> contrast(method = list(c(1,-0.5,-0.5)))

# rep.meas is the default name for the repeated measure

summary(aov(latency ~ stimulus + Error(id), 
            data = AA21_m))
