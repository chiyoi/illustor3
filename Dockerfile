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
ARG root=/illustor3
RUN cp -r /build/target $root
RUN rm -rf /build

ENV PYTHONPATH=$root:$root/src:$PYTHONPATH
RUN echo $PYTHONPATH
CMD ["uvicorn", "api:mux"]