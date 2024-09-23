version 1.0
import "./task_create_fastq_qc_report.wdl" as fastq_qc
workflow fastq_qc_workflow {
  input {
    File stats
    File centrifuge
    String samplename
  }

  call fastq_qc.create_fastq_qc_report {
    input:
      stats = stats,
      centrifuge = centrifuge,
      samplename = samplename
  }

  output {
    File qc_report = create_fastq_qc_report.report
  }
}
