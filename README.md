Bayesian Negative Binomial Analysis
==================================

Overview
--------

This project investigates Bayesian modelling of count data using the negative binomial distribution as an alternative to the Poisson model. The analysis focuses on modelling the number of genetic mutation counts in a fixed-length RNA sequence and assessing whether the fitted model can reliably predict future observations.

Key Objectives
--------------

- Derive the negative binomial distribution from a Poisson–Gamma mixture model.
- Compare Poisson and negative binomial models for overdispersed count data.
- Perform Bayesian inference on the success probability parameter using Jeffreys’ prior.
- Derive and analyse the posterior and posterior predictive distributions.
- Evaluate predictive performance using simulation and comparison with observed data.

Methods
-------

- Analytical derivation of likelihoods, Fisher information, and Jeffreys’ prior.
- Bayesian updating using an improper prior and a large-sample likelihood.
- Posterior inference and comparison with the frequentist MLE.
- Simulation of posterior predictive distributions in R.
- Histogram-based comparison of observed and simulated data.

Main Findings
-------------

- The negative binomial distribution naturally arises from a Poisson–Gamma model and captures overdispersion.
- Despite using an improper Jeffreys’ prior, the posterior distribution is proper due to the strength of the data.
- The posterior mean closely matches the frequentist MLE, indicating agreement between Bayesian and frequentist approaches.
- The posterior predictive distribution closely matches the observed data, supporting the model’s predictive validity.

Conclusion
----------

The Bayesian negative binomial model provides a robust and effective framework for modelling overdispersed count data. The agreement between Bayesian and frequentist estimates, along with strong predictive performance, supports the use of this model for predicting genetic mutation counts and similar biological count processes.

Tools
-----

- R (Bayesian analysis, simulation, and visualisation)
