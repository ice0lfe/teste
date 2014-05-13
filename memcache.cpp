namespace org{
	void acessaMemoria(unsigned long endereco,bool inst);
	struct Bloco{
		
	};
};
public: struct memcache{
	private:int count;
	private:int bs;
	private:Bloco *c[16];
	public: Bloco getBloco(int i){
		return c[i];
	};
	public: void setBloco(int i,Bloco *d){
		c[i]=d;
	};
};
