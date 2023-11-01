import matplotlib.pyplot as plt
import numpy as np

#
def f(x):
    return np.power(np.e, x) * np.log(1 + np.power(np.e, -x))

x = np.linspace(0., 50., 10000)

plt.plot(x, f(x), linewidth=1)
plt.savefig(f"./plots/plt.png", dpi=300)