// des.c : Data Encryption Standard
// 2013.3.22 v1.2

#include "des.h"

//字节转换成二进制  
int ByteToBit(ElemType ch, ElemType bit[8]){   
    int cnt;   
    for(cnt = 0;cnt < 8; cnt++){   
        *(bit+cnt) = (ch>>cnt)&1;   
    }   
    return 0;   
}   
  
//二进制转换成字节 
int BitToByte(ElemType bit[8],ElemType *ch){   
    int cnt;   
    for(cnt = 0;cnt < 8; cnt++){   
        *ch |= *(bit + cnt)<<cnt;   
    }   
    return 0;   
}   

//将长度为8的字符串转为二进制位串   
int Char8ToBit64(ElemType ch[8],ElemType bit[64]){   
    int cnt;   
    for(cnt = 0; cnt < 8; cnt++){           
        ByteToBit(*(ch+cnt),bit+(cnt<<3));   
    }   
    return 0;   
}   
  
//将二进制位串转为长度为8的字符串    
int Bit64ToChar8(ElemType bit[64],ElemType ch[8]){   
    int cnt;   
    memset(ch,0,8);   
    for(cnt = 0; cnt < 8; cnt++){   
        BitToByte(bit+(cnt<<3),ch+cnt);   
    }   
    return 0;   
}   
 
//生成子密钥      
int DES_MakeSubKeys(ElemType key[64],ElemType subKeys[16][48]){   
    ElemType temp[56];   
    int cnt;   
    DES_PC1_Transform(key,temp);//PC1置换   
    for(cnt = 0; cnt < ROUND; cnt++){//16轮跌代，产生16个子密钥   
        DES_ROL(temp,MOVE_TIMES[cnt]);//循环左移   
        DES_PC2_Transform(temp,subKeys[cnt]);//PC2置换，产生子密钥     
    }   
    return 0;   
}   
   
//密钥置换1
int DES_PC1_Transform(ElemType key[64], ElemType tempbts[56]){   
    int cnt;       
    for(cnt = 0; cnt < 56; cnt++){   
        tempbts[cnt] = key[PC_1[cnt]];   
    }   
    return 0;   
}   

//密钥置换2     
int DES_PC2_Transform(ElemType key[56], ElemType tempbts[48]){   
    int cnt;   
    for(cnt = 0; cnt < 48; cnt++){   
        tempbts[cnt] = key[PC_2[cnt]];   
    }   
    return 0;   
}   

//循环左移     
int DES_ROL(ElemType data[56], int time){      
    ElemType temp[56];   
    //保存将要循环移动到右边的位  
    memcpy(temp,data,time);   
    memcpy(temp+time,data+28,time);   
    //前28位移动      
    memcpy(data,data+time,28-time);   
    memcpy(data+28-time,temp,time);   
    //后28位移动   
    memcpy(data+28,data+28+time,28-time);   
    memcpy(data+56-time,temp+time,time);       
  
    return 0;   
}   

//IP置换
int DES_IP_Transform(ElemType data[64]){   
    int cnt;   
    ElemType temp[64];   
    for(cnt = 0; cnt < 64; cnt++){   
        temp[cnt] = data[IP_Table[cnt]];   
    }   
    memcpy(data,temp,64);   
    return 0;   
}   

//IP逆置换    
int DES_IP_1_Transform(ElemType data[64]){   
    int cnt;   
    ElemType temp[64];   
    for(cnt = 0; cnt < 64; cnt++){   
        temp[cnt] = data[IP_1_Table[cnt]];   
    }   
    memcpy(data,temp,64);   
    return 0;   
}   
 
//扩展置换   
int DES_E_Transform(ElemType data[48]){   
    int cnt;   
    ElemType temp[48];   
    for(cnt = 0; cnt < 48; cnt++){   
        temp[cnt] = data[E_Table[cnt]];   
    }      
    memcpy(data,temp,48);   
    return 0;   
}   

//P置换   
int DES_P_Transform(ElemType data[32]){   
    int cnt;   
    ElemType temp[32];   
    for(cnt = 0; cnt < 32; cnt++){   
        temp[cnt] = data[P_Table[cnt]];   
    }      
    memcpy(data,temp,32);   
    return 0;   
}   

//异或  
int DES_XOR(ElemType R[48], ElemType L[48] ,int count){   
    int cnt;   
    for(cnt = 0; cnt < count; cnt++){   
        R[cnt] ^= L[cnt];   
    }   
    return 0;   
}   

