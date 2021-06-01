#include <stdio.h>
void cacsole(int arr[],int n){
	for(int i=0;i<n;i++){
		if(arr[i]%2==1){
			printf("cac so le trong ham la %d \n",arr[i]);
		}
		
	}
}
int main(){
	int n;
	printf("Nhap kich thuoc mang\n");
	scanf("%d",&n);
	int arr[n];
	for(int i=0;i<n;i++){
		printf("Nhap so thu %d\n",i);
		scanf("%d",&arr[i]);
    }
    cacsole(arr,n);
}
    
