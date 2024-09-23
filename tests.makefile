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
	#miniwdl run --debug --dir test-create_fastq_qc_report --cfg miniwdl_production.cfg  --input wf_create_fastq_qc_report.json wf_create_fastq_qc_report.wdl
	miniwdl run --debug --dir test-create_fastq_qc_report_negative_control --cfg miniwdl_production.cfg  --input wf_create_fastq_qc_report_negative_control.json wf_create_fastq_qc_report.wdl	

