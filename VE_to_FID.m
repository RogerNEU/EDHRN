for i=1:732
    rec_spec(i,:,:)=rec_spec(i,:,:)/factors_3D(i);
end

Rec=permute(rec_spec,[2,3,1]);
rec_fid=zeros(120,120,732);
for i=1:732
     rec_fid(:,:,i)=ifft2(ifftshift(Rec(:,:,i)));
end
SPP=rec_fid(1:60,1:60,:);
SPN=rec_fid(1:60,61:120,:);
SPN=fliplr(circshift(SPN,[0,-1]));
SPN(:,1,:)=SPP(:,1,:);

R1R2=real(SPP+SPN)/2;
I1R2=imag(SPP+SPN)/2;
I1I2=-(real(SPP-SPN)/2);
R1I2=imag(SPP-SPN)/2;

 
rec_FID=zeros(120,120,732);
rec_FID(1:2:end,1:2:end,:)=R1R2;
rec_FID(1:2:end,2:2:end,:)=R1I2;
rec_FID(2:2:end,1:2:end,:)=I1R2;
rec_FID(2:2:end,2:2:end,:)=I1I2;
save('./nmr/rec_FID.mat', 'rec_FID');