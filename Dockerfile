FROM python:3.9
RUN pip install --upgrade pip==22.3.1

COPY ./requirements.txt ./
RUN pip install --no-cache-dir \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    -r ./requirements.txt

COPY ./scripts ./scripts
RUN ./scripts/build.sh

COPY ./target /illustor3
WORKDIR /illustor3

ENV PYTHONPATH=${WORKDIR}:${WORKDIR}/src:$PYTHONPATH
CMD ["uvicorn", "api:mux"]