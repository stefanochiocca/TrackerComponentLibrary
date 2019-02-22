function azEl=uv2SpherAng(uv,systemType)
%%UV2SPHERANG Convert a u-v direction cosine pair into spherical
%             azimuth and element components in 3D. Direction cosines u and
%             v are the first two elements of a unit vector in 3D.
%             Optionally, the third component of the unit direction vector
%             [u;v;w] can be provided. When omitted, it is assumed that w
%             is positive to uniquely define a solution.
%
%INPUTS: uv A 2XN (for just u-v coordinate) or 3XN (if  the third unit
%           vector coordinate w is included) set of N direction cosines to
%           convert.
% systemType An optional parameter specifying the axis from which the
%           angles are measured in radians. Possible values are
%           0 (The default if omitted) Azimuth is measured 
%             counterclockwise from the x-axis in the x-y plane. Elevation
%             is measured up from the x-y plane (towards the z-axis). This
%             is consistent with common spherical coordinate systems for
%             specifying longitude (azimuth) and geocentric latitude
%             (elevation).
%           1 Azimuth is measured counterclockwise from the z-axis in the
%             z-x plane. Elevation is measured up from the z-x plane
%             (towards the y-axis). This is consistent with some spherical
%             coordinate systems that use the z-axis as the boresight
%             direction of the radar.
%           2 This is the same as 0 except instead of being given
%             elevation, one is given the angle away from the z-axis, which
%             is (pi/2-elevation).
%
%OUTPUTS: azEl The 2XN set of directions converted into spherical
%              coordinates. The angles are in radians.
%
%Direction cosines and spherical coordinate systems are discussed in [1].
%
%REFERENCES:
%[1] D. F. Crouse, "Basic tracking using nonlinear 3D monostatic and
%    bistatic measurements," IEEE Aerospace and Electronic Systems
%    Magazine, vol. 29, no. 8, Part II, pp. 4-53, Aug. 2014.
%
%June 2017 David F. Crouse, Naval Research Laboratory, Washington D.C.
%(UNCLASSIFIED) DISTRIBUTION STATEMENT A. Approved for public release.

if(nargin<2||isempty(systemType))
    systemType=0;
end

u=uv(1,:);
v=uv(2,:);
if(size(uv,1)>2)
    w=uv(3,:);
else
    %The real deals with potential rounding issues pushing the argument of
    %the square root negative.
    w=real(sqrt(1-u.^2-v.^2));
end

numPoints=size(uv,2);
azEl=zeros(2,numPoints);

switch(systemType)
    case 0
        azEl(1,:)=atan2(v,u);
        azEl(2,:)=asin(w);
    case 1
        azEl(1,:)=atan2(u,w);
        azEl(2,:)=asin(v);
    case 2
        azEl(1,:)=atan2(v,u);
        azEl(2,:)=acos(w);%pi/2-asin(w);
    otherwise
        error('Invalid system type specified.')
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
