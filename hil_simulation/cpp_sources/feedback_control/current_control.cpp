#include "current_control.hpp"

CurrentController::CurrentController(double ikp, double iki, double min_duty, double max_duty, double pi_limit)
    : ikp(ikp), iki(iki), i_term(0.0), min_duty(min_duty), max_duty(max_duty), pi_limit(pi_limit) {}

double CurrentController::compute(double iref, double sampled_current, double vin, double uout) {
    double i_error = iref - sampled_current;

    const double upper_limit = vin - min_duty * uout;
    const double lower_limit = vin - max_duty * uout;

    double pi_out = calculate_pi_out(i_error, lower_limit, upper_limit);

    return pi_out;
}

void CurrentController::setMinDuty(double min_duty) {
    this->min_duty = min_duty;
}

void CurrentController::setMaxDuty(double max_duty) {
    this->max_duty = max_duty;
}

void CurrentController::setPiLimit(double pi_limit) {
    this->pi_limit = pi_limit;
}

double CurrentController::calculate_pi_out(double i_error, double lower_limit, double upper_limit) {
    const double k_term = i_error * ikp;
    double pi_out = k_term + i_term;
    if (pi_out < lower_limit) {
        /* i_term -= sgn(pi_out - lower_limit) * 0.1; */
        pi_out = lower_limit;
    } else if (pi_out > upper_limit) {
        /* i_term += sgn(pi_out - upper_limit) * 0.1; */
        pi_out = upper_limit;
    } else {
        i_term += i_error * iki;
    }
    if (std::fabs(pi_out) > pi_limit) {
        pi_out = sgn(pi_out) * pi_limit;
    }

    return pi_out;
}

double CurrentController::sgn(double input) {
    return (input < 0.0) ? -1.0 : 1.0;
}

