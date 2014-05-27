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
		if(c[a].valid[a]==1){
			c[a].hit[a]++;
			c[a].lru[a]=0;
			return c[a].bl[a]
		};
		else
			return getBlocoP(i*4+a);
	};
	public: void setBloco(int i,int a,Bloco d){
	int o,*k;
		for(o=0;o<4;o++){
			if(c[a].valid[o]==0){
				c[a].bl[o]=d;
				c[a].valid[o]=1;
				c[a].ende[o]=i*4+a;
				c[a].lru[o]=0;
			};
		};
		if(c[a].valid[3]==1){
			k=new int[4];
			for(o=0;o<4;o++)
				k[o]=c[a].lru[o];
			};
			if(k[0]>k[1]){
				if(k[0]>k[2]){
					if(k[0]>k[3]){
						c[a].bl[0]=d;
						c[a].valid[0]=1;
						c[a].ende[0]=i*4+a
						c[a].lru[0]=0;
					}
					else{
						c[a].bl[3]=d;
						c[a].valid[3]=1;
						c[a].ende[3]=i*4+a;
						c[a].lru[3]=0;
					};
				}
				else if(k[2]>k[3]){
					c[a].bl[2]=d;
					c[a].valid[2]=1;
					c[a].ende[2]=i*4+a;
					c[a].lru[2]=0;
				}
				else{
					c[a].bl[3]=d;
					c[a].valid[3]=1;
					c[a].ende[3]=i*4+a;
					c[a].lru[3]=0;
				};
			}
			else if(k[1]>k[2]){
				if(k[1]>k[3]){
					c[a].bl[1]=d;
					c[a].valid[1]=1;
					c[a].ende[1]=i*4+a;
					c[a].lru=0;
				}
				else{
					c[a].bl[3]=d;
					c[a].valid[3]=1;
					c[a].ende[3]=i*4+a;
					c[a].lru[3]=0;
				}
			}
			else if(k[2]>k[3]){
				c[a].bl[2]=d;
				c[a].valid[2]=1;
				c[a].ende[2]=i*4+a;
				c[a].lru[2]=0;
			}
			else{
				c[a].bl[3]=d;
				c[a].valid[3]=1;
				c[a].ende[3]=i*4+a;
				c[a].lru[3]=0;
			};
		};
	};
	public: void update(){
		int i,o;
		for(i=0;i<4;i++)
			for(o=0;o<4;o++)
				c[i].lru[o]++;
	};
};
public: struct mPri{
	private:int count;
	private:Bloco bloc[128];
	public: Bloco getBlocoP(int a){
		count++;
		return bloc[a];
	};
};
