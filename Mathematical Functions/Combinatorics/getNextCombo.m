function I=getNextCombo(I,n,startVal)
%%GETNEXTCOMBO Return the next combination in lexicographic order given the
%              current combination. If the final combination in the
%              sequence has been reached, then an empty matrix is returned.
%              The first element in the combination is the least
%              significant element for defining the lexicographic order.
%
%INPUTS: I The rX1 or 1Xr current combination of r elements. The next
%          combination in lexicographic order is desired. The first element
%          is the least significant and one begins with I=[0;1;2;...;r-1]
%          is startVal=0 and I=[1;2;3;...;r] if startVal=1.
%        n The number of items from which r items are chosen for
%          combinations. The elements of I can range from 0 to n-1. if
%          startVal=0 or they range from 1 to n if startVal=1.
% startVal This is zero or 1, indicating which value the value at which the
%          elements in I can start. The default if omitted or an empty
%          matrix is passed is 0.
%
%OUTPUTS: I The next combination in the lexicographic sequence, or an empty
%           matrix if the final combination in the lexicographic ordering
%           is provided.
%
%This function can be useful for generating combinations when used in a
%loop. It is more computationally efficient than sequentially unranking the
%combinations. If the final combination is put in, an empty matrix will be
%returned.
%
%The algorithm is from [1], with an option to start at 0 instead of 1.
%
%REFERENCES:
%[1] C. J. Mifsud, "Algorithm 154: Combination in lexicographical order," 
%    Communications of the ACM, vol. 6, no. 3 pp. 103, Mar. 1963.
%    modified to start from zero instead of one.
%
%September 2013 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

if(nargin<3||isempty(startVal))
    startVal=0; 
end

if(startVal==0)
    r=length(I);
    if(I(r)<n-1)
        I(r)=I(r)+1;
        return
    else
        for j=r:-1:2
           if(I(j-1)<n-r+j-2)
               I(j-1)=I(j-1)+1;
               for s=j:1:r
                  I(s)=I(j-1)+s-(j-1); 
               end
               return;
           end
        end
        I=[];
    end
else%startVal=1
    r=length(I);
    if(I(r)<n)
        I(r)=I(r)+1;
        return
    else
        for j=r:-1:2
           if(I(j-1)<n-r+j-1)
               I(j-1)=I(j-1)+1;
               for s=j:1:r
                  I(s)=I(j-1)+s-(j-1); 
               end
               return;
           end
        end
        I=[];
    end
end
end

%LICENSE:
%
%The source code is in the public domain and not licensed or under
%copyright. The information and software may be used freely by the public.
%As required by 17 U.S.C. 403, third parties producing copyrighted works
%consisting predominantly of the material produced by U.S. government
%agencies must provide notice with such work(s) identifying the U.S.
%Government material incorporated and stating that such material is not
%subject to copyright protection.
%
%Derived works shall not identify themselves in a manner that implies an
%endorsement by or an affiliation with the Naval Research Laboratory.
%
%RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE OF THE
%SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO INDEMNIFY THE NAVAL
%RESEARCH LABORATORY FOR ALL THIRD-PARTY CLAIMS RESULTING FROM THE ACTIONS
%OF RECIPIENT IN THE USE OF THE SOFTWARE.
