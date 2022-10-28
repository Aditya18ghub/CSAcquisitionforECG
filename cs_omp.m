%************************************************************************%
function hat_x=cs_omp(y,T_Mat,m)
% Reference: J. Tropp and A. Gilbert, ��Signal Recovery from Random 
% Measurements via Orthogonal Matching Pursuit,�� 2007.

% y=T_Mat*x, T_Mat is n-by-m
% y - measurements
% T_Mat - combination of random matrix and sparse representation basis
% m - size of the original signal
% the sparsity is length(y)/4

n=length(y);
s=4*floor(n/4);                                     %  ����ֵά��
hat_x=zeros(1,m);                                 %  ���ع�������(�任��)����                     
Aug_t=[];                                         %  ��������(��ʼֵΪ�վ���)
r_n=y;                                            %  �в�ֵ 

for times=1:s;                                  %  ��������(ϡ����ǲ�����1/4)

    product=abs(T_Mat'*r_n);
    
    [val,pos]=max(product);                       %  ���ͶӰϵ����Ӧ��λ��
    Aug_t=[Aug_t,T_Mat(:,pos)];                   %  ��������
    T_Mat(:,pos)=zeros(n,1);                      %  ѡ�е������㣨ʵ����Ӧ��ȥ����Ϊ�˼򵥽������㣩
    aug_x=(Aug_t'*Aug_t)^(-1)*Aug_t'*y;           %  ��С����,ʹ�в���С
    r_n=y-Aug_t*aug_x;                            %  �в�
    pos_array(times)=pos;                         %  ��¼���ͶӰϵ����λ��
    
end
hat_x(pos_array)=aug_x;                           %  �ع������� 


