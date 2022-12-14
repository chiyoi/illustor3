import pickle
from typing import Literal, Union
import torch
import numpy as np
from PIL import Image
import os

NoiseMode = Literal["const", "random", "none"]


class Model:
    G: torch.nn.Module

    def load_network(self, network: str, device: Union[torch.device, str] = "cpu"):
        if not os.path.isfile(network):
            raise FileNotFoundError(
                "regular file {} not exist".format(network))
        with open(network, "rb") as f:
            self.G = pickle.Unpickler(f).load()["G_ema"].to(device)

    def generate_img(self, seed: int, psi: float = 1, noise_mode: NoiseMode = "const") -> Image.Image:
        if not hasattr(self, "G"):
            raise RuntimeError("must load network before generating")
        z = torch.from_numpy(np.random.RandomState(seed).randn(
            1, self.G.z_dim))  # pyright: reportGeneralTypeIssues=false
        img_arr: torch.Tensor = (self.G(z, torch.zeros(1, 0), truncation_psi=psi, noise_mode=noise_mode)
                                 .permute(0, 2, 3, 1) * 127.5 + 128).clamp(0, 255).to(torch.uint8)
        img = Image.fromarray(img_arr[0].cpu().numpy(), "RGB")
        return img
