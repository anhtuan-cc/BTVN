#include <stdio.h>
int ucln(int a,int b){
	if(a==0&&b==0){
		printf("ko co uoc chung lon nhat");
	}else{
		if(a==0||b==0){
			printf("uoc chung lon nhat la: %d",a+b);
		}else{
			int min;
			if(a<b){
				min=a;
			}
			else{
				min=b;
			}
			for(int i=min;i>=1;i--){
				if(a%i==0&&b%i==0){
					printf("uoc chung lon la: %d",i);break;
				}
			}
		}
	}
	
}
int main(){
	int a,b;
	printf("nhap 2 so a va b: \n ");
	scanf("%d",&a);
	scanf("%d",&b);
	ucln(a,b);
}
