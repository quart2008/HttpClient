$PBExportHeader$u_derek_md5.sru
$PBExportComments$derekר�ú���
forward
global type u_derek_md5 from nonvisualobject
end type
type md5_ctx from structure within u_derek_md5
end type
end forward

type md5_ctx from structure
	byte		a[8]
	byte		b[16]
	byte		c[64]
	byte		d[16]
end type

shared variables

end variables
global type u_derek_md5 from nonvisualobject
end type
global u_derek_md5 u_derek_md5

type prototypes

FUNCTION long OpenProcess(long dwDesiredAccess,long bInheritHandle,long dwProcessId) LIBRARY "kernel32.dll" ALIAS FOR "OpenProcess;ansi"
Function boolean CloseHandle (long hObject )  Library "kernel32" Alias for "CloseHandle;ansi" 

FUNCTION ulong CreateFile(ref string lpFileName,ulong dwDesiredAccess,ulong dwShareMode,ref ulong lpSecurityAttributes[3],ulong dwCreationDisposition,ulong dwFlagsAndAttributes,ulong hTemplateFile) LIBRARY "kernel32.dll" ALIAS FOR "CreateFileA;ansi" 
Function ulong CreateFileMapping (ulong hFile ,ulong lpFileMappigAttributes[3], ulong flProtect , ulong dwMaximumSizeHigh , ulong dwMaximumSizeLow ,ref String lpName ) Library "kernel32" Alias for "CreateFileMappingA;ansi" 
Function ulong OpenFileMapping(ulong dwDesiredAccess , boolean bInheritHandle ,ref string lpName)  Library "kernel32" Alias for "OpenFileMappingA;ansi" 
Function ulong  MapViewOfFile  (ulong hFileMappingObject , ulong dwDesiredAccess , ulong dwFileOffsetHigh , ulong dwFileOffsetLow , ulong dwNumberOfBytesToMap ) Library "kernel32"Alias for "MapViewOfFile" 
SUBROUTINE UnmapViewOfFile (ulong lpBaseAddress ) Library "kernel32" alias for "UnmapViewOfFile;ansi"

SUBROUTINE MD5Init  (ref md5_ctx lpContext ) Library "cryptdll.dll" alias for "MD5Init;ansi"
SUBROUTINE MD5Final (ref md5_ctx lpContext ) Library "cryptdll.dll" alias for "MD5Final;ansi"
SUBROUTINE MD5Update (ref md5_ctx lpContext ,ulong lpBuffer,ulong BufSize ) Library "cryptdll.dll" alias for "MD5Update;ansi"
SUBROUTINE MD5Update (ref md5_ctx lpContext,blob lpBuffer,ulong BufSize ) Library "cryptdll.dll" alias for "MD5Update;ansi"

end prototypes

type variables


CONSTANT ulong GENERIC_READ=2147483648
CONSTANT ulong FILE_SHARE_READ=1
CONSTANT ulong OPEN_EXISTING=3
CONSTANT ulong FILE_ATTRIBUTE_NORMAL=128
CONSTANT ulong PAGE_READONLY=2
CONSTANT ulong FILE_MAP_READ=4




end variables

forward prototypes
public function string uf_md5file (ref string ls_filename, ref string ls_result)
public function string uf_md5string (ref blob ls_string, ref string ls_result)
public function string decto (decimal ad_dec, readonly unsignedinteger aui_sys)
public function integer hexencode (ref byte lb_array[], ref character lc_result[])
public function string uf_md5string (ref string ls_string, ref string ls_result)
end prototypes

public function string uf_md5file (ref string ls_filename, ref string ls_result);ulong l_size
ulong l_hfile,l_hmap,l_pAddr
long l_ret
ulong l_Secu[3]
md5_ctx lpContext
char lc_result[]
byte lbyte_result[]
string ls_ref,ls_errtext
boolean lb_ret

ls_result=''
ls_filename=string(ls_filename,'')

