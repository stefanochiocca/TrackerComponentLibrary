function [xi,w]=ninthOrderTetrahedronCubPoints()
%%NINTHORDERTETRAHEDRONCUBPOINTS Obtain ninth-order cubature points
%   for integration over a tetrahedron in 3D. The points and weights are
%   for the tetrahedron with vertices (1,0,0), (0,1,0), (0,0,1), and
%   (0,0,0), but can be transformed to any tetrahedron using
%   transformSimplexTetrahedronPts.
%
%INPUTS: None
%
%OUTPUTS: xi This is a 3XnumCubPoints set of points for the standard
%            tetrahedron.
%          w A 1XnumCubPoints set of cubature weights. This sums to the
%            volume of the standard tetrahedron (1/6).
%
%This function implements the points given in [1] (59 points).
%
%EXAMPLE:
%Given the vertices of the simplex, we compare a ninth-order moment
%computed using these cubature points to one computed using
%monomialIntSimplex. The results are the same within typical finite
%precision limits.
% [xi,w]=ninthOrderTetrahedronCubPoints();
% alpha=[4;3;2];
% theMoment=findMomentFromSamp(alpha,xi,w);
% intVal=monomialIntSimplex(alpha);
% RelErr=(theMoment-intVal)/intVal
%
%REFERENCES:
%[1] F. D. Witherden and P. E. Vincent, "On the identification of symmetric
%    quadrature rules for finite element methods," Computer and Mathematics
%    with Applications, vol. 69, no. 10, pp. 1232-1241, May 2015.
%
%October 2022 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

