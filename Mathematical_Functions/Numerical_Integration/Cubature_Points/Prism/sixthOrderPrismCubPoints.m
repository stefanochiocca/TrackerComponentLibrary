function [xi,w]=sixthOrderPrismCubPoints()
%%SIXTHORDERPRISMCUBPOINTS Generate sixth-order cubature points for
%  integration over a standard prism in 3D. This is a triangle that has
%  been extruded upward. The vertices are (1,-1,-1), (-1,-1,-1), (-1,1,-1),
%  (1,-1,1), (-1,-1,1), and (-1,1,1).
% 
%INPUTS: None
%
%OUTPUTS: xi This is a 3XnumCubPoints set of points for the standard prism.
%          w A 1XnumCubPoints set of cubature weights. This sums to the
%            volume of the standard prism (4).
%
%This function implements the points given in [1] (28 points).
%
%EXAMPLE:
%We compare a 6th-order moment computed using these cubature points
%to one computed using monomialIntPrism. The results are the same within
%typical finite precision limits.
% [xi,w]=sixthOrderPrismCubPoints();
% alpha=[2;2;2];
% theMoment=findMomentFromSamp(alpha,xi,w);
% intVal=monomialIntPrism(alpha);
% RelErr=(theMoment-intVal)/intVal
%
%REFERENCES:
%[1] F. D. Witherden and P. E. Vincent, "On the identification of symmetric
%    quadrature rules for finite element methods," Computer and Mathematics
%    with Applications, vol. 69, no. 10, pp. 1232-1241, May 2015.
%
%October 2022 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

M=[-0.33333333333333333333333333333333333333,   -0.33333333333333333333333333333333333333,   -0.52662270480497475869798007748379244322,    0.22269313409222502250038629788629976598;
 -0.33333333333333333333333333333333333333,   -0.33333333333333333333333333333333333333,    0.52662270480497475869798007748379244322,    0.22269313409222502250038629788629976598;
 -0.33333333333333333333333333333333333333,   -0.33333333333333333333333333333333333333,   -0.99083630081924474869286718300205167763,    0.13839610937412451172575590081432159364;
 -0.33333333333333333333333333333333333333,   -0.33333333333333333333333333333333333333,    0.99083630081924474869286718300205167763,    0.13839610937412451172575590081432159364;
 -0.66959346994381506531292392577889361708,    0.33918693988763013062584785155778723416,                                           0,    0.31182801481333532900066338577135735737;
  0.33918693988763013062584785155778723416,   -0.66959346994381506531292392577889361708,                                           0,    0.31182801481333532900066338577135735737;
 -0.66959346994381506531292392577889361708,   -0.66959346994381506531292392577889361708,                                           0,    0.31182801481333532900066338577135735737;
 -0.95905346077548616195214584157965381704,    0.91810692155097232390429168315930763408,                                           0,   0.050146535238696554002545078611329875622;
  0.91810692155097232390429168315930763408,   -0.95905346077548616195214584157965381704,                                           0,   0.050146535238696554002545078611329875622;
 -0.95905346077548616195214584157965381704,   -0.95905346077548616195214584157965381704,                                           0,   0.050146535238696554002545078611329875622;
-0.067776668819680981202280000599855057023,   -0.86444666236063803759543999880028988595,   -0.48167413488438751267079566597126764678,    0.19605056020608216687021916179149498019;
 -0.86444666236063803759543999880028988595,  -0.067776668819680981202280000599855057023,   -0.48167413488438751267079566597126764678,    0.19605056020608216687021916179149498019;
-0.067776668819680981202280000599855057023,  -0.067776668819680981202280000599855057023,   -0.48167413488438751267079566597126764678,    0.19605056020608216687021916179149498019;
-0.067776668819680981202280000599855057023,   -0.86444666236063803759543999880028988595,    0.48167413488438751267079566597126764678,    0.19605056020608216687021916179149498019;
 -0.86444666236063803759543999880028988595,  -0.067776668819680981202280000599855057023,    0.48167413488438751267079566597126764678,    0.19605056020608216687021916179149498019;
-0.067776668819680981202280000599855057023,  -0.067776668819680981202280000599855057023,    0.48167413488438751267079566597126764678,    0.19605056020608216687021916179149498019;
 -0.59485220654953844609181984939099585377,    0.52549348166744454603903998678937679713,   -0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
  0.52549348166744454603903998678937679713,   -0.59485220654953844609181984939099585377,   -0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.93064127511790609994722013739838094335,    0.52549348166744454603903998678937679713,   -0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
  0.52549348166744454603903998678937679713,   -0.93064127511790609994722013739838094335,   -0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.93064127511790609994722013739838094335,   -0.59485220654953844609181984939099585377,   -0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.59485220654953844609181984939099585377,   -0.93064127511790609994722013739838094335,   -0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.59485220654953844609181984939099585377,    0.52549348166744454603903998678937679713,    0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
  0.52549348166744454603903998678937679713,   -0.59485220654953844609181984939099585377,    0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.93064127511790609994722013739838094335,    0.52549348166744454603903998678937679713,    0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
  0.52549348166744454603903998678937679713,   -0.93064127511790609994722013739838094335,    0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.93064127511790609994722013739838094335,   -0.59485220654953844609181984939099585377,    0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722;
 -0.59485220654953844609181984939099585377,   -0.93064127511790609994722013739838094335,    0.80928579325583275231645432806703865787,   0.084632875139559356776397936558477141722];

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
