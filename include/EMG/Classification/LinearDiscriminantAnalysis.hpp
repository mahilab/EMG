// MIT License
//
// MEII - MAHI Exo-II Extension of MEL, the MAHI Exoskeleton Library
// Copyright (c) 2018 Mechatronics and Haptic Interfaces Lab - Rice University
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Author(s): Craig McDonald (craig.g.mcdonald@gmail.com)

pragma once

#include <vector>
#include <algorithm>
#include <Eigen/Dense>

namespace emg {

    double softmax(const std::vector<double>& a, std::size_t k);

    bool bin_linear_discriminant_model(const std::vector<std::vector<double>>& class_0_data, const std::vector<std::vector<double>>& class_1_data, std::vector<double>& w, double& w_0, double max_reg = 0.0);

    bool multi_linear_discriminant_model(const std::vector<std::vector<std::vector<double>>>& all_class_data, std::vector<std::vector<double>>& w, std::vector<double>& w_0, double r_min = 0.1);

} // namespace emg
