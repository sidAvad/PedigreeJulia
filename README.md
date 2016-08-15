# PedigreeJulia
Scripts for Pedigree Analysis in Julia

This Repo Contains scripts that:

1) Create a valid pedigree object in Julia ( using DataFrames ) by sorting the pedigree according to generation. ( sortPed.jl)

2) Compute the relationship matrix from a valid pedigree DataFrame object.(ComputeRelationshipMatrix.jl)

3) Extends a pedigree to account for no. of selfing cycles (InsertDataFrame.jl + GetSelfingPed.jl)