if DirectoryExists ( ls_filename )=true then 
	ls_errtext='�������ļ���!' //+string(ls_filename)+'~r~n'
	goto e
end if 

if fileexists(ls_filename)=false then 
	ls_errtext='�ļ�������!' //+string(ls_filename)+'~r~n'
	goto e
end if 

l_size=FileLength ( ls_filename )
if l_size=-1 then 
	ls_errtext='FileLength:'+string(l_size)+'~r~n'
	goto e
end if

if l_size=0 then 
	ls_errtext='�ļ����ݲ���Ϊ��:'+string(l_size)+'~r~n'
	goto e
end if

if l_size>2*645*1024*1024 then  //���֧��
	ls_errtext='���֧��:'+string(2*645*1024*1024,'###,###,##0')+'~r~n'
	goto e
end if

try
	
	l_hfile=CreateFile(ls_filename,GENERIC_READ,FILE_SHARE_READ,l_Secu[],OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0)
	if l_hfile<=0 then 
		ls_errtext='CreateFile:'+string(l_hfile)+'~r~n'
		THROW create runtimeerror
	end if
	
	l_hmap= CreateFileMapping(l_hfile, l_Secu, PAGE_READONLY, 0, 0, ls_ref)
	if l_hmap<=0 then 
		ls_errtext='CreateFileMapping:'+string(l_hmap)+'~r~n'
		THROW create runtimeerror
	end if
	
	l_pAddr=MapViewOfFile(l_hmap, FILE_MAP_READ,0,0,l_size);
	if l_pAddr<=0 then 
		ls_errtext='MapViewOfFile:'+string(l_pAddr)+'~r~n'
		THROW create runtimeerror
	end if
	
	MD5Init(lpContext)
	MD5Update(lpContext,l_pAddr,l_size)
	MD5Final(lpContext)
	
catch(runtimeerror e)
	ls_errtext+=e.getmessage()
finally
	
	if l_pAddr>0 then 
		UnmapViewOfFile(l_pAddr); 
		l_pAddr=0
	end if
	
	if l_hmap>0 then 
		lb_ret=CloseHandle(l_hmap)
		if lb_ret=false then 
			ls_errtext+='CloseHandle:'+string(lb_ret)+'~r~n'
			//goto e
		else
			l_hmap=0
		end if
	end if
	
	if l_hfile>0 then 
		lb_ret=CloseHandle(l_hfile)
		if lb_ret=false then 
			ls_errtext+='CloseHandle:'+string(lb_ret)+'~r~n'
			//goto e
		else
			l_hfile=0
		end if
	end if
	
end try

if ls_errtext<>'' then goto e

lbyte_result[]=lpContext.b[]
hexencode(lbyte_result[],lc_result[])
ls_result=lc_result[]

return ''

goto e
e:
return ls_errtext
end function

public function string uf_md5string (ref blob ls_string, ref string ls_result);ulong l_size
md5_ctx lpContext
char lc_result[]
byte lbyte_result[]
ls_result=''
l_size=len(ls_string)

MD5Init(lpContext)
MD5Update(lpContext,ls_string,l_size)
MD5Final(lpContext)

lbyte_result[]=lpContext.b[]
hexencode(lbyte_result[],lc_result[])
ls_result=lc_result[]

return ''
end function

public function string decto (decimal ad_dec, readonly unsignedinteger aui_sys);//����:��ʮ��������ת�����������ַ���
//����1:ʮ��������
//����2:Ŀ�����
string ls_ret	//���صĽ��
string ls_dec
string ls_left,ls_right,ls_mod
uint ld_mod	/*����Ϊ����*/
dec ld_mul	//ȡС���ĳ˻�Ϊdec
int i,li_pos,li_len,li_pointpos,li_maxpower,li_minpower
if isnull(ad_dec) or isnull(aui_sys) or aui_sys<2 then goto e

ls_dec=string(ad_dec)
li_pointpos=pos(ls_dec,'.')

