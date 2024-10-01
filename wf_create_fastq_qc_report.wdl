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

  meta {
    description: "Generates a FASTQ QC report using input stats and centrifuge files."
    author: "Dieter Best"
    email: "dieter.best@cdph.ca.gov"
  }

  parameter_meta {
    # inputs
    stats: {
      description: "The statistics file generated from FASTQ quality control.",
      category: "required"
    }
    centrifuge: {
      description: "The centrifuge output file, containing classification results.",
      category: "required"
    }
    samplename: {
      description: "Sample name to be included in the QC report.",
      category: "required"
    }
    docker_image: {
      description: "Docker image containing the 'create_fastq_qc_report' tool.",
      category: "optional"
    }
    memory: {
      description: "RAM requested for the tool.",
      category: "optional"
    }

    # outputs
    qc_report: {
      description: "Result QC report in pdf format.",
      category: "other"
    }
    
  }
}
