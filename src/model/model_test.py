from model import Model
from config import Config
import os.path as path

try:
    network = Config["network"]
except KeyError as err:
    print(err)
    exit(1)

m = Model()
m.load_network(network)

seed = 3939
img = m.generate(seed)

fp = path.join("output", "seed{}.png".format(seed))
print("saving example {}".format(fp))
img.save(fp)