#
#     R-code to generate data for F79MA Assignment 2.  
#     This code MUST be placed at the start of your own R-script. 
#     You must edit the variable last_four_digits to fit 
#     your own student ID number
#
RNGkind(sample.kind = "Rejection")
last_four_digits = 3289 ## change this number

set.seed(last_four_digits)

dataset <- read.csv(file = "count_data.csv", header = TRUE)
Full_Data <- dataset$x
My_Data <- sample(Full_Data,size=1000,replace=FALSE)


#####################################################################
# Please insert your R code after this line
#####################################################################

library(ggplot2)

# Maximum likelihood estimate p_hat for My_Data
k = 5
x_bar = mean(My_Data)
Quantity1 = k / x_bar

# Deriving the posterior density for p and finding its mean
n = 1000
S = sum(My_Data - k)
alpha_post = n * k
beta_post = S + 0.5
posterior_samples = rbeta(n, shape1 = alpha_post, shape2 = beta_post)
Quantity2 = alpha_post / (alpha_post + beta_post)

# Defining the Jeffrey's prior
p_vals = seq(0.001, 0.999, length.out = n)
jeff_prior = 1 / (p_vals * sqrt(1 - p_vals))

# Put samples into a data frame for ggplot
jeff_df = data.frame(
  p = p_vals,
  value = jeff_prior,
  type = "Jeffrey's Prior"
)
post_df = data.frame(
  p = posterior_samples,
  type = "Posterior"
  
)
ggplot() +
  geom_line(data = jeff_df, aes(x = p, y = value, colour = "Jeffreys Prior (Improper)"), linewidth = 1) +
  geom_density(data = post_df, aes(x = p, colour = "Posterior"), adjust = 2, linewidth = 1) +
  coord_cartesian(xlim = c(0, 0.25)) +
  labs(
    title = "Jeffrey's Prior vs. Posterior",
    x = "p",
    y = "Density"
  ) +
  scale_colour_manual(values = c("Jeffreys Prior (Improper)" = "blue", "Posterior" = "red")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))


# Posterior predictive distribution and using this
# to find the value of pi(Z = 5|x)

z = 5
binomial_coef = choose(z - 1, k - 1)
Quantity3 = binomial_coef * exp(lbeta(alpha_post + k, beta_post + z - k) - lbeta(alpha_post, beta_post))

# Simulating 10000 realizations from the posterior
# predictive distribution

realisations = 10000
posterior_predictive_samples = rnbinom(realisations, size = k, prob = posterior_samples)

hist(posterior_predictive_samples, breaks = 30, freq = F,main = "Posterior Predictive Distribution",
     xlab = "Count", col = "lightblue",)
hist(Full_Data, breaks = 30, freq = F, main = "Histogram of Full_Data", col = "lightgreen", add = T)