//S盒置换     
int DES_SBOX(ElemType data[48]){   
    int cnt;   
    int line,row,output;   
    int cur1,cur2;   
    for(cnt = 0; cnt < 8; cnt++){   
        cur1 = cnt*6;   
        cur2 = cnt<<2;   
        //计算在S盒中的行与列   
        line = (data[cur1]<<1) + data[cur1+5];   
        row = (data[cur1+1]<<3) + (data[cur1+2]<<2)   
            + (data[cur1+3]<<1) + data[cur1+4];   
        output = S[cnt][line][row];   
        //化为2进制   
        data[cur2] = (output&0X08)>>3;   
        data[cur2+1] = (output&0X04)>>2;   
        data[cur2+2] = (output&0X02)>>1;   
        data[cur2+3] = output&0x01;   
    }      
    return 0;   
}   

//交换  
int DES_Swap(ElemType left[32], ElemType right[32]){   
    ElemType temp[32];   
    memcpy(temp,left,32);      
    memcpy(left,right,32);     
    memcpy(right,temp,32);   
    return 0;   
}   

//加密单个分组
int DES_EncryptBlock(ElemType plainBlock[8], ElemType subKeys[16][48], ElemType cipherBlock[8]){   
    ElemType plainBits[64];   
    ElemType copyRight[48];   
    int cnt;   
  
    Char8ToBit64(plainBlock,plainBits);        
    //初始置换（IP置换） 
    DES_IP_Transform(plainBits);   
    //16轮迭代   
    for(cnt = 0; cnt < ROUND; cnt++){          
        memcpy(copyRight,plainBits+32,32);   
        //将右半部分进行扩展置换，从32位扩展到48位   
        DES_E_Transform(copyRight);   
        //将右半部分与子密钥进行异或操作   
        DES_XOR(copyRight,subKeys[cnt],48);    
        //异或结果进入S盒，输出32位结果   
        DES_SBOX(copyRight);   
        //P置换
        DES_P_Transform(copyRight);   
        //将明文左半部分与右半部分进行异或   
        DES_XOR(plainBits,copyRight,32);   
        if(cnt != ROUND - 1){   
            //最终完成左右部的交换   
            DES_Swap(plainBits,plainBits+32);   
        }   
    }   
    //逆初始置换（IP^1置换）   
    DES_IP_1_Transform(plainBits);   
    Bit64ToChar8(plainBits,cipherBlock);   
    return 0;   
}   
  
//解密单个分组
int DES_DecryptBlock(ElemType cipherBlock[8], ElemType subKeys[16][48],ElemType plainBlock[8]){   
    ElemType cipherBits[64];   
    ElemType copyRight[48];   
    int cnt;   
  
    Char8ToBit64(cipherBlock,cipherBits);          
    //初始置换（IP置换）   
    DES_IP_Transform(cipherBits);   
       
    //16轮迭代   
    for(cnt = ROUND - 1; cnt >= 0; cnt--){         
        memcpy(copyRight,cipherBits+32,32);   
        //将右半部分进行扩展置换，从32位扩展到48位   
        DES_E_Transform(copyRight);   
        //将右半部分与子密钥进行异或操作   
        DES_XOR(copyRight,subKeys[cnt],48);        
        //异或结果进入S盒，输出32位结果  
        DES_SBOX(copyRight);   
        //P置换   
        DES_P_Transform(copyRight);        
        //将明文左半部分与右半部分进行异或   
        DES_XOR(cipherBits,copyRight,32);   
        if(cnt != 0){   
            //最终完成左右部的交换   
            DES_Swap(cipherBits,cipherBits+32);   
        }   
    }   
    //逆初始置换（IP^1置换）   
    DES_IP_1_Transform(cipherBits);   
    Bit64ToChar8(cipherBits,plainBlock);   
    return 0;   
}   

/*加密数据（字符串）
 *plainBuffer:输入数据
 *keyBuffer:密钥（8字节）
 *cipherBuffer:输出数据
 *n:加密数据长度
 */
