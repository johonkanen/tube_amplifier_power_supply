import math

# Constants
Po = 10.275  # W, output power
Uin_min = 100  # V
Uin_max = 420  # V
duty = 0.5

# Calculate peak transistor voltage
Vpeak = Uin_min / (1 - duty) * duty

Eff = 0.8  # estimated efficiency (unitless)
Fs = 72e3  # Hz, switching frequency

# Output voltages (V)
Vout1 = 14.7
Vout2 = 14.7
Vout3 = 6.0
Vout4 = 6.0
Vout5 = 80
Vout6 = 6.0

# Core parameters
Ae = 32.1e-6  # m^2, core cross-sectional area
Al = 1470  # nH/turn^2, inductance factor
Bsat = 300.1e-3  # T, saturation flux density

Krf = 2.35  # ripple factor, DCM => Krf > 1


def engineering_format(value, unit):
    prefixes = {
        -9: 'n',  # nano
        -6: 'µ',  # micro
        -3: 'm',  # milli
        0: '',    # no prefix
        3: 'k',   # kilo
        6: 'M',   # mega
        9: 'G'    # giga
    }

    if value == 0:
        return "0"
    
    exponent = int(math.floor(math.log10(abs(value))))
    exponent = exponent - (exponent % 3)
    
    mantissa = value / (10 ** exponent)
    prefix = prefixes.get(exponent, f'e{exponent}')
    
    return f'{mantissa:.3f} {prefix+unit}'

# Input power
Pin = Po / Eff

# Maximum duty cycle
Dmax = Vpeak / (Vpeak + Uin_min)

# Reflective voltage
Vro = Dmax / (1 - Dmax) * Uin_min

# Peak transistor voltage
Vds = Uin_max + Vro

# Magnetization inductance
Lm = (Uin_min * Dmax) ** 2 / (2 * Pin * Fs * Krf)

# Transistor current
Iedc = Pin / (Uin_min * Dmax)
dI = Uin_min * Dmax / (Lm * Fs)
Idrms = math.sqrt(((3 * Iedc) ** 2 + dI ** 2 / 4) * Dmax / 3)
Ids = Iedc + dI / 2

# Input voltage where DCM cannot be guaranteed
Vdc_ccm = (1 / math.sqrt(2 * Lm * Fs * Pin) - 1 / Vro) ** -1

# Primary turns
Iover = Ids * 1.1  # current limit, allow for extra 10% current peak
Np_min = Lm * Iover / (Bsat * Ae)

# Windings (needs iteration)
Vdiode = 0.9  # V, diode drop
n = Vro / (Vout1 + Vdiode)  # turns ratio
Np = round(Np_min + 1)
N1 = Np / (Vro / (Vout1 + Vdiode))

# Secondary turns
N2 = (Vout2 + Vdiode) / (Vout1 + Vdiode) * N1
N3 = (Vout3 + Vdiode) / (Vout1 + Vdiode) * N1
N4 = (Vout4 + Vdiode) / (Vout1 + Vdiode) * N1
N5 = (Vout5 + Vdiode) / (Vout1 + Vdiode) * N1
N6 = (Vout6 + Vdiode) / (Vout1 + Vdiode) * N1

Al_nh = Lm / Np ** 2

if round(Np_min) >= round(Np):
    print('Warning, increase primary turns')
elif 0.5 * Lm * Iover ** 2 * Fs <= Po:
    print('Warning, Lm too high')
else:
    print('Primary turns:', Np)
    print('Secondary turns:', [N1, N2, N3, N4, N5, N6])
    print('Transistor peak current:', Ids)
    print('Transistor RMS current:', Idrms)
    print('Transistor peak voltage:', Vds)
    
    # Calculate airgap length
    gap = 4 * 1e-7 * math.pi * Lm * Iover ** 2 / (Ae * Bsat ** 2)
    print('Airgap length (m), iterate until close to manufacturer value:')
    print('Gap:', gap)
    
    print('Al value :', engineering_format(Al_nh, 'H/turn^2'))
    print('Iterate until close to manufacturer value')
    print('See datasheet for factory airgaps:')
    print('https://en.tdk.eu/inf/80/db/fer/e_20_10_6.pdf')
    print('Magnetization inductance:', engineering_format(Lm, 'H'))


