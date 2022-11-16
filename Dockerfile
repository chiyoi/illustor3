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

RUN cp -r /build/target /illustor3
RUN rm -rf /build

WORKDIR /illustor3
ARG root=/illustor3
ENV PYTHONPATH=$root:$root/src:$PYTHONPATH
CMD ["uvicorn", "api:mux"]