int DES_Encrypt(ElemType *plainBuffer, ElemType *keyBuffer, ElemType *cipherBuffer, int n){
    int des_size = n;
    int des_count = 0;
    int count = 0;
    ElemType plainBlock[8],cipherBlock[8],keyBlock[8];
    ElemType bKey[64];   
    ElemType subKeys[16][48];   

    //设置密钥   
    memcpy(keyBlock,keyBuffer,8);
    //将密钥转换为二进制流   
    Char8ToBit64(keyBlock,bKey);   
    //生成子密钥   
    DES_MakeSubKeys(bKey,subKeys); 

    while (des_count + 8 <= des_size){
        memcpy(plainBlock,plainBuffer + des_count,8);
        DES_EncryptBlock(plainBlock,subKeys,cipherBlock);  
        memcpy(cipherBuffer + des_count,cipherBlock,8) ;   
        des_count += 8;
    }

    if((count = des_size - des_count)){
        memcpy(plainBlock,plainBuffer + des_count,count);
        //填充   
        memset(plainBlock + count,'\0',7 - count); 
        //最后一个字符保存包括最后一个字符在内的所填充的字符数量   
        plainBlock[7] = 8 - count;   
        DES_EncryptBlock(plainBlock,subKeys,cipherBlock);   
        memcpy(cipherBuffer + des_count,cipherBlock,8);
    }  
    return DES_OK;
}

/*解密数据（字符串）
 *cipherBuffer:输入数据
 *keyBuffer:密钥（8字节）
 *plainBuffer:输出数据
 *n:解密数据长度
 *返回解密后数据长度
 */
int DES_Decrypt(ElemType *cipherBuffer, ElemType *keyBuffer, ElemType *plainBuffer, int n){
    int des_size = n;
    int des_count = 0;
    int count = 0;
    ElemType plainBlock[8],cipherBlock[8],keyBlock[8];
    ElemType bKey[64];   
    ElemType subKeys[16][48];   

    //设置密钥   
    memcpy(keyBlock,keyBuffer,8);
    //将密钥转换为二进制流  
    Char8ToBit64(keyBlock,bKey);   
    //生成子密钥  
    DES_MakeSubKeys(bKey,subKeys); 

    while(1){   
        memcpy(cipherBlock,cipherBuffer + des_count,8); 
        DES_DecryptBlock(cipherBlock,subKeys,plainBlock);
        if(des_count + 8 < des_size){   
            memcpy(plainBuffer + des_count,plainBlock,8);
            des_count += 8;
        } else {  
            break;   
        }   
    }

    //判断末尾是否被填充
    if(plainBlock[7] < 8){
      for(count = 8 - plainBlock[7]; count < 7; count++){   
        if(plainBlock[count] != '\0'){   
          break;   
        }   
      }   
    } 
    if(count == 7){
      memcpy(plainBuffer + des_count,plainBlock,8 - plainBlock[7]);
      return des_count +8 - plainBlock[7];
    } else {
		memcpy(plainBuffer + des_count,plainBlock,8);
      return des_count +8 ;
    }
    return des_count + 8;
}
  
//加密文件  
int DES_Encrypt_File(char *plainFile, char *keyStr,char *cipherFile){   
    FILE *plain,*cipher,*key;
    ElemType *plainBlock,*cipherBlock,keyBlock[8];    
    long fileLen_in,fileLen_out;
    int count;
    if((plain = fopen(plainFile,"rb")) == NULL){   
        return PLAIN_FILE_OPEN_ERROR;   
    }      
    if((key = fopen(keyStr,"rb")) == NULL){   
        return KEY_FILE_OPEN_ERROR;   
    }     
    if((cipher = fopen(cipherFile,"wb")) == NULL){   
        return CIPHER_FILE_OPEN_ERROR;   
    }
    if((count = fread(keyBlock,sizeof(char),8,key)) == 8){
    }
  
    fseek(plain,0,SEEK_END);//将文件指针置尾      
    fileLen_out = fileLen_in = ftell(plain);//取文件指针当前位置       
    rewind(plain);//将文件指针重指向文件头
    if (fileLen_in % 8 != 0)
      fileLen_out = (fileLen_in/8+1)*8;
    plainBlock = (ElemType *)malloc(fileLen_out * sizeof(ElemType));
    cipherBlock = (ElemType *)malloc(fileLen_out * sizeof(ElemType));
    fread(plainBlock,sizeof(char),fileLen_in,plain);   

    DES_Encrypt(plainBlock,keyBlock,cipherBlock,fileLen_in); 
    fwrite(cipherBlock,sizeof(char),fileLen_out,cipher);  

    fclose(plain);   
    fclose(cipher); 
    fclose(key);
    free(plainBlock);
    free(cipherBlock);
    return DES_OK;
}
  
