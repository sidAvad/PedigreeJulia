function GetSelfingPed(x::DataFrame)
    
    include("insertDataFrame.jl")
    
    ## convert label,sire and dam columns to floats if not already converted

    if eltype(x[:label])!=Float64 || eltype(x[:sire])!=Float64 || eltype(x[:dam])!=Float64
        println("Converting ...")
        df[:label]=map(Float64,df[:label])
        df[:sire]=map(Float64,df[:sire])
        df[:dam]=map(Float64,df[:dam])
        end

    ## Loop over DataFrame, and start inner loop if cyc>0. Call insertDataFrame after creating temp dataframe from inner loop
    
    i = 1
    
    while i < size(x,1)
        if x[i,:cyc] > 0
            temp = DataFrame(label=x[i,:label]+0.1,sire=x[i,:label],dam=x[i,:label],cyc=1)
            for j in 1:(x[i,:cyc]-1)
                push!(temp,[label=temp[j,:label]+0.1,sire=temp[j,:sire]+0.1,dam=temp[j,:dam]+0.1,cyc=j+1])
            end
            x = insertDataFrame(x,i+1,temp)
            i += size(temp,1)
        end    
        i += 1
    end
    
    
    ## Return final DataFrame
    
    return(x)
    
    
end
