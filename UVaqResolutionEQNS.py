# Alejandro Diaz 2023
# equations for Quadrupole Mass Spectrometer
# Resolution and
# DC and RF amplitudes required
# in appendix for thesis work done for Masters of 
# Engineering at MIT

from matplotlib import pyplot as plt
import numpy as np
import math


# 1st stability region
a = .23
q = .7						# another default constant
h = 15 						# constant dependent on stability region- 1st: 10-20, 2nd:.73-1.43
# 2nd stability region
# a = 3.16
# q = 3.23
# h = 1 						# constant dependent on stability region- 1st: 10-20, 2nd:.73-1.43



# in Hz and meters
def evaluate(frequency, L, r0, m, h, q, a):
	resolutions = list()
	voltages = list()
	frequencies = list()
	lengths = list()
	ez = 10 					# making assumption of 5 electron volts
	e = 1 						# can be assumed to be positive 1 for most cases
	# vz = 2*(ez/m)**(1/2)		# axial ion velocity
	vz = (2*ez/m)**(1/2)		# axial ion velocity


	resolution = 1/h*(frequency*L)**2*m/(2*vz)
	print("mass: ", m)
	print("resolution: ", resolution)
	delta_m = 2*h*vz/(frequency**2*L**2)
	m = resolution*delta_m
	print("verified mass: " , m) # should be same as input mass
	rf_voltage = (math.pi)**2*q*m/e*frequency**2*r0**2
	print("rf_voltage P-P: ", rf_voltage*2)
	dc_voltage = math.pi**2*a*frequency**2*m*r0**2/(2*e)
	print("dc_voltage: ", dc_voltage)


	for frequency in range(25, 400):
		f = frequency/100
		frequencies.append(f)
		resolution = 1/h*(f*L)**2*m/(2*vz)
		resolutions.append(resolution)

		delta_m = 2*h*vz/(f**2*L**2)
		m = resolution*delta_m
		rf_voltage = (math.pi)**2*q*m/e*f**2*r0**2
		voltages.append(rf_voltage*2)

	print()
	plt.figure()
	# makes a graph of voltage vs. frequency
	plt.plot(frequencies, voltages, "red")
	plt.xlabel("frequency")
	plt.ylabel("voltage")
	plt.figure()
	# makes a graph of resolution vs. frequency
	plt.plot(frequencies, resolutions, "blue")
	plt.xlabel("frequencies")
	plt.ylabel("resolution")
	plt.show()

print()
print("break")

# frequency in MHz, mass in amu, r0 in cm, quadrupole length in cm
evaluate(frequency= 1.34, L = 7.34, r0 = .1965, m = 40, h=h, q=q, a=a)
evaluate(frequency= 2.54, L = 7.34, r0 = .1965, m = 40, h=h, q=q, a=a)



