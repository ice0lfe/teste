#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define SIZE 4
#define PAGES 32

typedef struct{
	char *sname;
	char type;
	int length;
}mtdados;
typedef struct{
	int ntup;
	mtdados dt[SIZE];
}mttype;


int main()
{
	FILE *mdb=NULL,*db=NULL;
	char *mdt="file/meta.dat";
	char *data="file/data.dat";
	if( (mdb = fopen(mdt,"r"))==NULL){
		printf("Nao foi possivel abrir o arquivo\n");
	};
	int a=0,b=0;
	mttype *mt=NULL;
	mt=(mttype*)malloc(sizeof(mttype));
	char **out=NULL;
	out=(char**)malloc(sizeof(char*)*SIZE);
	fread(&a,sizeof(int),1,mdb);
	printf("numero de campos: %d \n",a);
	mt->ntup=a;
	int i=0,c=0;
	for(i=0;i<a;i++){
		out[i]=(char*)malloc(sizeof(char)*8);	
		switch (i){
		case 0:
			c=5;
			break;
		case 1:
			c=6;
			break;
		case 2:
			c=4;
			break;
		case 3:
			c=6;
			break;
		};
		fread(out[i],sizeof(char),c,mdb);
		mt->dt[i].sname=out[i];
		printf("Campo: %s\n",mt->dt[i].sname);
		fread(&out[i][c],sizeof(char),1,mdb);
		mt->dt[i].type=out[i][c];
		printf("Tipo %s\n",&mt->dt[i].type);
		fread(&b,sizeof(int),1,mdb);
		mt->dt[i].length=b;
		printf("Tamanho %d\n",mt->dt[i].length);
	};
	fclose(mdb);
	
	if((db=fopen(data,"r+"))==NULL){
		printf("Nao foi possivel abrir arquivo");
	};
	
	
	fclose(db);
	for(i=0;i<SIZE;i++)
		free(out[i]);
	free(out);
	free(mt);
	return 0;
}