//解密文件
int DES_Decrypt_File(char *cipherFile, char *keyStr,char *plainFile){   
FILE *plain,*cipher,*key;
    ElemType *plainBlock,*cipherBlock,keyBlock[8];    
    int count;
    long fileLen_in,fileLen_out;
  
    if((plain = fopen(plainFile,"wb")) == NULL){   
        return PLAIN_FILE_OPEN_ERROR;   
    }      
    if((key = fopen(keyStr,"rb")) == NULL){   
        return KEY_FILE_OPEN_ERROR;   
    }     
    if((cipher = fopen(cipherFile,"rb")) == NULL){   
        return CIPHER_FILE_OPEN_ERROR;   
    }
    if((count = fread(keyBlock,sizeof(char),8,key)) == 8){
    }

    fseek(cipher,0,SEEK_END);//将文件指针置尾      
    fileLen_out = fileLen_in = ftell(cipher);//取文件指针当前位置       
    rewind(cipher);//将文件指针重指向文件头  

    plainBlock = (ElemType *)malloc(fileLen_in * sizeof(ElemType));
    cipherBlock = (ElemType *)malloc(fileLen_in * sizeof(ElemType));
    fread(cipherBlock,sizeof(char),fileLen_in,cipher);   

    count = DES_Decrypt(cipherBlock,keyBlock,plainBlock,fileLen_in);
    fwrite(plainBlock,sizeof(char),count,plain); 

    fclose(plain);   
    fclose(cipher); 
    fclose(key);
    free(plainBlock);
    free(cipherBlock);
    return DES_OK;   
}  

/*3DES加密数据（字符串）
 *对区块使用3个64位密钥进行3次加密，相当于增加了密钥长度
 *plainBuffer:输入数据
 *keyBuffer:密钥（24字节）
 *cipherBuffer:输出数据
 *n:加密数据长度
 */
int D3DES_Encrypt(ElemType *plainBuffer, ElemType *keyBuffer, ElemType *cipherBuffer, int n){
    int des_size = n;
    int des_count = 0;
    int count = 0;
	int i;
    ElemType plainBlock[8],cipherBlock[8],keyBlock[24];
    ElemType bKey[3][64]; 
    ElemType subKeys[3][16][48];

	for (i = 0; i < 3 ; i++)
	{
		//设置密钥   
		memcpy(keyBlock+i*8,keyBuffer+i*8,8);
		//将密钥转换为二进制流   
		Char8ToBit64(keyBlock+i*8,bKey[i]);   
		//生成子密钥   
		DES_MakeSubKeys(bKey[i],subKeys[i]); 
	}

    while (des_count + 8 <= des_size){
        memcpy(plainBlock,plainBuffer + des_count,8);
		for (i = 0; i < 3 ; i++)
		{
			DES_EncryptBlock(plainBlock,subKeys[i],cipherBlock);   
		}
        memcpy(cipherBuffer + des_count,cipherBlock,8) ;  
        des_count += 8;
    }

    if((count = des_size - des_count)){
        memcpy(plainBlock,plainBuffer + des_count,count);
        //填充   
        memset(plainBlock + count,'\0',7 - count); 
        //最后一个字符保存包括最后一个字符在内的所填充的字符数量   
        plainBlock[7] = 8 - count;   
		{
			for (i = 0; i < 3 ; i++)
			{
				DES_EncryptBlock(plainBlock,subKeys[i],cipherBlock);   
			} 
		}
        memcpy(cipherBuffer + des_count,cipherBlock,8);
    }  
    return DES_OK;
}

/*3DES解密数据（字符串）
 *cipherBuffer:输入数据
 *keyBuffer:密钥（24字节）
 *plainBuffer:输出数据
 *n:解密数据长度
 *返回解密后数据长度
 */
