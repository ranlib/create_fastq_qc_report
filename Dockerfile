FROM ubuntu:24.04
RUN apt-get update --yes
RUN apt-get install --yes --no-install-recommends \
    python-is-python3 \
    python3-fpdf \
    python3-pandas
WORKDIR /opt/create_fastq_qc_report
COPY ./*.py ./
RUN apt-get clean && apt-get autoremove
ENV PATH $PATH:/opt/create_fastq_qc_report
ENV PYTHONPATH $PYTHONPATH:/opt/create_fastq_qc_report

