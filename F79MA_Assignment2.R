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
s = sum(My_Data - k)
alpha_post = n * k
beta_post = s + 0.5
posterior_samples = rbeta(n, shape1 = alpha_post, shape2 = beta_post)
Quantity2 = mean(posterior_samples)

# Deriving the prior distribution using an approximation
prior_samples = rbeta(n, shape1 = 0.5, shape2 = 0.5)

# Put samples into a data frame for ggplot
df <- rbind(
  data.frame(p = prior_samples, type = "Jeffreys Prior"),
  data.frame(p = posterior_samples, type = "Posterior")
)

ggplot(df, aes(x = p, fill = type)) +
  geom_density(alpha = 0.4, adjust = 3) +
  xlim(0, 0.3) +
  labs(title = "Jeffreys Prior vs Posterior (Negative Binomial)",
       x = "p", y = "Density") +
  theme_minimal()

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
     xlab = "Count", ylab = "Frequency", col = "lightblue")
