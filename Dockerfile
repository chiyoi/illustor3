FROM python:3.9
RUN pip install --upgrade pip==22.3.1

WORKDIR /build
COPY ./requirements.txt ./
RUN pip install --no-cache-dir \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    -r ./requirements.txt

WORKDIR /build/target
COPY ./api.py ./config.py ./
COPY ./src ./src
COPY ./weights ./weights

FROM python:3.9
COPY --from=0 /build/target /illustor3

WORKDIR /illustor3
ENV PYTHONPATH=${WORKDIR}:${WORKDIR}/src:$PYTHONPATH
CMD ["uvicorn", "api:mux"]