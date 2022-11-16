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

WORKDIR /illustor3
RUN cp -r /build/target .
RUN ls -la .
RUN rm -rf /build

ARG root=/illustor3
ENV PYTHONPATH=$root:$root/src:$PYTHONPATH
CMD ["uvicorn", "api:mux"]