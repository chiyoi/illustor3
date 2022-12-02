FROM python:3.9
RUN pip install --upgrade pip==22.3.1

WORKDIR /build
COPY ./requirements.txt ./
RUN pip install --no-cache-dir \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    -r ./requirements.txt

WORKDIR /build/target
COPY ./weights ./weights
COPY ./config.py ./
COPY ./internal ./internal

COPY ./cmd/server ./server

WORKDIR /
RUN cp -r /build/target /illustor3
RUN rm -rf /build

WORKDIR /illustor3
EXPOSE 80
ENV PYTHONPATH=/illustor3:/illustor3/internal:/illustor3/internal/stylegan3:$PYTHONPATH
CMD ["uvicorn", "--host", "0.0.0.0", "--port", "80", "server:mux"]