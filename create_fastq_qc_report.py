#!/usr/bin/env python
"""
create pdf report for fastq QC
"""
import argparse
import pandas
from fpdf import FPDF
from output_dataframe_to_pdf import output_dataframe_to_pdf

parser = argparse.ArgumentParser(description="create fastq qc report", prog="create_fastq_qc_reportvariant_interpretation", formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=100))
parser.add_argument("--stats", "-s", required=True, type=argparse.FileType("r"), help="Input fastq statistics file in tsv format generated by seqkit stats")
parser.add_argument("--centrifuge", "-c", required=True, type=argparse.FileType("r"), help="Input contamination file in tsv format generated by centrifuge")
parser.add_argument("--samplename", "-n", required=True, type=str, help="Sample name")
parser.add_argument("--verbose", "-v", action="store_true", help="Verbose output")
args = parser.parse_args()

TEXT_HEIGHT = 8
CELL_HEIGHT = 6
LINE_SKIP = 6

pdf = FPDF("P", "mm", "Letter")
pdf.add_page()

pdf.set_font("helvetica", "BU", 16)
pdf.cell(pdf.w, CELL_HEIGHT, "Fastq QC Report")
pdf.ln(2 * LINE_SKIP)

pdf.set_font("helvetica", "B", TEXT_HEIGHT)
pdf.cell(pdf.w, CELL_HEIGHT, "Sample Name = " + args.samplename)
pdf.ln(2 * LINE_SKIP)

pdf.set_font("helvetica", "", TEXT_HEIGHT)
TEXT = """1. Purpose:
1.1. Determine sequencing quality from raw fastq files.
1.2. Determine contamination.
"""
pdf.multi_cell(pdf.w, CELL_HEIGHT, TEXT)

TEXT = """2. Tools used:
2.1. Sequencing quality: seqkit (https://bioinf.shenwei.me/seqkit/)
2.2. Contamination: centrifuge (https://ccb.jhu.edu/software/centrifuge/manual.shtml)
"""
pdf.multi_cell(pdf.w, CELL_HEIGHT, TEXT)

pdf.cell(pdf.w, CELL_HEIGHT, "3. Results:")
pdf.ln(LINE_SKIP)

#
# fastq stats
#
pdf.cell(pdf.w, CELL_HEIGHT, "3.1. Sequencing quality:")
pdf.ln(LINE_SKIP)

d = pandas.read_csv(args.stats, sep="\t")
dropped_cols = ["format", "type", "sum_len", "Q1", "Q2", "Q3", "sum_gap", "N50", "N50_num", "Q20(%)", "Q30(%)"]
d = d.drop(columns=dropped_cols)
# extract sample names
d["file"] = d["file"].str.replace(".fastq.gz", "", regex=True)
# d = d.rename(columns={'file': 'samplename'})
output_dataframe_to_pdf(pdf, d, 60, 15, enable_scientific_notation=False)

# get FAIL/PASS
#print(d.dtypes)
#print(d.describe())
status = "FAILED" if d.at[0,'AvgQual'] < 20 or d.at[1,'AvgQual'] < 20 else "PASSED"

pdf.set_font("helvetica", "", TEXT_HEIGHT)
# TEXT = """Status: FAILED
# Reason: average Q-score < Q20
# Reference: Q30 for a good sequencing run
# """
# pdf.multi_cell(pdf.w, CELL_HEIGHT, TEXT)

pdf.cell(pdf.w, CELL_HEIGHT, f"Status: {status}")
pdf.ln()
pdf.cell(pdf.w, CELL_HEIGHT, "Reason: average Q-score < Q20 for forward or reverse reads")
pdf.ln()
pdf.cell(pdf.w, CELL_HEIGHT, "Reference: Q30 for a good sequencing run")
pdf.ln(2 * LINE_SKIP)

#
# taxonomy
#
pdf.cell(pdf.w, CELL_HEIGHT, "3.2. Contamination: top 10 contributions at most")
pdf.ln(LINE_SKIP)

t = pandas.read_csv(args.centrifuge, sep="\t")
# weed out some rows
keepers = ["species", "genus"]
t = t.query("taxRank in @keepers")
# take only the top 10,
# assume sorted by abundance
t_sorted = t.sort_values("abundance", ascending=False)
t_top10 = t_sorted.head(10).copy()
# truncate name to fit in table cell
t_top10["name"] = t_top10["name"].str.slice(0, 30)
output_dataframe_to_pdf(pdf, t_top10, 50, 25)

# get FAIL/PASS
#print(t.dtypes)
#print(t.describe())
status = "FAILED"

TEXT = f"""Status: {status}
Reason: reads assigned to contamination
Reference: number of reads assigned to contamination < 0.1% of minimum required number of reads per sample
"""
pdf.multi_cell(pdf.w, CELL_HEIGHT, TEXT)

#
# Summary
#
pdf.cell(pdf.w, CELL_HEIGHT, "4. Summary:")
pdf.ln(LINE_SKIP)
TEXT = """Status: FAILED
Reason: insufficient sequencing quality
"""
pdf.multi_cell(pdf.w, CELL_HEIGHT, TEXT)

#
# write pdf
#
output_file = args.samplename + "_fastq_qc_report.pdf"
pdf.output(output_file, "F")
