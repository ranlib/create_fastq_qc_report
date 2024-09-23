version 1.0

task create_fastq_qc_report {
  
  # Task description:
  # This task runs the 'create_fastq_qc_report' tool to generate
  # a quality control (QC) report from given FASTQ statistics and centrifuge output.
  
  input {
    File stats         # Input stats file containing quality control metrics for the FASTQ data
    File centrifuge    # Input centrifuge file, typically containing results from the Centrifuge tool
    String samplename  # The name of the sample to be included in the report
    String docker_image = "dbest/create_fastq_qc_report:v0.0.1"  # Docker image for the tool
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
    memory: "4G"
    cpu: 2
  }

  meta {
    description: "Generates a FASTQ QC report using input stats and centrifuge files."
    author: "Dieter Best"
    email: "dieter.best@cdph.ca.gov"
    version: "1.0"
  }

  parameter_meta {
    stats: {
      description: "The statistics file generated from FASTQ quality control."
    }
    centrifuge: {
      description: "The centrifuge output file, containing classification results."
    }
    samplename: {
      description: "Sample name to be included in the QC report."
    }
    docker_image: {
      description: "Docker image containing the 'create_fastq_qc_report' tool."
    }
  }
}
