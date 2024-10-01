version 1.0

task task_create_fastq_qc_report {
  
  # Task description:
  # This task runs the 'create_fastq_qc_report' tool to generate
  # a quality control (QC) report from given FASTQ statistics and centrifuge output.
  
  input {
    File stats         # Input stats file containing quality control metrics for the FASTQ data
    File centrifuge    # Input centrifuge file, typically containing results from the Centrifuge tool
    String samplename  # The name of the sample to be included in the report
    String docker_image = "dbest/create_fastq_qc_report:v0.0.2"  # Docker image for the tool
    String memory = "4G"
  }
  
  command <<<
    create_fastq_qc_report.py \
      --stats ~{stats} \
      --centrifuge ~{centrifuge} \
      --samplename ~{samplename}
  >>>

  output {
    File report =  "${samplename}_fastq_qc_report.pdf"
  }

  runtime {
    docker: docker_image
    memory: memory
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
      category: "advanced"
    }
    memory: {
      description: "RAM requested for the tool.",
      category: "advanced"
    }

    # outputs
    report: {
      description: "Result QC report in pdf format.",
      category: "other"
    }
    
  }
}
