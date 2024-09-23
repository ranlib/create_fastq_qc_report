SHELL:=/bin/bash
#
# create_fastq_qc_report
#
create_fastq_qc_report:
	java -jar ~/Software/womtool-86.jar validate --inputs wf_create_fastq_qc_report.json wf_create_fastq_qc_report.wdl
	miniwdl check wf_create_fastq_qc_report.wdl

create_fastq_qc_report_docu:
	wdl-aid wf_create_fastq_qc_report.wdl -o wf_create_fastq_qc_report.md

run_create_fastq_qc_report:
	miniwdl run --debug --dir test-create_fastq_qc_report --input wf_create_fastq_qc_report.json wf_create_fastq_qc_report.wdl

run_create_fastq_qc_report_cromwell:
	java -jar ~/Software/cromwell-86.jar run wf_create_fastq_qc_report.wdl -i wf_create_fastq_qc_report.json
