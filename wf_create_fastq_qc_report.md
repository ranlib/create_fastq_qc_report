# wf_create_fastq_qc_report


## Inputs

### Required inputs
<p name="wf_create_fastq_qc_report.centrifuge">
        <b>wf_create_fastq_qc_report.centrifuge</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        ???
</p>
<p name="wf_create_fastq_qc_report.samplename">
        <b>wf_create_fastq_qc_report.samplename</b><br />
        <i>Array[String]+ &mdash; Default: None</i><br />
        ???
</p>
<p name="wf_create_fastq_qc_report.stats">
        <b>wf_create_fastq_qc_report.stats</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        ???
</p>

### Other inputs
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
        ???
</p>
<p name="wf_create_fastq_qc_report.task_create_fastq_qc_report.threads">
        <b>wf_create_fastq_qc_report.task_create_fastq_qc_report.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        ???
</p>
</details>

## Outputs
<p name="wf_create_fastq_qc_report.qc_report">
        <b>wf_create_fastq_qc_report.qc_report</b><br />
        <i>Array[File]</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
