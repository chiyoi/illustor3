import random
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
print("loading network: {}".format(network))
m.load_network(network)

seed = int(random.random()*(2**32-1))
print("generating image for seed {}".format(seed))
img = m.generate_img(seed, 0.4)

out_dir = "output"
if not path.exists(out_dir):
    os.makedirs(out_dir)
assert path.isdir(out_dir)

fp = path.join(out_dir, "seed{}.png".format(seed))
print("saving example {}".format(fp))
img.save(fp)
