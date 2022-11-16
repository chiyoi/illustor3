FROM python:3.9

COPY ./requirements.txt ./
RUN pip install --upgrade pip && pip install -r ./requirements.txt

RUN ./scripts/build.sh

COPY ./target /illustor3
WORKDIR /illustor3

ENV PYTHONPATH=${WORKDIR}:${WORKDIR}/src:$PYTHONPATH
CMD ["uvicorn", "api:mux"]