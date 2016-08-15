function insertDataFrame(x::DataFrame,j::Int64,r::DataFrame)

### Function that inserts a dataframe/row at the jth position of x ### 

## store the jth to last rows in temporary dataframe 

tempdf = x[j:size(x,1),:]

## delete those rows from dataframe 

x = x[1:j-1,:]

## append r to new x 

append!(x,r)

## append tempdf 

append!(x,tempdf)

return(x)

end

