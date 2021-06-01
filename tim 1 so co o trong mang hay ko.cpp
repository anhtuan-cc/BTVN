#include <stdio.h>
bool timso(int arr[], int n, int y){
	for(int i=0;i<n;i++){
		if(arr[i]==y){
			return true;
		}
	}
	return false;
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
	int x;
	printf("nhap so kiem tra: ");
	scanf("%d",&x);
	bool kt=timso(arr,n,x);
	if(kt){
		printf("%d co trong mang",x);
		
	}else{
		printf("%d ko co trong mang",x);
	}
		}

