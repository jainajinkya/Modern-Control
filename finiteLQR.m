function SDot_Vec = finiteLQR(t, SVec)
global A B Q R

nState = size(A,1);
S = reshape(SVec,[nState, nState]);

SDot_Mat = -(Q + A'*S + S*A - S*B*inv(R)*B'*S);

SDot_Vec= reshape(SDot_Mat', [size(SDot_Mat,1)*size(SDot_Mat,2),1]);
end
