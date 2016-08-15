function sortPed(x::DataFrame,isOrderedLabels=true)
    
    m,n = size(x)
    
    ##initialize gene values to -1's 
    x[:gene]=repeat([-1],inner=[14])

    ## Set the top row of pedigree ( gene = 0)
    x[:gene][x[:sire].==x[:dam].=="NA"] = 0  


    ##Convert "NA" to 0 
    x[(x[:sire].=="NA"),:sire] = 0 
    x[(x[:dam].=="NA"),:dam] = 0 
    
    ##Sort Data by label
    if isOrderedLabels
        sort!(x, cols = :label)
    end
    
    ## append row of zeros to the bottom of the matrix 
    push!(df,[0 ,0, 0, 0])
    
    ## Loop over examples and assign gene values 
    
    for i in 1:size(x,1)
        
        if x[:sire][i].==x[:dam][i].==0
            continue
        end
        
        if (x[:gene][x[:label].==x[:sire][i]].>= x[:gene][x[:label].==x[:dam][i]])[1]
            x[:gene][i] = (x[:gene][x[:label].==x[:sire][i]] + 1)[1] 
        else 
            x[:gene][i] = (x[:gene][x[:label].==x[:dam][i]] + 1)[1]
        end

    end
    
    ## Delete bottom row of zeros 
    deleterows!(x,size(x,1))
    

    
end

