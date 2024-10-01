"""loop over pandas dataframe and put values into cells of a pdf object"""


def output_dataframe_to_pdf(pdf, df, sample_column_width: int = 30, values_column_width: int = 15, table_cell_height: int = 6, text_height: int = 8, enable_scientific_notation: bool = True):
    """loop over pandas dataframe and put values into cells of a pdf object"""

    pdf.set_font("helvetica", "B", text_height)

    table_cell_width = [values_column_width] * len(df.columns)
    table_cell_width[0] = sample_column_width
    for index, col in enumerate(df.columns):
        pdf.cell(table_cell_width[index], table_cell_height, col, align="C", border=1)

    pdf.ln(table_cell_height)
    pdf.set_font("helvetica", "", text_height)

    # loop over data frame and enter values into table cells
    for _, row in df.iterrows():
        for index_col, col in enumerate(df.columns):
            if isinstance(row[col], float) and enable_scientific_notation:
                value = str(format(row[col], ".2E"))
            else:
                value = str(row[col])
            if col in ["samplename", "file", "name", "taxRank"]:
                pdf.cell(table_cell_width[index_col], table_cell_height, value, align="L", border=1)
            else:
                pdf.cell(table_cell_width[index_col], table_cell_height, value, align="R", border=1)
        pdf.ln(table_cell_height)
