#!/usr/bin/env python3


import numpy as np

mult = (np.ones((32,1))*np.arange(1,33)).transpose()
div = np.ones((32,1))*np.arange(1,33)

mult_list = mult.flatten()
div_list = div.flatten()
ratios = (mult/div).flatten()

F_in = 50_000_000
F_out = 193_160_000

ratio_target = F_out/F_in

errors = np.abs(1 - (ratios/ratio_target))
error_order = np.argsort(errors)

max_errors = 5
for i in error_order[:max_errors]:
	print("Err={:2.2f}%    M={:2d}   D={:2d}".format(
		errors[i]*100,
		int(mult_list[i]),
		int(div_list[i])
		))


print(ratio_target)