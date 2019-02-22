function [zQD,apexPoints,exitCode]=ITRS2QD(zCart,modSelParam,a,f,RelTol,AbsTol,maxSteps)
%%ITRS2QD Convert a Cartesian locations in the International Terrestrial
%         Reference System (ITRS), a type of Earth-Centered Earth-Fixed
%         (ECEF) system, into (non-Cartesian) quasi-dipole coordinates.
%         These coordinate systems relate to the Earth's magnetic field and
%         are useful when considering the ionosphere.
%
%INPUTS: zCart One or more points given in Cartesian coordinates in the
%              ITRS with units of meters. zCart is a 3XN matrix with each
%              column having the format [x;y;z]. One would generally 
%              assume that points are not underground.
%  modSelParam An optional parameter selecting or providing the magnetic
%              field model to use. If omitted or an empty matrix is passed,
%              the International Geomagnetic Reference Field (IGRF) at the
%              latest epoch of the model is used via the function
%              getIGRFCoeffs. Possible other values are
%              1) year The parameters of the IGRF for the specified epoch 
%               year are used. The year is in the Gregorian calendar and is
%               specified as noted in the comments to the getIGRFCoeffs
%               function.
%              2) modSelParam is a structure where modSelParam.algorithm
%               selects the algorithm to use Possible values for
%               modSelParam.algorithm are 'IGRF', 'WMM' and 'preloaded'. If
%               modSelParam.algorithm is 'IGRF or 'WMM', then the IGRF or
%               the World Magnetic Model (WMM) is used at the fractional
%               year specified by modSelParam.year (using the function
%               getIGRFCoeffs or getWMMCoeffs). If modSelParam.algorithm is
%               preloaded, then the parameters for the model are given by
%               the modSelParam.C, modSelParam.S, modSelParam.a, and
%               modSelParam.c, where the parameters have the same format as
%               the fully normalized outputs of getIGRFCoeffs or
%               getWMMCoeffs. See comments below for the use of custom
%               coeffients.
%            a The semi-major axis of the reference ellipsoid. The
%              determination of the apex of a magentic field line is
%              necessary to convert into QD coordinates and this is done
%              with respect to the maximum magnetic field line height
%              above the reference ellipsoid. If this argument is omitted
%              or an empty matrix is passed, the value in
%              Constants.WGS84SemiMajorAxis is used.
%            f The flattening factor of the reference ellipsoid. If this
%              argument is omitted or an empty matrix is passed, the value
%              in Constants.WGS84Flattening is used.
%       RelTol The maximum relative error tolerance allowed for the
%              Runge-Kutta algorithm to trace the path towards the apex. If
%              omitted or an empty matrix is passed, the default value of
%              1e-6 is used.
%       AbsTol The absolute error tolerance allowed, a positive scalar. If
%              omitted or an empty matrix is passed, the default value of
%              1e-9 is used. This is used in the Runge-Kutta algorithm to
%              trace along the path towards the apex, and it is used for
%              the fminbnd function to find the apex location once it has
%              been bounded.
%     maxSteps The maximum allowable number of steps to perform the
%              adaptive Runge-Kutta integration along a magnetic field line
%              to find the apex. If omitted, the default of 1024 is used.
%
%OUTPUTS: zQD A 3XN matrix of the points in zCart converted into QD
%             coordinates. This consists of [lambdaQD;phi;h] as in [1],
%             where phi is the centered-dipole longitude (radians), lambda
%             is the quasi-dipole latitude (radians), which arises by
%             tracing magnetic field lines, and h is the height of the
%             given point above the reference ellipsoid (meters). When very
%             close to the geomagnetic poles, lambdaQD is reduced to its
%             asymptotic value (because the apex height goes to Inf) and
%             phi is undefined as the actual apex location can no longer be
%             clearly determined, so a NaN will be returned for phi. If
%             exitCode~=0 for any point, an empty matrix is returned.
%  apexPoints A 3XN matrix of the apex points corresponding to the points
%             in zCart. The apex points are obtained by tracing the
%             magnetic field line starting from zCart until reaching the
%             point farthest from the reference ellipsoid. If exitCode~=0,
%             for any point, an empty matrix is returned.
%    exitCode A NX1 vector of codes indicating whether an error occurred.
%             If an error occurs, then the algorithm is halted at the
%             point causing the error.
%             0: Integration was successful.
%             1: Unable to get a small enough step size.
%             2: Apex not found within the maximum number of iterations.
%             3: Non-finite number encountered.
%             4: Problems performing a line search to the peak point.
%
%The quasi-dipole coordinate system is defined in [1]. It is similar to the
%apex coordinate system. The centered dipole longitude coordinate of QD
%coordinates is just found using the ITRS2CartCD and CartSphere functions.
%The ellipsoidal height is found using the Cart2Ellipse function. The final
%coordinate, the QD latitude, relies on computing the apex height.
%This is determined using the function trace2EarthMagApex to find the
%location of the magnetic apex. As noted in the comments to the
%trace2EarthMagApex, if custom magnetic models are used, then the function
%might produce the wrong result if a magnetic field line has more than one
%peak above the reference ellipsoid.
%
%REFERENCES:
%[1] A. D. Richmond, "Ionospheric electrodynamics using magnetic apex
%    coordinates," Journal of Geomagnetism and Geoelectricity, vol. 47,
%    no. 2, pp. 191-212, 1995.
%
%June 2015 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

