namespace org{
	void acessaMemoria(unsigned long endereco,bool inst);
	struct Bloco{
		unsigned char dado[2];
	};
	struct Conj{
		Bloco bl[4];
		int lru[4];
		int valid[4];
		int ende[4];
		int hit[4];
	};
};
public: struct mCache{
	private:int count;
	private:Conj c[4];
	public: Bloco getBloco(int i,int a){
		count++;
		if(c[i].valid[a]==1)
			return c[i].bl[a];
		else
			return getBlocoP(i,a);
	};
	public: void setBloco(int i,int a,Bloco d){
		c[i].bl[a]=d;
		c[i].valid[a]=1;
		c[i].ende[a]=a*i+a;
	};
};
public: struct mPri{
	private:int count;
	private:Bloco bloc[256];
	public: Bloco getBlocoP(int i,int a){
		count++;
		return bloc[i*a+a];
	};
};
