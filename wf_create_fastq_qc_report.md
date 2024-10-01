# wf_create_fastq_qc_report
Generates a FASTQ QC report using input stats and centrifuge files.

## Inputs

### Required inputs
<p name="wf_create_fastq_qc_report.centrifuge">
        <b>wf_create_fastq_qc_report.centrifuge</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        The centrifuge output file, containing classification results.
</p>
<p name="wf_create_fastq_qc_report.samplename">
        <b>wf_create_fastq_qc_report.samplename</b><br />
        <i>Array[String]+ &mdash; Default: None</i><br />
        Sample name to be included in the QC report.
</p>
<p name="wf_create_fastq_qc_report.stats">
        <b>wf_create_fastq_qc_report.stats</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        The statistics file generated from FASTQ quality control.
</p>

### Advanced inputs
<details>
<summary> Show/Hide </summary>
<p name="wf_create_fastq_qc_report.task_create_fastq_qc_report.docker_image">
        <b>wf_create_fastq_qc_report.task_create_fastq_qc_report.docker_image</b><br />
        <i>String &mdash; Default: "dbest/create_fastq_qc_report:v0.0.2"</i><br />
        Docker image containing the 'create_fastq_qc_report' tool.
</p>
<p name="wf_create_fastq_qc_report.task_create_fastq_qc_report.memory">
        <b>wf_create_fastq_qc_report.task_create_fastq_qc_report.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        RAM requested for the tool.
</p>
</details>

## Outputs
<p name="wf_create_fastq_qc_report.qc_report">
        <b>wf_create_fastq_qc_report.qc_report</b><br />
        <i>Array[File]</i><br />
        Result QC report in pdf format.
</p>

<hr />

> Generated using WDL AID (1.0.0)
