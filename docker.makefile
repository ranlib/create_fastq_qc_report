VER=v0.0.1

build:
	docker build -t dbest/create_fastq_qc_report:$(VER) .

build_no_cache:
	docker build --no-cache -t dbest/create_fastq_qc_report:$(VER) .

push:
	docker push dbest/create_fastq_qc_report:$(VER)
