	.arch armv5t   										--arquitetura
	.fpu softvfp   
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"file/meta.dat\000"							--caminho para meta.dat
	.align	2
.LC1:
	.ascii	"file/data.dat\000"							--caminho para data.dat
	.align	2
.LC2:
	.ascii	"r\000"										--r para o 2 atributo do fopen 'read only' 
	.align	2
.LC3:
	.ascii	"Nao foi possivel abrir o arquivo\000"		--se nao conseguir abrir meta.dat
	.align	2
.LC4:
	.ascii	"numero de campos: %d \012\000"
	.align	2
.LC5:
	.ascii	"Campo: %s\012\000"
	.align	2
.LC6:
	.ascii	"Tipo %s\012\000"
	.align	2
.LC7:
	.ascii	"Tamanho %d\012\000"
	.align	2
.LC8:
	.ascii	"r+\000"
	.align	2
.LC9:													--se nao conseguir abrir data.dat
	.ascii	"Nao foi possivel abrir arquivo\000"
	.align	2
.LC10:
	.ascii	"nao existe memoria para o buffer\000"
	.align	2
.LC11:
	.ascii	"%lf\012\000"
	.align	2
.LC12:
	.ascii	"%d\012\000" 
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}		--lista de registradores a serem lidos
	add	fp, sp, #8  			--fp=sp+8
	sub	sp, sp, #60 			--sp=sp-60
	mov	r3, #0  			--r3=0
	str	r3, [fp, #-52] 			--(fp-52)=r3	(fp-52)<=FILE *mdb=NULL
	mov	r3, #0				--r3=0
	str	r3, [fp, #-48]			--fp-48=r3	(fp-48)<=FILE *db=NULL
	ldr	r3, .L28			--r3= .LC0 r3<=conteudo char *mdt
	str	r3, [fp, #-44]			--(fp-44)=r3 => char *mdt = (fp-44)
	ldr	r3, .L28+4			--r3= .LC1 r3<=conteudo char *data
	str	r3, [fp, #-40]			--(fp-40)=r3 => char *data =(fp-40)
	ldr	r0, [fp, #-44]			--r0=(fp-44) r0<= *mdt
	ldr	r1, .L28+8			--r1= .LC2  r1<=operação para abertura do arquivo 'r'
	bl	fopen				--function fopen(arq-name.*,format to open) in this case ("file/meta.dat","r") read-only
	str	r0, [fp, #-52]			--(fp-52)=r0 resultado do fopen é guardado no r0 e do r0 para o endereço (fp-52) *mdb
	ldr	r3, [fp, #-52]			--r3=(fp-52)	r3<=guarda o file meta.dat no mdb
	cmp	r3, #0				--r3==NULL	r3<=verifica se o arquivo 
	bne	.L2				--if not equal jump to L2
	ldr	r0, .L28+12			--r0= .LC3
	bl	puts				--imprime r0
.L2:
	mov	r3, #0				--r3=0
	str	r3, [fp, #-68]			--(fp-68)=r3	int a
	mov	r3, #0				--r3=0
	str	r3, [fp, #-64]			--(fp-64)=r3	int b
	mov	r3, #0				--r3=0
	str	r3, [fp, #-36]			--(fp-36)=r3	mttype *mt=NULL
	mov	r0, #52				--r0=52		tamanho de mttype
	bl	malloc				--alocação de memoria
	mov	r3, r0				--r3=r0
	str	r3, [fp, #-36]			--(fp-36)=r3	resultado do malloc movido r3<=r0 e guardado em (fp-36)
	mov	r3, #0				--r3=0
	str	r3, [fp, #-32]			--(fp-32)=r3	char *out=NULL
	mov	r0, #16				--r0=16		tamanho para malloc de (*char) * 4
	bl	malloc				--branch-link alocação de memoria
	mov	r3, r0				--r3=r0
	str	r3, [fp, #-32]			--(fp-32)=r3	armazena resultado do malloc no r3 e da um store para (fp-32)
	sub	r3, fp, #68			--r3=fp-68	armazena endereço do int a
	mov	r0, r3				--r0=r3		int a para r0
	mov	r1, #4				--r1=4		4 ou tamanho de int para r1
	mov	r2, #1				--r2=1		quantas vezes o tamanho sera lido para r2
	ldr	r3, [fp, #-52]			--r3=(fp-52)	carrega *mdb no r3
	bl	fread				--Função de leitura de arquivo r0 endereço a guardar, r1 tamanho do dado, r2 numero de vezes do tamanho ser carregado e r3 FILE *mdb
	ldr	r3, [fp, #-68]			--r3=(fp-68) carrega int a r3
	ldr	r0, .L28+16			--r0= .LC4	carrega numero de campos
	mov	r1, r3				--r1=r3		int a vai para r1
	bl	printf				--função printf imprimir numero de campos do meta.dat
	ldr	r2, [fp, #-68]			--r2=(fp-68)	r2= int a
	ldr	r3, [fp, #-36]			--r3=(fp-36) 	r3=mttype *mt ja alocado
	str	r2, [r3, #0]			--(r3+0)=r2	int a guardado no primeiro espaço do mttype *mt
	mov	r3, #0				--r3=0		r3=0
	str	r3, [fp, #-60]			--(fp-60)=r3	int i=0
	mov	r3, #0				--r3=0
	str	r3, [fp, #-56]			--(fp-56)=r3	int c
	mov	r3, #0				--r3=0
	str	r3, [fp, #-60]			--(fp-60)=r3	novamente i=0
	b	.L3				--jump to .L3	inicio do for
.L10:
	ldr	r3, [fp, #-60]			--r3=(fp-60)	int a =>r3
	mov	r3, r3, asl #2			--r3=r3 shift left 2x
	ldr	r2, [fp, #-32]			--r2=(fp-32)
	add	r4, r2, r3			--r4=r2+r3
	mov	r0, #8				--r0=8
	bl	malloc				--alocação de memoria
	mov	r3, r0				--r3=r0
	str	r3, [r4, #0]			--(r4+0)=r3
	ldr	r3, [fp, #-60]			--r3=(fp-60)
	cmp	r3, #3				--r3==3
	ldrls	pc, [pc, r3, asl #2]
	b	.L4				--jump to .L4
.L9:						--for/while
	.word	.L5				--switch (i): tamanho de bits para leitura: case 0
	.word	.L6				--case 1
	.word	.L7				--case 2
	.word	.L8				--case 3
.L5:
	mov	r3, #5				--r3=5    (0)=5
	str	r3, [fp, #-56]			--(fp-56)=r3
	b	.L4				--branch to .L4
.L6:
	mov	r3, #6				--r3=6		(1)=6
	str	r3, [fp, #-56]			--(fp-56)=r3
	b	.L4				--branch to .L4
.L7:
	mov	r3, #4				--r3=4		(2)=4
	str	r3, [fp, #-56]			--(fp-56)=r3
	b	.L4				--branch to .L4
.L8:
	mov	r3, #6				--r3=6		(3)=6
	str	r3, [fp, #-56]			--(fp-56)=r3
	mov	r0, r0	@ nop			--r0=r0 not operation
.L4:
	ldr	r3, [fp, #-60]			--r3=(fp-60)
	mov	r3, r3, asl #2			--r3=r3 shift left 2x
	ldr	r2, [fp, #-32]			--r2=(fp-32)
	add	r3, r2, r3			--r3=r2+r3
	ldr	r2, [r3, #0]			--r2=(r3+0)
	ldr	r3, [fp, #-56]			--r3=(fp-56)
	mov	r0, r2				--r0=r2
	mov	r1, #1				--r1=1
	mov	r2, r3				--r2=r3
	ldr	r3, [fp, #-52]			--r3=(fp-52)
	bl	fread				--ler bits do arquivo meta.dat
	ldr	r3, [fp, #-60]			--r3=(fp-60)
	mov	r3, r3, asl #2			--r3=r3 shift left 2x
	ldr	r2, [fp, #-32]			--r2=(fp-32)
	add	r3, r2, r3			--r3=r2+r3
	ldr	r1, [r3, #0]			--r1=(r3+0)
	ldr	ip, [fp, #-36]			--ip=(fp-36)
	ldr	r2, [fp, #-60]			--r2=(fp-60)
	mov	r0, #4				--r0=4
	mov	r3, r2				--r3=r2
	mov	r3, r3, asl #1			--r3=r3 shift left 1x
	add	r3, r3, r2			--r3=r3+r2
	mov	r3, r3, asl #2			--r3=r3 shift left 2x
	add	r3, ip, r3			--r3=ip+r3
	add	r3, r3, r0			--r3=r3+r0
	str	r1, [r3, #0]			--(r3+0)=r1
	ldr	r0, [fp, #-36]			--r0=(fp-36)
	ldr	r2, [fp, #-60]			--r2=(fp-60)
	mov	r1, #4				--r1=4
	mov	r3, r2				--r3=r2
	mov	r3, r3, asl #1		--r3=r3 shift left 1x
	add	r3, r3, r2			--r3=r3+r2
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	add	r3, r0, r3			--r3=r0+r3
	add	r3, r3, r1			--r3=r3+r1
	ldr	r3, [r3, #0]			--r3=(r3+0)
	ldr	r0, .L28+20			--r0= .LC5
	mov	r1, r3				--r1=r3
	bl	printf				--imprimir dados do meta.dat
	ldr	r3, [fp, #-60]			--r3=(fp-60)
	mov	r3, r3, asl #2			--r3=r3 shift left 2x
	ldr	r2, [fp, #-32]			--r2=(fp-32)
	add	r3, r2, r3			--r3=r2+r3
	ldr	r2, [r3, #0]			--r2=(r3+0)
	ldr	r3, [fp, #-56]			--r3=(fp-56)
	add	r3, r2, r3			--r3=r2+r3
	mov	r0, r3				--r0=r3
	mov	r1, #1				--r1=1
	mov	r2, #1				--r2=1
	ldr	r3, [fp, #-52]			--r3=(fp-52)
	bl	fread				--ler dados do meta.dat
	ldr	r3, [fp, #-60]			--r3=(fp-60)
	mov	r3, r3, asl #2			--r3=r3 shift left 2x
	ldr	r2, [fp, #-32]			--r2=(fp-32)
	add	r3, r2, r3			--r3=r2+r3
	ldr	r2, [r3, #0]			--r2=(r3+0)
	ldr	r3, [fp, #-56]			--r3=(fp-56)
	add	r3, r2, r3			--r3=r2+r3
	ldrb	r1, [r3, #0]	@ zero_extendqisi2
	ldr	r0, [fp, #-36]
	ldr	r2, [fp, #-60]
	mov	r3, r2				--r3=r2
	mov	r3, r3, asl #1		--r3=r3 shift left 1x
	add	r3, r3, r2			--r3=r3+r2
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	add	r3, r0, r3			--r3=r0+r3
	mov	r2, r1				--r2=r1
	strb	r2, [r3, #8]
	ldr	r2, [fp, #-60]
	mov	r3, r2				--r3=r2
	mov	r3, r3, asl #1		--r3=r3 shift left 1x
	add	r3, r3, r2			--r3=r3+r2
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-36]
	add	r3, r2, r3			--r3=r2+r3
	add	r3, r3, #8			--r3=r3+8
	ldr	r0, .L28+24
	mov	r1, r3				--r1=r3
	bl	printf
	sub	r3, fp, #64			--r3=fp-64
	mov	r0, r3				--r0=r3
	mov	r1, #4				--r1=4
	mov	r2, #1				--r2=1
	ldr	r3, [fp, #-52]
	bl	fread				--ler do arquivo meta.dat a quantidade de bits indicados no .L5 ate .L8
	ldr	r1, [fp, #-64]
	ldr	ip, [fp, #-36]
	ldr	r2, [fp, #-60]
	mov	r0, #12				--r0=12
	mov	r3, r2				--r3=r2
	mov	r3, r3, asl #1		--r3=r3 shift left 1x
	add	r3, r3, r2			--r3=r3+r2
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	add	r3, ip, r3			--r3=ip+r3
	add	r3, r3, r0			--r3=r3+r0
	str	r1, [r3, #0]
	ldr	r0, [fp, #-36]
	ldr	r2, [fp, #-60]
	mov	r1, #12				--r1=12
	mov	r3, r2				--r3=r2
	mov	r3, r3, asl #1		--r3=r3 shift left 1x
	add	r3, r3, r2			--r3=r3+r2
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	add	r3, r0, r3			--r3=r0+r3
	add	r3, r3, r1			--r3=r3+r1
	ldr	r3, [r3, #0]
	ldr	r0, .L28+28
	mov	r1, r3				--r1=r3
	bl	printf
	ldr	r3, [fp, #-60]
	add	r3, r3, #1			--r3=r3+1
	str	r3, [fp, #-60]
.L3:
	ldr	r3, [fp, #-68]			--r3=int a
	ldr	r2, [fp, #-60]			--r2=int i
	cmp	r2, r3				--if(i<a)
	blt	.L10				--se e menor pula para .L10, final do loop
	ldr	r0, [fp, #-52]			--r0=FILE *mdb
	bl	fclose				--fechar o FILE *mdb ou meta.dat
	ldr	r0, [fp, #-40]
	ldr	r1, .L28+32
	bl	fopen				--abrir o data.dat
	str	r0, [fp, #-48]			--resultado fopen para (fp-48)
	ldr	r3, [fp, #-48]			--r3=db
	cmp	r3, #0				--if(r3==NULL)
	bne	.L11				--if not equal jump to L11
	ldr	r0, .L28+36			--se e igual avisa que nao foi possivel abrir o arquivo
	bl	printf
.L11:
	mov	r3, #0				--r3=0
	str	r3, [fp, #-28]
	mov	r0, #128			--r0=128
	bl	malloc
	mov	r3, r0				--r3=r0
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	cmp	r3, #0				--r3==0
	bne	.L12				--if not equal jump to L12
	ldr	r0, .L28+40			--r0= .LC10
	bl	printf
.L12:
	mov	r3, #0				--r3=0
	str	r3, [fp, #-60]
	b	.L13
.L15:
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r4, r2, r3			--r4=r2+r3
	mov	r0, #24				--r0=24
	bl	malloc
	mov	r3, r0				--r3=r0
	str	r3, [r4, #0]
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L14
	ldr	r0, .L28+40
	bl	printf
.L14:
	ldr	r3, [fp, #-60]
	add	r3, r3, #1			--r3=r3+1
	str	r3, [fp, #-60]
.L13:
	ldr	r3, [fp, #-60]
	cmp	r3, #31
	ble	.L15
	mov	r3, #0				--r3=0
	str	r3, [fp, #-24]
	mov	r3, #0				--r3=0
	mov	r4, #0				--r4=0
	str	r3, [fp, #-20]
	str	r4, [fp, #-16]
	mov	r0, #256			--r0=256
	bl	malloc
	mov	r3, r0				--r3=r0
	str	r3, [fp, #-24]
	mov	r3, #0				--r3=0
	str	r3, [fp, #-60]
	b	.L16
.L17:						--alocando paginas do bufferpool
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-24]
	add	r4, r2, r3			--r4=r2+r3
	mov	r0, #20				--r0=20
	bl	malloc
	mov	r3, r0				--r3=r0
	str	r3, [r4, #0]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1			--r3=r3+1
	str	r3, [fp, #-60]
.L16:
	ldr	r3, [fp, #-60]
	cmp	r3, #63				--r3==63
	ble	.L17				--branch less equal  if(r3<=63) go to .L17
	ldr	r3, [fp, #-60]
	add	r3, r3, #1			--r3=r3+1
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-24]
	add	r4, r2, r3			--r4=r2+r3
	mov	r0, #30				--r0=30
	bl	malloc
	mov	r3, r0				--r3=r0
	str	r3, [r4, #0]
	mov	r3, #0				--r3=0
	str	r3, [fp, #-60]
	b	.L18
.L21:
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-24]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	mov	r0, r2
	mov	r1, #1
	mov	r2, r3
	ldr	r3, [fp, #-48]
	bl	fread
	ldr	r0, [fp, #-48]
	bl	feof
	mov	r3, r0				--r3=r0
	cmp	r3, #0
	bne	.L27
.L19:
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-60]
	mov	r2, r2, asl #2		--r2=r2 shift left 2x
	ldr	r1, [fp, #-24]
	add	r2, r1, r2			--r2=r1+r2
	ldr	r2, [r2, #0]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	ldr	r3, [r3, #0]
	mov	r0, r3				--r0=r3
	bl	puts
	ldr	r3, [fp, #-60]
	add	r3, r3, #1			--r3=r3+1
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-24]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #24]
	mov	r0, r2				--r0=r2
	mov	r1, #1				--r1=1
	mov	r2, r3				--r2=r3
	ldr	r3, [fp, #-48]
	bl	fread
	ldr	r3, [fp, #-60]
	mov	r2, r3, lsr #31		--r2=r3 shift right 31x
	add	r3, r2, r3			--r3=r2+r3
	mov	r3, r3, asr #1		--r3=r3 shift right 1x
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-60]
	mov	r2, r2, asl #2		--r2=r2 shift left 2x
	ldr	r1, [fp, #-24]
	add	r2, r1, r2			--r2=r1+r2
	ldr	r2, [r2, #0]
	str	r2, [r3, #4]
	ldr	r3, [fp, #-60]
	mov	r2, r3, lsr #31
	add	r3, r2, r3			--r3=r2+r3
	mov	r3, r3, asr #1
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	ldr	r3, [r3, #4]
	mov	r0, r3				--r0=r3		
	bl	puts
	sub	r3, fp, #20			--r3=fp-20
	mov	r0, r3				--r0=r3
	mov	r1, #8				--r1=8
	mov	r2, #1				--r2=1
	ldr	r3, [fp, #-48]
	bl	fread
	ldr	r3, [fp, #-60]
	mov	r2, r3, lsr #31		--r3=r3 shift right 31x
	add	r3, r2, r3			--r3=r2+r3
	mov	r3, r3, asr #1		--r3=r3 shift right 1x
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r2, [r3, #0]
	sub	r4, fp, #20			--r4=fp-20
	ldmia	r4, {r3-r4}
	str	r3, [r2, #8]
	str	r4, [r2, #12]
	ldr	r3, [fp, #-60]
	mov	r2, r3, lsr #31		--r2=r3 shift right 31x
	add	r3, r2, r3			--r3=r2+r3
	mov	r3, r3, asr #1		--r3=r3 shift right 1x
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	add	r4, r3, #8			--r4=r3+8
	ldmia	r4, {r3-r4}
	ldr	r0, .L28+44
	mov	r2, r3				--r2=r3
	mov	r3, r4				--r3=r4
	bl	printf
	sub	r3, fp, #64			--r3=fp-64
	mov	r0, r3				--r0=r3
	mov	r1, #4				--r1=4
	mov	r2, #1 				--r2=1
	ldr	r3, [fp, #-48]
	bl	fread				--le do arquivo uma certa quantidade 
	ldr	r3, [fp, #-60]
	mov	r2, r3, lsr #31		--r2=r3 shift right 31x
	add	r3, r2, r3			--r3=r2+r3
	mov	r3, r3, asr #1		--r3=r3 shift right 1x
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-64]
	str	r2, [r3, #16]
	ldr	r3, [fp, #-60]
	mov	r2, r3, lsr #31		--r2=r3 shift right 31x
	add	r3, r2, r3			--r3=r2+r3
	mov	r3, r3, asr #1		--r3=r3 shift right 1x
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	ldr	r3, [r3, #16]
	ldr	r0, .L28+48
	mov	r1, r3 				--r1=r3
	bl	printf
	ldr	r3, [fp, #-60]
	add	r3, r3, #1 			--r3=r3+1
	str	r3, [fp, #-60]
.L18:
	ldr	r3, [fp, #-60]
	cmp	r3, #63				--r3-63
	ble	.L21				--if less or equal jump to .L21
	b	.L20				--else jump to .L20
.L27:
	mov	r0, r0	@ nop		--r0=r0 not operation
.L20:
	ldr	r0, [fp, #-48]
	bl	fclose				--fechar o data.dat
	mov	r3, #0 				--r3=0
	str	r3, [fp, #-60]		--(fp-60)=r3
	b	.L22				--jump to .L22
.L23:						--comeca a liberar a memoria utilizada
	ldr	r3, [fp, #-60]		--r3=(fp-60)
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-28]		--r2=(fp-28)
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]		--r3=(r3+0)
	mov	r0, r3				--r0=r3
	bl	free				--funcao para liberar a memoria
	ldr	r3, [fp, #-60]		--r3=(fp-60)
	add	r3, r3, #1 			--r3=r3+1
	str	r3, [fp, #-60]		--(fp-60)=r3
.L22:
	ldr	r3, [fp, #-60]
	cmp	r3, #31
	ble	.L23
	ldr	r0, [fp, #-28]
	bl	free
	mov	r3, #0 				--r3=0
	str	r3, [fp, #-60]
	b	.L24
.L25:
	ldr	r3, [fp, #-60]
	mov	r3, r3, asl #2		--r3=r3 shift left 2x
	ldr	r2, [fp, #-32]
	add	r3, r2, r3			--r3=r2+r3
	ldr	r3, [r3, #0]
	mov	r0, r3				--r0=r3
	bl	free
	ldr	r3, [fp, #-60]
	add	r3, r3, #1 			--r3=r3+1
	str	r3, [fp, #-60]
.L24:
	ldr	r3, [fp, #-60]
	cmp	r3, #3
	ble	.L25
	ldr	r0, [fp, #-32]
	bl	free
	ldr	r0, [fp, #-36]
	bl	free
	mov	r3, #0 				--r3=0
	mov	r0, r3				--r0=r3
	sub	sp, fp, #8 			--sp=fp-8
	ldmfd	sp!, {r4, fp, pc}
.L29:
	.align	2
.L28:
	.word	.LC0	--4
	.word	.LC1	--8
	.word	.LC2	--12
	.word	.LC3	--16
	.word	.LC4	--20
	.word	.LC5	--24
	.word	.LC6	--28
	.word	.LC7	--32
	.word	.LC8	--36
	.word	.LC9	--40
	.word	.LC10	--44
	.word	.LC11	--48
	.word	.LC12	--52
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3"
	.section	.note.GNU-stack,"",%progbits