int D3DES_Decrypt(ElemType *cipherBuffer, ElemType *keyBuffer, ElemType *plainBuffer, int n){
    int des_size = n;
    int des_count = 0;
    int count = 0;
	int i;
    ElemType plainBlock[8],cipherBlock[8],keyBlock[24];
    ElemType bKey[3][64];   
    ElemType subKeys[3][16][48];   

	for (i = 0; i < 3 ; i++)
	{
		//设置密钥   
		memcpy(keyBlock+i*8,keyBuffer+i*8,8);
		//将密钥转换为二进制流   
		Char8ToBit64(keyBlock+i*8,bKey[i]);   
		//生成子密钥   
		DES_MakeSubKeys(bKey[i],subKeys[i]); 
	}

    while(1){   
        memcpy(cipherBlock,cipherBuffer + des_count,8); 
		for (i = 0; i < 3 ; i++)
		{
			DES_DecryptBlock(cipherBlock,subKeys[i],plainBlock);     
		}
        if(des_count + 8 < des_size){   
            memcpy(plainBuffer + des_count,plainBlock,8); 
            des_count += 8;
        } else {  
            break;   
        }   
    }

    //判断末尾是否被填充
    if(plainBlock[7] < 8){
      for(count = 8 - plainBlock[7]; count < 7; count++){   
        if(plainBlock[count] != '\0'){   
          break;   
        }   
      }   
    } 
    if(count == 7){
      memcpy(plainBuffer + des_count,plainBlock,8 - plainBlock[7]);
      return des_count +8 - plainBlock[7];
    } else {
      memcpy(plainBuffer + des_count,plainBlock,8);
      return des_count +8 ;
    }
    return des_count + 8;
}

//3DES加密文件
int D3DES_Encrypt_File(char *plainFile, char *keyStr,char *cipherFile){   
	FILE *plain,*cipher,*key;
	ElemType *plainBlock,*cipherBlock,keyBlock[24];    
	long fileLen_in,fileLen_out;
	int count;
	if((plain = fopen(plainFile,"rb")) == NULL){   
		return PLAIN_FILE_OPEN_ERROR;   
	}      
	if((key = fopen(keyStr,"rb")) == NULL){   
		return KEY_FILE_OPEN_ERROR;   
	}     
	if((cipher = fopen(cipherFile,"wb")) == NULL){   
		return CIPHER_FILE_OPEN_ERROR;   
	}
	if((count = fread(keyBlock,sizeof(char),24,key)) == 24){
	}

	fseek(plain,0,SEEK_END);//将文件指针置尾      
	fileLen_out = fileLen_in = ftell(plain);//取文件指针当前位置       
	rewind(plain);//将文件指针重指向文件头  

	if (fileLen_in % 8 != 0)
		fileLen_out = (fileLen_in/8+1)*8;
	plainBlock = (ElemType *)malloc(fileLen_out * sizeof(ElemType));
	cipherBlock = (ElemType *)malloc(fileLen_out * sizeof(ElemType));
	fread(plainBlock,sizeof(char),fileLen_in,plain);   

	D3DES_Encrypt(plainBlock,keyBlock,cipherBlock,fileLen_in); 
	fwrite(cipherBlock,sizeof(char),fileLen_out,cipher);  

	fclose(plain);   
	fclose(cipher); 
	fclose(key);
	free(plainBlock);
	free(cipherBlock);
	return DES_OK;
}

//3DES解密文件
int D3DES_Decrypt_File(char *cipherFile, char *keyStr,char *plainFile){   
	FILE *plain,*cipher,*key;
	ElemType *plainBlock,*cipherBlock,keyBlock[24];    
	int count;
	long fileLen_in,fileLen_out;

	if((plain = fopen(plainFile,"wb")) == NULL){   
		return PLAIN_FILE_OPEN_ERROR;   
	}      
	if((key = fopen(keyStr,"rb")) == NULL){   
		return KEY_FILE_OPEN_ERROR;   
	}     
	if((cipher = fopen(cipherFile,"rb")) == NULL){   
		return CIPHER_FILE_OPEN_ERROR;   
	}
	if((count = fread(keyBlock,sizeof(char),24,key)) == 24){
	}

	fseek(cipher,0,SEEK_END);//将文件指针置尾      
	fileLen_out = fileLen_in = ftell(cipher);//取文件指针当前位置       
	rewind(cipher);//将文件指针重指向文件头  

	plainBlock = (ElemType *)malloc(fileLen_in * sizeof(ElemType));
	cipherBlock = (ElemType *)malloc(fileLen_in * sizeof(ElemType));
	fread(cipherBlock,sizeof(char),fileLen_in,cipher);   

	count = D3DES_Decrypt(cipherBlock,keyBlock,plainBlock,fileLen_in);
	fwrite(plainBlock,sizeof(char),count,plain); 

	fclose(plain);   
	fclose(cipher); 
	fclose(key);
	free(plainBlock);
	free(cipherBlock);
	return DES_OK;   
}  

