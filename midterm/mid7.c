#include<stdio.h>

int main()
{
	int i,j,h;

	printf("Enter the number of rows: ");
	scanf("%d", &h);

	for(i=1;i<=h;i++)
	{
		for(j=1;j<=h-i;j++)
		{
			printf("\t");
		}

		for(j=1;j<=i;j++)
		{
			printf("%d\t", j);
		}

		for(j=i-1; j>0; j--)
		{
			printf("%d\t",j);
		}

		printf("\n");
	}

	return 0;
}