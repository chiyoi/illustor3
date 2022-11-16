import os.path as path

root = path.dirname(__file__)
Config = {
    "network": path.join(root, "weights", "stylegan3-anime-face-gen.pkl"),
    "output": path.join(root, "output")
}
