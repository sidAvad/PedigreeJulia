function ComputeRelationshipMatrix(x::DataFrame)
    
    x2 = copy(x)
    
    ##Initialize M
    
    M = zeros(size(x,1),size(x,1))
    
    ## remove entries with both parents unknown 
    
    x = x[x[:sire].!=x[:dam],:] 
    
    ##Compute M
    
    for i in 1:size(x,1)
        x[:dam][i].==0?M[x[:label][i],x[:label][i]] = 0:M[x[:label][i],x[:dam][i]] = 0.5
        x[:sire][i].==0?M[x[:label][i],x[:label][i]] = 0:M[x[:label][i],x[:sire][i]] = 0.5
    end
    
    ##Compute Tinv
    
    Tinv = eye(size(M,1)).-M
    
    ##Compute T 
    
    T = Tinv^-1
    
    ##Compute L matrix
    
    L = zeros(size(x2,1),size(x2,1))
    
   
    ## Set all zeros in matrix to length of matrix 
    
    x2[(x2[:sire].==0),:sire] = size(x2,1) 
    x2[(x2[:dam].==0),:dam] = size(x2,1)
    
    
    ## Implement algorithm for computing the elements of L using nested for loops
   
    for i in 1:size(x2,1)
        if x2[:sire][i]==x2[:dam][i]==size(x2,1)
            L[i,i] = 1
        end
        for j in 1:i
            if i==j
                L[i,j] = sqrt(1.0-0.25*(sum(L[x2[:sire][x2[:label].==i][1],1:x2[:sire][x2[:label].==i][1]].^2)+
                            sum(L[x2[:dam][x2[:label].==i][1],1:x2[:dam][x2[:label].==i][1]].^2)))
            else
                L[i,j] = 0.5*(L[x2[:sire][x2[:label].==i][1],j]+L[x2[:dam][x2[:label].==i][1],j])

            end
        end
    end            
                
    
    ## D-matrix computed from L matrix
    
    D = diagm(diag(L).^2)
    
    ## Final Calculation of Relationship Matrix 
    
    T_D = *(T,D)
    A = *(T_D,T')
    
    return(A)

end

    