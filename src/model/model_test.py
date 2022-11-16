from model import Model
from config import Config
import os.path as path
import os

try:
    network = Config["network"]
except KeyError as err:
    print(err)
    exit(1)

m = Model()
m.load_network(network)

seed = 39390
img = m.generate(seed, 0.4, "random")

out_dir = "output"
os.makedirs(out_dir)

fp = path.join(out_dir, "seed{}.png".format(seed))
print("saving example {}".format(fp))
img.save(fp)