M=[                                    -0.5,                                         -0.5,                                         -0.5,     0.07734739854997367644741906257553729918;
  -0.99999999876036601109069831529161985423,    -0.99999999876036601109069831529161985423,      0.9999999962810980332720949458748595627,  8.5759042345675186085903030258742437834e-05;
  -0.99999999876036601109069831529161985423,      0.9999999962810980332720949458748595627,    -0.99999999876036601109069831529161985423,  8.5759042345675186085903030258742437834e-05;
    0.9999999962810980332720949458748595627,    -0.99999999876036601109069831529161985423,    -0.99999999876036601109069831529161985423,  8.5759042345675186085903030258742437834e-05;
  -0.99999999876036601109069831529161985423,    -0.99999999876036601109069831529161985423,    -0.99999999876036601109069831529161985423,  8.5759042345675186085903030258742437834e-05;
  -0.67845092920947681169601712222921603853,    -0.67845092920947681169601712222921603853,    0.035352787628430435088051366687648115583,    0.030897784616567277310532826869162311937;
  -0.67845092920947681169601712222921603853,    0.035352787628430435088051366687648115583,    -0.67845092920947681169601712222921603853,    0.030897784616567277310532826869162311937;
  0.035352787628430435088051366687648115583,    -0.67845092920947681169601712222921603853,    -0.67845092920947681169601712222921603853,    0.030897784616567277310532826869162311937;
  -0.67845092920947681169601712222921603853,    -0.67845092920947681169601712222921603853,    -0.67845092920947681169601712222921603853,    0.030897784616567277310532826869162311937;
  -0.35544695635715805159186380319222134027,    -0.35544695635715805159186380319222134027,    -0.93365913092852584522440859042333597919,    0.039417216447239047523644877985518239107;
  -0.35544695635715805159186380319222134027,    -0.93365913092852584522440859042333597919,    -0.35544695635715805159186380319222134027,    0.039417216447239047523644877985518239107;
  -0.93365913092852584522440859042333597919,    -0.35544695635715805159186380319222134027,    -0.35544695635715805159186380319222134027,    0.039417216447239047523644877985518239107;
  -0.35544695635715805159186380319222134027,    -0.35544695635715805159186380319222134027,    -0.35544695635715805159186380319222134027,    0.039417216447239047523644877985518239107;
  -0.90978216330917283407807385501200614331,    -0.90978216330917283407807385501200614331,     0.72934648992751850223422156503601842994,    0.010751973306154910354337519688619045729;
  -0.90978216330917283407807385501200614331,     0.72934648992751850223422156503601842994,    -0.90978216330917283407807385501200614331,    0.010751973306154910354337519688619045729;
   0.72934648992751850223422156503601842994,    -0.90978216330917283407807385501200614331,    -0.90978216330917283407807385501200614331,    0.010751973306154910354337519688619045729;
  -0.90978216330917283407807385501200614331,    -0.90978216330917283407807385501200614331,    -0.90978216330917283407807385501200614331,    0.010751973306154910354337519688619045729;
  -0.77540690799124790934402070093968875729,    -0.22459309200875209065597929906031124271,    -0.22459309200875209065597929906031124271,     0.05084544013826995406889748131136091475;
  -0.22459309200875209065597929906031124271,    -0.77540690799124790934402070093968875729,    -0.22459309200875209065597929906031124271,     0.05084544013826995406889748131136091475;
  -0.77540690799124790934402070093968875729,    -0.77540690799124790934402070093968875729,    -0.22459309200875209065597929906031124271,     0.05084544013826995406889748131136091475;
  -0.77540690799124790934402070093968875729,    -0.22459309200875209065597929906031124271,    -0.77540690799124790934402070093968875729,     0.05084544013826995406889748131136091475;
  -0.22459309200875209065597929906031124271,    -0.77540690799124790934402070093968875729,    -0.77540690799124790934402070093968875729,     0.05084544013826995406889748131136091475;
  -0.22459309200875209065597929906031124271,    -0.22459309200875209065597929906031124271,    -0.77540690799124790934402070093968875729,     0.05084544013826995406889748131136091475;
    -0.994890841533917338064711949103255315,   -0.082257102495081453456435781598997046246,    -0.84059495347591975502241648769875059251,    0.011179229597731402927583520512290878612;
    -0.994890841533917338064711949103255315,   -0.082257102495081453456435781598997046246,   -0.082257102495081453456435781598997046246,    0.011179229597731402927583520512290878612;
 -0.082257102495081453456435781598997046246,   -0.082257102495081453456435781598997046246,      -0.994890841533917338064711949103255315,    0.011179229597731402927583520512290878612;
  -0.84059495347591975502241648769875059251,      -0.994890841533917338064711949103255315,   -0.082257102495081453456435781598997046246,    0.011179229597731402927583520512290878612;
 -0.082257102495081453456435781598997046246,    -0.84059495347591975502241648769875059251,      -0.994890841533917338064711949103255315,    0.011179229597731402927583520512290878612;
 -0.082257102495081453456435781598997046246,      -0.994890841533917338064711949103255315,   -0.082257102495081453456435781598997046246,    0.011179229597731402927583520512290878612;
  -0.84059495347591975502241648769875059251,   -0.082257102495081453456435781598997046246,      -0.994890841533917338064711949103255315,    0.011179229597731402927583520512290878612;
 -0.082257102495081453456435781598997046246,    -0.84059495347591975502241648769875059251,   -0.082257102495081453456435781598997046246,    0.011179229597731402927583520512290878612;
 -0.082257102495081453456435781598997046246,   -0.082257102495081453456435781598997046246,    -0.84059495347591975502241648769875059251,    0.011179229597731402927583520512290878612;
 -0.082257102495081453456435781598997046246,      -0.994890841533917338064711949103255315,    -0.84059495347591975502241648769875059251,    0.011179229597731402927583520512290878612;
  -0.84059495347591975502241648769875059251,   -0.082257102495081453456435781598997046246,   -0.082257102495081453456435781598997046246,    0.011179229597731402927583520512290878612;
    -0.994890841533917338064711949103255315,    -0.84059495347591975502241648769875059251,   -0.082257102495081453456435781598997046246,    0.011179229597731402927583520512290878612;
   0.43670065288414901811354448912928750012,    -0.93244825862932284418902737202159413719,    -0.57180413562550332973548974508609922574,    0.013646079136993770600501763121325612648;
   0.43670065288414901811354448912928750012,    -0.93244825862932284418902737202159413719,    -0.93244825862932284418902737202159413719,    0.013646079136993770600501763121325612648;
  -0.93244825862932284418902737202159413719,    -0.93244825862932284418902737202159413719,     0.43670065288414901811354448912928750012,    0.013646079136993770600501763121325612648;
  -0.57180413562550332973548974508609922574,     0.43670065288414901811354448912928750012,    -0.93244825862932284418902737202159413719,    0.013646079136993770600501763121325612648;
  -0.93244825862932284418902737202159413719,    -0.57180413562550332973548974508609922574,     0.43670065288414901811354448912928750012,    0.013646079136993770600501763121325612648;
  -0.93244825862932284418902737202159413719,     0.43670065288414901811354448912928750012,    -0.93244825862932284418902737202159413719,    0.013646079136993770600501763121325612648;
  -0.57180413562550332973548974508609922574,    -0.93244825862932284418902737202159413719,     0.43670065288414901811354448912928750012,    0.013646079136993770600501763121325612648;
  -0.93244825862932284418902737202159413719,    -0.57180413562550332973548974508609922574,    -0.93244825862932284418902737202159413719,    0.013646079136993770600501763121325612648;
  -0.93244825862932284418902737202159413719,    -0.93244825862932284418902737202159413719,    -0.57180413562550332973548974508609922574,    0.013646079136993770600501763121325612648;
  -0.93244825862932284418902737202159413719,     0.43670065288414901811354448912928750012,    -0.57180413562550332973548974508609922574,    0.013646079136993770600501763121325612648;
  -0.57180413562550332973548974508609922574,    -0.93244825862932284418902737202159413719,    -0.93244825862932284418902737202159413719,    0.013646079136993770600501763121325612648;
   0.43670065288414901811354448912928750012,    -0.57180413562550332973548974508609922574,    -0.93244825862932284418902737202159413719,    0.013646079136993770600501763121325612648;
  -0.93116817884364945982158957577713628669,    -0.63271726038014422042206258028726154683,     0.19660269960393790066571473635165938035,    0.027366554623984184053091789082666607808;
  -0.93116817884364945982158957577713628669,    -0.63271726038014422042206258028726154683,    -0.63271726038014422042206258028726154683,    0.027366554623984184053091789082666607808;
  -0.63271726038014422042206258028726154683,    -0.63271726038014422042206258028726154683,    -0.93116817884364945982158957577713628669,    0.027366554623984184053091789082666607808;
   0.19660269960393790066571473635165938035,    -0.93116817884364945982158957577713628669,    -0.63271726038014422042206258028726154683,    0.027366554623984184053091789082666607808;
  -0.63271726038014422042206258028726154683,     0.19660269960393790066571473635165938035,    -0.93116817884364945982158957577713628669,    0.027366554623984184053091789082666607808;
  -0.63271726038014422042206258028726154683,    -0.93116817884364945982158957577713628669,    -0.63271726038014422042206258028726154683,    0.027366554623984184053091789082666607808;
   0.19660269960393790066571473635165938035,    -0.63271726038014422042206258028726154683,    -0.93116817884364945982158957577713628669,    0.027366554623984184053091789082666607808;
  -0.63271726038014422042206258028726154683,     0.19660269960393790066571473635165938035,    -0.63271726038014422042206258028726154683,    0.027366554623984184053091789082666607808;
  -0.63271726038014422042206258028726154683,    -0.63271726038014422042206258028726154683,     0.19660269960393790066571473635165938035,    0.027366554623984184053091789082666607808;
  -0.63271726038014422042206258028726154683,    -0.93116817884364945982158957577713628669,     0.19660269960393790066571473635165938035,    0.027366554623984184053091789082666607808;
   0.19660269960393790066571473635165938035,    -0.63271726038014422042206258028726154683,    -0.63271726038014422042206258028726154683,    0.027366554623984184053091789082666607808;
  -0.93116817884364945982158957577713628669,     0.19660269960393790066571473635165938035,    -0.63271726038014422042206258028726154683,    0.027366554623984184053091789082666607808];
w=M(:,4);
xi=M(:,1:3)';
%Transform the points to the standard tetrahedron.
v1=[-1, 1,-1,-1;
    -1,-1,-1, 1;
    -1,-1, 1, -1];
v2=[1,0,0,0;
    0,1,0,0;
    0,0,1,0];
[A,d]=affineTransBetweenTetrahedra(v1,v2);
xi=bsxfun(@plus,A*xi,d);
w=w/8;
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
