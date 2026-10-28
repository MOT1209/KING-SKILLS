---
name: data-analysis
description: Use when analyzing CSV or Excel files, extracting numbers and trends, and writing a concise report based on calculations that were actually run.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Data analysis

## When to use
- The user attaches a CSV or Excel (xlsx/xls) file and asks to understand or summarize it.
- They want numbers, statistics, trends and comparisons from a spreadsheet.
- They want a short report with the analysis results.

Do not use when there is no actual data; never analyze imagined data.

## Workflow
1. Read the file for real with a code execution tool (such as Python and pandas). For Excel files list the sheet names and choose the one the request is about.
2. Inspect the structure: number of rows and columns, column types, empty values, duplicate rows, and obvious outliers. Note any data quality issue.
3. Define the analysis questions from the user's request. If the request is general, use: descriptive statistics, the trend over time if there is a date column, comparison between categories, and the highest and lowest values.
4. Run the calculations in code and keep the outputs. Never estimate a result mentally or round it without running it.
5. Verify the results: check totals against the original table, make sure empty values were handled, and check that units of measure and currency are right.
6. Write the report in this order: executive summary (3–5 lines), key numbers (a table), trends and observations, data quality notes, recommendations or follow-up questions.
7. At the end of the report state what was done to the data (rows excluded, values filled, types converted).

## Output format
The report with the following headings in the same order:
1. **Executive summary:** 3 to 5 lines, containing the direct answer to the question.
2. **Key numbers:** a table (Indicator | Value | Note), with the unit or currency stated for every number.
3. **Trends and observations:** short points, each paired with its number.
4. **Data quality:** the total row count and the count actually used, and the empty, duplicate and outlier counts.
5. **What was done to the data:** a list of every exclusion or conversion.
6. **Recommendations / follow-up questions.**

## Full example
**Input:** "I attached sales.csv. What is the total revenue and which products are highest?" (illustrative sample data):
```text
date,product,units,unit_price
2025-01-05,A,10,5
2025-01-20,B,4,12
2025-02-03,A,14,5
2025-02-18,B,,12
2025-02-25,B,7,12
```

**Expected output:**
```text
Executive summary: total revenue is 252 (the currency is not stated in the file).
Product B is highest at 132 versus 120 for product A. Revenue rose from 98 in January
to 154 in February (+57.1%). The sample is small: only 4 valid rows.

| Indicator | Value | Note |
|---|---|---|
| Total revenue | 252 | units × unit price |
| Product A | 120 (47.6%) | |
| Product B | 132 (52.4%) | the 18 Feb row is excluded |

Data quality: 5 rows, 1 of them with no value in units.
What was done: the 2025-02-18 row was excluded because the quantity is missing, and its value was not estimated.
Follow-up question: what is the quantity in the 2025-02-18 row? And what currency are the prices in?
```

## Edge cases
- **An empty file or one with no data rows:** tell the user and do not produce a report.
- **Several Excel sheets and a general request:** list the sheet names, and analyze the most suitable one stating your choice, or ask one question.
- **An unexpected encoding or delimiter in a CSV:** try common encodings and delimiters, and state what you adopted.
- **Dates in mixed or ambiguous formats (such as 03/04):** do not guess day versus month; state the ambiguity and ask, or declare the assumption.
- **Conflicting columns (a total that does not match its components):** report the difference with numbers, and say which of the two values you adopted.
- **Many empty values (more than half a column):** warn that conclusions about that column are weak.
- **A column containing personal data:** do not show it, and analyze without it where possible.

## Rules and limits
- Every number in the report must come from a calculation run on the file; no numbers from memory or guesswork.
- Distinguish correlation from causation; do not claim a cause that the data does not support.
- State the sample size when concluding from a small number of rows.
- Do not modify the original file; save any outputs to a new file.
- Handle personal data with care: do not display sensitive identifiers without need.
- If the question cannot be answered from the available data, say so explicitly and state what is missing.
