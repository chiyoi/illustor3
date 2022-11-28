import random
from typing import Union
from fastapi import FastAPI
from fastapi.responses import StreamingResponse
from config import Config
from model import NoiseMode, Model
import io
import logging

mux = FastAPI(docs_url=None, redoc_url=None)
m = Model()

log = logging.getLogger("uvicorn")


@mux.on_event("startup")
async def startup():
    log.info("illustor3 starting!")

    try:
        network = Config["network"]
    except KeyError as err:
        log.fatal(err)
        exit(1)

    log.info("loading network {}".format(network))
    m.load_network(network)


@mux.get("/")
async def handler(seed: Union[int, None] = None, truncate_psi: float = 0.4, noise_mode: NoiseMode = "const"):
    if seed is None:
        seed = int(random.random()*(2**32-1))

    log.info("generating image for seed {}, truncation_psi={}, noise_mode={}".format(
        seed, truncate_psi, noise_mode))
    img = m.generate_img(seed, truncate_psi, noise_mode)

    buf = io.BytesIO()
    img.save(buf, format="png")

    buf.seek(0)
    return StreamingResponse(buf, headers={
        "filename": "seed{}-psi{}-{}_noise.png".format(seed, truncate_psi, noise_mode)
    }, media_type="image/png")
