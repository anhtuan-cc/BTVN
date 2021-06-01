#include <stdio.h>
int bcnn(int a,int b){
	if(a==0||b==0){
		printf("boi chung bang 0");
	}else{
		for(int i=1;i<=a*b;i++){
			if(i%a==0&&i%b==0){
	printf("uoc chung lon nhat cua %d va %d la: %d \n",a,b,i);break;}
	}
}
}
int main(){

		int a,b,i;
	printf("nhap so thu nhat: ",a);
	scanf("%d",&a);
	printf("nhap so thu hai: ",b);
	scanf("%d",&b);
	bcnn(a,b);
}