if li_pointpos=0 then 

	if ad_dec<aui_sys then	//����10����
		if ad_dec<=9 then
			ls_ret=string(ad_dec)
			goto e
		elseif ad_dec>9 and ad_dec<aui_sys then
			ls_ret=char(64 - 9 + ad_dec)		//����9������Ϊת��Ϊ��ĸ
			goto e
		end if
	else
		do
			ld_mod=mod(ad_dec,aui_sys)	//ȡ����
			ls_mod=decto(ld_mod,aui_sys)
			ls_ret=ls_mod+ls_ret

			ad_dec=long(( ad_dec - ld_mod) / aui_sys )		//ȥ��ȡ��
			
		loop until ad_dec<aui_sys
		
		if ad_dec>9 then 
			ls_ret=char(64 - 9 + ad_dec)+ls_ret
		else
			ls_ret=string(ad_dec)+ls_ret
		end if
		
	end if
else
	ls_left=mid(ls_dec,1,li_pointpos)			//ȡ����
	ls_right=mid(ls_dec,li_pointpos)			//ȡС��
	ls_ret=decto(dec(ls_left),aui_sys)+'.'		//��������ת��

	ld_mul=dec(ls_right)
	for i=1 to 10 	//��󾫶�Ϊ10
		ld_mul=ld_mul * aui_sys
		ls_ret=ls_ret+string(int(ld_mul))	//ȡ��
		if ld_mul=int(ld_mul) then exit		//û������
		ld_mul=ld_mul - int(ld_mul)		//ȥ������
	next

end if

e:
return ls_ret

end function

public function integer hexencode (ref byte lb_array[], ref character lc_result[]);//���ַ�ת����16���Ʊ���
//����1:��Ҫת�����ַ�
//����2:Դ�ַ��б���
//����16���Ʊ���
long l_len,i,l_num
char lc_temp[2]

l_len=upperbound(lb_array[])
 
for i=1 to l_len
	l_num= (2 * i) - 1
	if lb_array[i]<16 then //С��16��Ҫ��0
		lc_temp[1]='0'
		lc_temp[2]=decto(lb_array[i],16)
	else
		lc_temp[]=decto(lb_array[i],16)
	end if
	lc_result[l_num]=lc_temp[1]
	lc_result[l_num + 1]=lc_temp[2]
next
 
return l_len*2


//blob lb_text
//blob{100} lb_stext
//string ls_text2,ls_ret,ls_str1
//int i,li_len,li_asc
//string ls_hex
////ls_text2=space(100)
//
////ת���ɱ���encodingutf16BE
//if len(as_text)<=50 then
//	lb_stext=blob(as_text,ae_encode)
//	ls_text2=string(lb_stext,encodingutf16Be!)
//else
//	lb_text=blob(as_text,ae_encode)
//	ls_text2=string(lb_text,encodingutf16Be!)
//end if
//
//li_len=len(ls_text2)
//
//for i=1 to li_len
//	ls_str1=mid(ls_text2,i,1)
//	li_asc=asc(ls_str1)
//	ls_hex=decto(li_asc,16)
//	
//	////
//	if ae_encode=encodingutf16BE! then	//��β
//		ls_hex=fill('0',4 - len(ls_hex))+ls_hex
//		ls_ret=ls_ret+ls_hex
//	elseif ae_encode=encodingutf16lE! then	//��β
//		ls_hex=fill('0',4 - len(ls_hex))+ls_hex
//		ls_ret=ls_ret+ls_hex
//	else
//		if right(ls_hex,2)='00' then	ls_hex=left(ls_hex,2)
//		ls_ret=ls_ret+ls_hex
//	end if
//next
//
//return ls_ret


end function

public function string uf_md5string (ref string ls_string, ref string ls_result);
blob lblob_string
lblob_string=blob(ls_string,encodingutf8!)
uf_md5string(lblob_string,ls_result)
return ''
end function

on u_derek_md5.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_derek_md5.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
