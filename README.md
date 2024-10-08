# TTC-Delay

## File Structure

The file is structured as:

-   `data/raw_data` contains the raw data as obtained from `opendatatoronto`.
-   `data/analysis_data` contains the cleaned datasets that were constructed.
-   `data/code_book` contains the code manuals of the raw data obtained from `opendatatoronto`.
-   `data/simulated_data` contains the simulated data generated by `scripts/00-simulate_data.R`.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data, and replicate graphs.

## Statement on LLM usage

The abstract, introduction and discussion were written with the help of ChatGPT, Grammarly and DeepL. The entire chat history is available in `other/llms/usage.txt`.
