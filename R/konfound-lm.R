# konfound-lm

konfound_lm <- function(model_object, tested_variable_string, test_all, alpha, tails, to_return) {
    
    tidy_output <- broom::tidy(model_object) # tidying output
    glance_output <- broom::glance(model_object)
    
    if (test_all == FALSE) {
        coef_df <- tidy_output[tidy_output$term == tested_variable_string, ] 
    } else {
        coef_df <- tidy_output[-1, ] } # to remove intercept
    
    unstd_beta = round(coef_df$estimate, 3)
    std_err = round(coef_df$std.error, 3)
    n_obs = glance_output$df + glance_output$df.residual
    n_covariates = glance_output$df - 2 # (for intercept and coefficient)
    
    if (test_all == FALSE) {
        return(test_sensitivity(unstd_beta = unstd_beta,
                                std_err = std_err,
                                n_obs = n_obs,
                                n_covariates = n_covariates,
                                alpha = alpha,
                                tails = tails,
                                nu = 0,
                                to_return = to_return,
                                component_correlations = component_correlations,
                                non_linear = FALSE,
                                model_object = model_object,
                                tested_variable = tested_variable_string))
    } else { 
        o <- mkonfound(data.frame(unstd_beta, std_err, n_obs, n_covariates))
        term_names <- dplyr::select(tidy_output, var_name = .data$term) # remove the first row for intercept
        term_names <- dplyr::filter(term_names, .data$var_name != "(Intercept)")
        return(dplyr::bind_cols(term_names, o))
    } 
}