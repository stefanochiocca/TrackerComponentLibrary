function [xi,w]=ninthOrder3DCubPoints()
%%NINTHORDER3DCUBPOINTS Generate ninth-order cubature points
%               for integration over a 3-dimensional cube with vertices of 
%               (1,-1,-1), (-1,-1,-1), (-1,1,-1), (1,1,-1), (1,-1,1),
%               (-1,-1,1), (-1,1,1), and (1,1,1).
%
%INPUTS: None
%
%OUTPUTS: xi This is a 3XnumCubPoints set of points for the standard
%            cube.
%          w A 1XnumCubPoints set of cubature weights. This sums to the
%            volume of the standard cube (8).
%
%This function implements the points given in [1] (58 points).
%
%EXAMPLE:
%We compare an 8th-order moment computed using these cubature points
%to one computed using monomialIntCube (a 9th order moment would have
%just been 0). The results are the same within typical finite precision
%limits.
% [xi,w]=ninthOrder3DCubPoints();
% alpha=[4;2;2];
% theMoment=findMomentFromSamp(alpha,xi,w);
% intVal=monomialIntCube(alpha);
% RelErr=(theMoment-intVal)/intVal
%
%REFERENCES:
%[1] F. D. Witherden and P. E. Vincent, "On the identification of symmetric
%    quadrature rules for finite element methods," Computer and Mathematics
%    with Applications, vol. 69, no. 10, pp. 1232-1241, May 2015.
%
%October 2022 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

M=[-0.61368146959170899383488488974055688452,                                          0,                                          0,   0.43327499574965454300983079319432200813;
                                        0,                                          0,   0.61368146959170899383488488974055688452,   0.43327499574965454300983079319432200813;
                                        0,   0.61368146959170899383488488974055688452,                                          0,   0.43327499574965454300983079319432200813;
                                        0,                                          0,  -0.61368146959170899383488488974055688452,   0.43327499574965454300983079319432200813;
 0.61368146959170899383488488974055688452,                                          0,                                          0,   0.43327499574965454300983079319432200813;
                                        0,  -0.61368146959170899383488488974055688452,                                          0,   0.43327499574965454300983079319432200813;
 0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
-0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
-0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
-0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
-0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
 0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
 0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
 0.87009978466197591761506380886392483306,  -0.87009978466197591761506380886392483306,   0.87009978466197591761506380886392483306,  0.050148795299349029867451487724661687604;
 0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
-0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
-0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
-0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
-0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
 0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
 0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
 0.56411080702003005426661899866307283066,  -0.56411080702003005426661899866307283066,   0.56411080702003005426661899866307283066,   0.19885983814402350032086871858560920797;
-0.87768712325767828648677575899433236264,  -0.87768712325767828648677575899433236264,                                          0,  0.091789806136177642171244588919646331302;
 0.87768712325767828648677575899433236264,                                          0,  -0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
                                        0,   0.87768712325767828648677575899433236264,  -0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
 0.87768712325767828648677575899433236264,   0.87768712325767828648677575899433236264,                                          0,  0.091789806136177642171244588919646331302;
 0.87768712325767828648677575899433236264,                                          0,   0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
                                        0,  -0.87768712325767828648677575899433236264,   0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
                                        0,  -0.87768712325767828648677575899433236264,  -0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
-0.87768712325767828648677575899433236264,                                          0,   0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
-0.87768712325767828648677575899433236264,   0.87768712325767828648677575899433236264,                                          0,  0.091789806136177642171244588919646331302;
 0.87768712325767828648677575899433236264,  -0.87768712325767828648677575899433236264,                                          0,  0.091789806136177642171244588919646331302;
                                        0,   0.87768712325767828648677575899433236264,   0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
-0.87768712325767828648677575899433236264,                                          0,  -0.87768712325767828648677575899433236264,  0.091789806136177642171244588919646331302;
 0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
 0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
-0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
 0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
-0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,   0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
-0.43226790263086216441602486151694383909,   0.93853042186467174532897686960307879508,   0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379;
 0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,  -0.93853042186467174532897686960307879508,   0.09611680351337336643247993847150603379;
-0.93853042186467174532897686960307879508,  -0.43226790263086216441602486151694383909,  -0.43226790263086216441602486151694383909,   0.09611680351337336643247993847150603379];

w=M(:,4);
xi=M(:,1:3)';

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
