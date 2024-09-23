version 1.0

import "./task_create_fastq_qc_report.wdl" as fastq_qc

workflow wf_create_fastq_qc_report {
  input {
    Array[File]+ stats
    Array[File]+ centrifuge
    Array[String]+ samplename
  }

  scatter ( idx in range(length(stats)) ) {
    call fastq_qc.task_create_fastq_qc_report {
      input:
      stats = stats[idx],
      centrifuge = centrifuge[idx],
      samplename = samplename[idx]
    }
  }
  
  output {
    Array[File] qc_report = task_create_fastq_qc_report.report
  }
}
