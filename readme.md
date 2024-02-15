Here is a detailed description for each Jupyter notebook in the repository:

oneai-dda-spatialone-deconvbenchmark/Exhaustive_benchmarking_summer2023 at jingyi-dev · Sanofi-OneAI/oneai-dda-spatialone-deconvbenchmark (github.com)

Step-001: Generate synthetic data.

Description: In this step, we will generate synthetic data depending on the scenario of interest. Note the code was adapted from the original version from oneai-dda-spatialone-deconvbenchmark/src/syntethinc_data/simulate_data.ipynb, with slight modifications to accommodate scenarios that I tested.

We have three files corresponding to each scenario:

Scenario 1: Only include major cell types, adjust cell_number_per_spot.

Scenario 2: Only include major cell types, adjust reference source from same study to different study, Atlas. Note that for fair comparison, we focus on one synthetic dataset generated form Meyer_2019, then use different single cell reference files for cell type deconvolution.

Scenario 3: Include both major and minor cell types, fix the cell number per spot = 10, use reference from the same study, adjust cell mix level to 0, 20%, 40%, 60%. 

Input files: No input file needed.

Output files: :

Reference for deconv (use this for cell deconvolution)

Reference for simulate (to generate spatial synthetic data)

simulated_SRT_dataset_{sim_id}.h5ad (spatial synthetic data)

simulated_SRT_dataset_{sim_id}.gd_count.csv (ground truth of cell count per spot)

simulated_SRT_dataset_{sim_id}.gd_prop.csv (ground truth of cell proportions per spot)

Step-002: (Optional) Generate synthetic data with randomly mixed conditions

Description: In a tissue, the cell density might be uneven across the tissue slide. For scenario 1, we not only generated synthetic datasets with uniform cell counts per spot representing low – high density (uniform 5-25 cells per spot), but also datasets that have uneven cell density. To do that, we use 002_optional_get_MIXsimSets.ipynb (from Sergio) to randomly sample spots from a list of synthetic datasets (5, 10, 15, 20, 25). The output synthetic data will have cell count per spot ranging from 5-25.

Step-003: Process synthetic datasets for EnDecon input

Description: In this step, we will read in all synthetic files within the assigned folder, process the single cell reference and synthetic data into 4 csv files. These csv files will be the input files for EnDecon. Note that some of these csv files might have a large file size.

Here I made slightly adjust for the input for 3 scenarios, but the main body of the code remains the same. The major difference is: for scenario 2, I added a tail for ref_id indicating the source of reference data. For scenario 1 and 3, there is no tail added.

Step-004: Run EnDecon (cell deconvolution) for synthetic datasets

Description: In this step, we will read in processed csv files for each reference and synthetic data in assigned folder, and run EnDecon for cell type deconvolution. Currently, there are 11 methods included as below. You can adjust the parameters to run selected methods, as well as optimize cell2location parameters. This step often takes a long time before printing any output.

Input files: four files for each synthetic data and reference data pair:

Sc_count.csv (gene expression matrix for each cell in reference data)

Sc_meta.csv (cell type information for each cell in reference data)

Spatial_count.csv (spatial location for each spot in synthetic data)

Spatial_location.csv (gene expression matrix for each spot in synthetic data)

Output files:

Cell proportion csv files for each method

A compiled .Rdata file assembling outputs from all methods (you can read this file in R later)

A csv file listing runtime for each method

Step-005 Benchmark analysis

Description: This step will analyze and compare the output of each method.

Here are the major outputs:

First it will generate figures to visualize the cell proportion of deconv result and ground truth.
![image](https://github.com/Sanofi-OneAI/oneai-dda-spatialone-deconvbenchmark/assets/49164740/b6932a0a-4106-40c5-888e-f1259e0babfd)


Then, we calculated matrixes to quantify the accuracy of cell deconvolution (PCC, SSIM, RMSE, JSD, Jaccard). These indexes are calculated on for each locations (spots)/each cell type (clusters)/each spatial groups (regions, eg. ABCD region). A output figure will be generated and saved for each synthetic data.
![image](https://github.com/Sanofi-OneAI/oneai-dda-spatialone-deconvbenchmark/assets/49164740/920acaff-42f0-4af2-9e0b-2c891cf5095d)



Step-006 Comparative analysis, and code to generate figures in the presentation.
![image](https://github.com/Sanofi-OneAI/oneai-dda-spatialone-deconvbenchmark/assets/49164740/acaa7db8-c544-439e-88cb-ce0f4326c84d)

