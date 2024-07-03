#include "voltage_control.hpp"

VoltageController::VoltageController(double vkp, double vki, double upper_limit, double lower_limit)
    : vkp(vkp), vki(vki), upper_limit(upper_limit), lower_limit(lower_limit), i_term(0.0) {}

double VoltageController::compute(double v_error) {
    const double vk_term = v_error * vkp;
    double iref = vk_term + i_term;

    if (iref < lower_limit) {
        /* i_term = i_term - sgn(iref - lower_limit) * 0.1; */
        iref = lower_limit;
    } else if (iref > upper_limit) {
        /* i_term = i_term - sgn(iref - upper_limit) * 0.1; */
        iref = upper_limit;
    } else {
        i_term = i_term + v_error * vki;
    }

    return iref;
}

double VoltageController::sgn(double input) {
    return (input < 0.0) ? -1.0 : 1.0;
}