if(nargin<3||isempty(modSelParam))
    %If no magnetic model is specified, use the IGRF at the reference
    %epoch.
    [C,S,aMagMod,cMagMod]=getIGRFCoeffs([],true);
elseif(isa(modSelParam,'double'))
    %If just a scalar is passed, assume that it is the epoch year for the
    %IGRF.
    [C,S,aMagMod,cMagMod]=getIGRFCoeffs(modSelParam,true);
else
    %Otherwise, a structrue should be passed indicating the model and the
    %year.
    switch(modSelParam.algorithm)
        case 'WMM'%World Magnetic Model
            [C,S,aMagMod,cMagMod]=getWMMCoeffs(modSelParam.year,true);
        case 'IGRF'%Intergnational Geomagnetic Reference Field
            [C,S,aMagMod,cMagMod]=getIGRFCoeffs(modSelParam.year,true);
        case 'preloaded'%Custom coefficients.
            C=modSelParam.C;
            S=modSelParam.S;
            aMagMod=modSelParam.a;
            cMagMod=modSelParam.c;
        otherwise
            error('Unknown model specified')
    end
end

if(nargin<4||isempty(a))
    a=Constants.WGS84SemiMajorAxis;
end

if(nargin<5||isempty(f))
    f=Constants.WGS84Flattening;
end

if(nargin<6)
    RelTol=[];
end

if(nargin<7)
    AbsTol=[];
end

if(nargin<8)
    maxSteps=[];
end

%Determine the apex points.
modSelParam.algorithm='preloaded';
modSelParam.C=C;
modSelParam.S=S;
modSelParam.a=aMagMod;
modSelParam.c=cMagMod;
[apexPoints,signVals,exitCode]=trace2EarthMagApex(zCart,modSelParam,a,f,RelTol,AbsTol,maxSteps);

%If there was an error determining the apex point locations, then return.
if(isempty(apexPoints))
    zQD=[];
    return;
end

%Otherwise, finish the conversion for all of the points.
numPoints=size(zCart,2);
zQD=zeros(3,numPoints);

for curPoint=1:numPoints
    zITRS=zCart(:,curPoint);
    apexPoint=apexPoints(:,curPoint);
    signVal=signVals(curPoint);
    
    %We have the apexPoint. We can now compute the QD coordinates. If the
    %apex point is infinite, then hA=Inf and the centered dipole longitude
    %is undefined.
    if(any(~isfinite(apexPoint)))
        hA=Inf;
        %Since the apex point is out near infinity somewhere, the longitude
        %of the point cannot be properly determined, so a NaN is returned
        %for the longitude.
        phi=NaN;
    else
        ellipsApex=Cart2Ellipse(apexPoint,[],a,f);
        hA=ellipsApex(3);%The ellipsoidal height of the apex point.
        %The longitude is the centered dipole longitude of the apex location;
        %The C inputs are C_{1,0}, C_{1,1}, and S_{1,1}
        ApexCDSpher=Cart2Sphere(ITRS2CartCD(apexPoint,C(2),C(3),S(3)));
        phi=ApexCDSpher(2);%The centered dipole longitude (azimuth).
    end
    
    zEllipse=Cart2Ellipse(zITRS,[],a,f);
    h=zEllipse(3);%The ellipsoidal height of the point.
    
    %The QD latitude. The sign is determined by the vertical component of
    %the magnetic field. That is, it is positive when the magnetic field
    %vector is pointing down (mostly the northern geographic hemisphere)
    %and negative when it is pointing up.
    lambdaQD=-signVal*acos(sqrt((a+h)/(a+hA)));

    zQD(:,curPoint)=[lambdaQD;phi;h];

    exitCode(curPoint)=0;
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
