$PBExportHeader$w_main01.srw
$PBExportComments$Main Window
forward
global type w_main01 from w_frame
end type
type dw_2 from datawindow within w_main01
end type
type dw_1 from datawindow within w_main01
end type
type shl_board from statichyperlink within w_main01
end type
type shl_3 from statichyperlink within w_main01
end type
type shl_km from statichyperlink within w_main01
end type
type shl_2 from statichyperlink within w_main01
end type
type st_1 from statictext within w_main01
end type
type shl_1 from statichyperlink within w_main01
end type
type p_email from picture within w_main01
end type
type dw_menu from uo_menubar within w_main01
end type
type gb_1 from groupbox within w_main01
end type
type shl_online from statichyperlink within w_main01
end type
end forward

global type w_main01 from w_frame
integer x = 5
integer y = 4
integer width = 3662
integer height = 2464
string menuname = "m_0_0000"
long backcolor = 80269528
boolean toolbarvisible = false
event ue_menu_open ( )
event ue_logon ( )
event ue_board_open ( )
event ue_insert ( )
event ue_update ( )
event ue_delete ( )
event ue_first_open ( )
event ue_test_shop ( )
dw_2 dw_2
dw_1 dw_1
shl_board shl_board
shl_3 shl_3
shl_km shl_km
shl_2 shl_2
st_1 st_1
shl_1 shl_1
p_email p_email
dw_menu dw_menu
gb_1 gb_1
shl_online shl_online
end type
global w_main01 w_main01

type prototypes
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL"

end prototypes

type variables
n_cst_platformwin32 iuo_platformwin32
String              is_mail_pgm

end variables

event ue_logon();Window		lw_Sheet, lw_close[]
n_cst_logonattrib ls_logonattrib
integer     li_ret, i, li_cnt
String      ls_grp_nm, ls_pgm_id, ls_pgm_nm, ls_pgm_stat

lw_Sheet = This.GetFirstSheet()
menu			lm_curr_menu

DO WHILE IsValid(lw_Sheet)
	li_ret = MessageBox("Ȯ��", lw_Sheet.Title + &
	                            "��(��) �����Ͻðڽ��ϱ�?", Question!, YesNo!)
   IF li_ret = 1 THEN										 
	   Close(lw_Sheet)
      lw_Sheet = This.GetFirstSheet()
	ELSE
		RETURN
	END IF
LOOP

Open (w_log)
ls_logonattrib = Message.PowerObjectParm

IF (ls_logonattrib.ii_rc <> 1) THEN
   Post Close(This)
ELSE
	if gs_brand_1 <> 'X' then
		GF_INTER_NM('001', gs_brand, gs_brand_nm)
	end if


	if gs_brand_1 = "O" then 
	   This.Title = '�ø��� ������� �ý��� 2020-04-01 0001' + " [ " + gs_brand_nm + " ] " + gs_shop_nm
	elseif gs_brand_1 = "D" then 		
	   This.Title = '�̹��� ������� �ý��� 2020-04-01 0001' + " [ " + gs_brand_nm + " ] " + gs_shop_nm
	else 	
	   This.Title = '������ ������� �ý��� 2020-04-01 0001' + " [ " + gs_brand_nm + " ] " + gs_shop_nm
	end if	
	
	
	if gs_shop_cd <> "0X3300" AND gs_shop_cd <> "1X3300" AND  gs_shop_cd <> "0X3300" then
		dw_menu.of_SetTrans()
		dw_menu.of_outlookbar(1)
		//dw_menu.Retrieve("W_SHOP100")
		if gs_shop_div <> 'I' then
			dw_menu.Retrieve("W_SHOP100")
		else
			dw_2.SetTransObject(SQLCA)
			dw_2.Retrieve()
			li_cnt = dw_2.rowcount()
			for i=1 to li_cnt
				
				ls_pgm_id = dw_2.getitemstring(i,'PGM_ID')	
				ls_pgm_nm = dw_2.getitemstring(i,'PGM_NM')	
				ls_pgm_stat = dw_2.getitemstring(i,'PGM_STAT')	
							
				dw_menu.insertrow(i)
				dw_menu.setitem(i,'PGM_ID',ls_pgm_id)
				dw_menu.setitem(i,'PGM_NM',ls_pgm_nm)
				dw_menu.setitem(i,'PGM_STAT',ls_pgm_stat)			
				
			next
			
		end if
	else
		dw_menu.of_SetTrans()
		dw_menu.of_outlookbar(3)
		dw_menu.Retrieve("W_SHOP120")
	end if	
   This.PostEvent("ue_first_open")
END IF
	
end event

event ue_insert();/*===========================================================================*/
/* �ۼ���      : �������� (�� �¹�)                                          */	
/* �ۼ���      : 2001.11.27                                                  */	
/* ������      : 2001.11.27                                                  */
/*===========================================================================*/
n_cst_parms       lnv_Parm
string ls_pgm_id, ls_pgm_nm, ls_pgm_stat

SetPointer(HourGlass!)

lnv_Parm.iw_Parent   = this 
lnv_Parm.is_select   = 'I' 
lnv_Parm.is_winid    = ''
lnv_Parm.ii_OpenPos  = gi_menu_pos
lnv_Parm.is_parentid = gs_menu_id

OpenWithParm(W_MENU02, lnv_Parm)
n_cst_parms   lnv_Parm1
lnv_Parm1 = Message.PowerObjectParm

dw_menu.Retrieve(gs_menu_id)

	


SetPointer(Arrow!)

end event

event ue_update;/*===========================================================================*/
/* �ۼ���      : �������� (�� �¹�)                                          */	
/* �ۼ���      : 2001.11.27                                                  */	
/* ������      : 2001.11.27                                                  */
/*===========================================================================*/
n_cst_parms       lnv_Parm
Long              ll_row

ll_row = dw_menu.GetRow()

If ll_row < 1 Then Return

SetPointer(HourGlass!) 

lnv_Parm.iw_Parent   = this
lnv_Parm.is_select   = 'U' 
lnv_Parm.ii_OpenPos  = gi_menu_pos
lnv_Parm.is_parentid = gs_menu_id
lnv_Parm.is_winid    = dw_menu.GetitemString(ll_row, "pgm_id")
OpenWithParm(w_menu02, lnv_Parm)

n_cst_parms      lnv_Parm1
lnv_Parm1 = Message.PowerObjectParm

dw_menu.Retrieve(gs_menu_id)

SetPointer(Arrow!)

end event

event ue_delete();/*===========================================================================*/
/* �ۼ���      : �������� (�� �¹�)                                          */	
/* �ۼ���      : 2001.11.27                                                  */	
/* ������      : 2001.11.27                                                  */
/*===========================================================================*/
Long        ll_row 
String      ls_PgmID, ls_PgmNM

ll_row = dw_menu.GetRow()
If ll_row < 1 Then Return

SetPointer(HourGlass!)

ls_PgmID = dw_menu.GetitemString(ll_row, "pgm_id")
ls_PgmNM = dw_menu.GetitemString(ll_row, "pgm_nm")

IF MessageBox("�޴�����", ls_PgmNm + "�� �޴����� �����Ͻðڽ��ϱ�?",  &
						        Question!, YesNo!) = 2 THEN RETURN 

DELETE FROM tb_93030_h 
	WHERE tb_93030_h.Menu_id = :gs_menu_id
	  AND tb_93030_h.pgm_id  = :ls_PgmID;

IF SQLCA.SQLCODE <> 0 THEN
	MessageBox("����1", SQLCA.SQLErrText)
	ROLLBACK;
	RETURN
END IF

DELETE FROM tb_93020_m 
 WHERE tb_93020_m.pgm_id  = :ls_PgmID;

IF SQLCA.SQLCODE <> 0 THEN
	MessageBox("����2", SQLCA.SQLErrText)
	ROLLBACK;
	RETURN
ELSE
	COMMIT;
END IF

dw_menu.Retrieve(gs_menu_id)

SetPointer(Arrow!)

end event

event ue_first_open();/*------------------------------------------------------------*/
/* ��        ��  : �⺻ WINDOW�� Open�Ѵ�.(�Ǹ�w_sh101_e)     */
/*------------------------------------------------------------*/
Window lw_window

lw_window = This

//gf_open_sheet(lw_window, 'W_SH101_E', '�Ǹ��Ϻ����')

//MESSAGEBOX("", gs_shop_cd)

IF gs_shop_cd = '0X3300' OR gs_shop_cd = '1X3300' OR gs_shop_cd = '2X3300' OR gs_shop_cd = '3X3300' OR gs_shop_cd = '4X3300' OR gs_shop_cd = '5X3300' OR gs_shop_cd = '6X3300' OR gs_shop_cd = '7X3300' OR gs_shop_cd = '8X3300' THEN 
	gf_open_sheet(lw_window, 'W_SH130_E', '�Ǹ��Ϻ����')
	
//elseif gs_shop_cd	= "NG1187" then
//		gf_open_sheet(lw_window, 'W_SH141_E', '�Ǹ��Ϻ����') // �¾ؿ����и�����
	
elseif mid(gs_shop_cd_1,1,2)	= "NI" then
		gf_open_sheet(lw_window, 'W_SH133_E', '����Ǹ��Ϻ����') // �¾ؿ����и�����
elseif mid(gs_shop_cd_1,1,1)	= "J" then
		gf_open_sheet(lw_window, 'W_SH145_E', '���Ǹ��Ϻ����') // �¾ؿ����и�����
		
//elseif mid(gs_shop_cd_1,3,4)	= "1187" then
//		gf_open_sheet(lw_window, 'W_SH143_E', '�Ǹ��Ϻ����') // �¾ؿ����и�����		
elseIF gs_brand_1 = 'X' then
	if mid(gs_shop_cd_1,3,4) = '1890' then
		gf_open_sheet(lw_window, 'W_SH143_E', '�Ǹ��Ϻ����') // ���� 1�� ���常 ����
	else
		gf_open_sheet(lw_window, 'W_SH141_E', '�Ǹ��Ϻ����') // ������� �������� ���常 ����
	end if	
ELSE	
	gf_open_sheet(lw_window, 'W_SH101_E', '�Ǹ��Ϻ����')
END IF

//if gs_brand_1 = "O" then
// This.Title = '�ø��� ������� �ý��� 2020/04/01-0001' 
//elseif gs_brand_1 = "D" then
// This.Title = '�̹��� ������� �ý��� 2020/04/01-0001' 	
//else 
// This.Title = '������ ������� �ý��� 2020/04/01-0001' 		
//end if
//


if gs_shop_div = 'M' then
	dw_menu.enabled = true
	p_email.enabled = false
	shl_km.enabled = false
	shl_1.enabled = false
	shl_3.enabled = false
	shl_board.enabled = false
end if


end event

event ue_test_shop();String ls_Parm

OPen(w_test_shop)
ls_Parm = Message.StringParm
IF ls_Parm = 'OK' Then 
   This.Title = '������ ������� �ý���' + gs_version + " [ " + gs_brand + " ] " + gs_shop_cd
END IF

end event

on w_main01.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_0_0000" then this.MenuID = create m_0_0000
this.dw_2=create dw_2
this.dw_1=create dw_1
this.shl_board=create shl_board
this.shl_3=create shl_3
this.shl_km=create shl_km
this.shl_2=create shl_2
this.st_1=create st_1
this.shl_1=create shl_1
this.p_email=create p_email
this.dw_menu=create dw_menu
this.gb_1=create gb_1
this.shl_online=create shl_online
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.shl_board
this.Control[iCurrent+4]=this.shl_3
this.Control[iCurrent+5]=this.shl_km
this.Control[iCurrent+6]=this.shl_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.shl_1
this.Control[iCurrent+9]=this.p_email
this.Control[iCurrent+10]=this.dw_menu
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.shl_online
end on

on w_main01.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.shl_board)
destroy(this.shl_3)
destroy(this.shl_km)
destroy(this.shl_2)
destroy(this.st_1)
destroy(this.shl_1)
destroy(this.p_email)
destroy(this.dw_menu)
destroy(this.gb_1)
destroy(this.shl_online)
end on

event pfc_preopen();/*===========================================================================*/
/* �ۼ���      : (��)�������� (�� �¹�)                                      */	
/* �ۼ���      : 2002.01.21                                                  */	
/* ������      : 2002.01.21                                                  */
/*===========================================================================*/
ulong		lul_Rc, lul_size = 260 	/* MAX_PATH */
String   ls_home_dir		
integer	li_rc
boolean  lb_db_status = True
environment env
double ldb_size_X, ldb_size_Y

STRING ls_filename, LS_STRING
uint rtn, wstyle
long li_filenum


if (isNull(SQLCA.DBHandle()) or SQLCA.DBHandle() = 0) then
	if gf_connect_dbms(SQLCA) = FALSE then
		lb_db_Status = False
		This.Post Event Pfc_Close()
	end if
end if

If GetEnvironment(env) <> 1 Then return

If env.screenwidth  = 800 Then return
If env.screenheight = 600 Then return

ldb_size_X =  env.screenwidth / 800
ldb_size_Y =  env.screenheight / 600

// �������� ��ġ ����
If This.windowstate = normal! Then
   This.x = ((This.Width * ldb_size_X) - This.Width) / 2
   This.y = ((This.Height * ldb_size_Y) - This.Height) / 2
End If 

ls_home_dir = Space (lul_size)
lul_rc = GetCurrentDirectoryA (lul_size, ls_home_dir)

If lul_rc < 1 Then
	ls_home_dir = "C:\BNC_SHOP"
End If

if right(ls_home_dir, 1) = '\' then
   gs_home_dir = Left(ls_home_dir, len(ls_home_dir) - 1)
else
   gs_home_dir = ls_home_dir
end if

if lb_db_Status Then
   // MS SQL session-id�� �о�´�.
   gf_get_session(gs_sessionid)
   This.Title = '������ ������� �ý��� 2019/12/23-0001' 
   li_rc = of_SetStatusBar(true)
   This.SetMicroHelp("�۾��� �����Ͻʽÿ�! ")
   li_rc = inv_statusbar.of_Register('id_addr', 'text', gs_ip_addr, 400)
   li_rc = inv_statusbar.of_Register('Session_id', 'text', ' Sid [' + gs_sessionid +']', 300)
   li_rc = inv_statusbar.of_SetTimerFormat('yyyy/mm/dd hh:mm:ss')
   li_rc = inv_statusbar.of_SetTimerWidth(480)
   li_rc = inv_statusbar.of_SetTimer(True)
end if

dw_1.SetTransObject(SQLCA)

ls_filename = "c:\bnc_shop\rename.bat"
ls_string = 'net use \\220.118.68.4\photo otohpcnb /user:bnc_photo'  
//ls_string = 'del c\bnc_shop\test\*.* /q'  

wstyle = 0		

li_FileNum = FileOpen(ls_filename, streamMode!, Write!, Shared!, Replace!)
FileWrite(li_FileNum, ls_string)	
FileClose(li_FileNum)
rtn = WinExec(ls_filename, wstyle)		
	
ls_string = 'D' 	
li_FileNum = FileOpen(ls_filename, streamMode!, Write!, Shared!, Replace!)
FileWrite(li_FileNum, ls_string)	
FileClose(li_FileNum)


end event

event pfc_postopen;call super::pfc_postopen;This.TriggerEvent("ue_logon")


end event

event resize;call super::resize;/*===========================================================================*/
/* �ۼ���      : (��)�������� (�� �¹�)                                      */	
/* �ۼ���      : 2002.01.21                                                  */	
/* ������      : 2002.01.21                                                  */
/*===========================================================================*/

This.mdi_1.resize(newwidth  - 900, newheight - 70)
This.arrangesheets(Layer!)
dw_menu.move(newwidth  - 900, 0)
dw_menu.resize( 900, newheight - 550)
p_email.move(newwidth  - 900, newheight - 510)

st_1.move(newwidth  - 300, newheight - 410)
gb_1.move(newwidth  - 900, newheight - 550)
shl_1.move(newwidth  - 350, newheight - 200)
shl_2.move(newwidth  - 900, newheight - 200)
shl_3.move(newwidth  - 900, newheight - 200)
shl_km.move(newwidth  - 900, newheight - 130)
shl_board.move(newwidth  - 350, newheight - 130)
//shl_online.move(newwidth  - 350, newheight - 130)
end event

event open;call super::open;/*===========================================================================*/
/* �ۼ���      : (��)�������� (�����ƺ�)                                     */	
/* �ۼ���      : 2002.01.21                                                  */	
/* ������      : 2002.01.21                                                  */
/*===========================================================================*/
datetime ld_datetime
string	ls_mm

IF isvalid(iuo_platformwin32) = FALSE THEN 
	iuo_platformwin32 = create n_cst_platformwin32 
END IF

/* �ý��� ��¥�� �����´� */
IF gf_sysdate(ld_datetime) = FALSE THEN
	Return 0
END IF

ls_mm = String(ld_datetime,"MM")
//ls_mm = "01"

IF ls_mm < "04" THEN
	dw_menu.Modify("p_1.FileName='1.gif'")
	dw_menu.Modify("DataWindow.Color=764542")
ELSEIF ls_mm < "08" THEN
	dw_menu.Modify("p_1.FileName='2.gif'")
	dw_menu.Modify("DataWindow.Color=12655360")
ELSE
	dw_menu.Modify("p_1.FileName='3.gif'")
	dw_menu.Modify("DataWindow.Color=22222")
END IF


timer(3000)
//This.PostEvent("timer1(1)")
//This.Trigger Event timer1(1)
end event

event timer;/*===========================================================================*/
/* �ۼ���      : (��)�������� (�����ƺ�)                                     */	
/* �ۼ���      : 2002.01.31                                                  */	
/* ������      : 2002.05.20 (�� �¹�)                                        */
/*===========================================================================*/
datetime ld_datetime
string	ls_yymmdd, ls_url
int  li_st_cnt
long l_db_handle
boolean  lb_db_status = True
/* �ý��� ��¥�� �����´� */



//SELECT GetDate() 
//  INTO :ld_datetime
//  FROM DUAL ;
//
//IF sqlca.sqlcode <> 0  THEN
//	if gf_re_connect_dbms(SQLCA) = FALSE then
//		lb_db_Status = False		
//	end if
//END IF
//
IF gf_sysdate(ld_datetime) = FALSE THEN
//	messagebox("",ls_yymmdd)
	Return 0
END IF


ls_yymmdd = String(ld_datetime,"YYYYMMDD")

//messagebox("",ls_yymmdd)

SELECT dbo.sf_shop_mail_chk2(:gs_shop_cd, :ls_yymmdd)
  INTO :is_mail_pgm
  FROM DUAL ;
  
  
IF isnull(is_mail_pgm) OR Trim(is_mail_pgm) = "" THEN
	p_email.PictureName = 'C:\Bnc_Shop\bmp\email-off.gif'
ELSE
	if right(gs_shop_cd,4) <> "1800" then
		if gs_brand <> "J"  then
        iuo_platformwin32.of_playsound ("C:\Bnc_Shop\bmp\mail.wav")
  	   end if
	end if
	
	
	p_email.PictureName = 'C:\Bnc_Shop\bmp\email-on.gif'
	
	if is_mail_pgm = "W_SH107_D" then
		st_1.text = "R/T"
   elseif is_mail_pgm = "W_SH162_E" then
		st_1.text = "R/T"		
	elseif is_mail_pgm = "W_SH117_E" then	
		st_1.text = "�Ϻ�!"
	elseif is_mail_pgm = "W_SH163_E" then	
		st_1.text = "������R/T"
	elseif is_mail_pgm = "W_SH164_E" then	
		st_1.text = "���ÿ���"
		
		
	else
		st_1.text = "����!"		
	end if
END IF

//shl_board.text = "�Խ���(����)"
	
if mod ( Integer(String( Now(), 'ss')), 2 ) = 1 then
	shl_board.text = "�Խ���(����)"
else	
	shl_board.text = "�Խ���(New)"	
end if

//if( mod ( Integer(String( Now(), 'ss')),2 ) = 1, 15793151, rgb(255, 0, 0)), 15793151)
// �α⵵���� ��ǥ Ȯ��

//li_st_cnt = dw_1.retrieve(gs_shop_cd)
//
//if li_st_cnt > 0 then 
//	
//	integer Net
//	Net = MessageBox("Ȯ��","����ǰ �α⵵���� ����ǥ���� �����մϴ�..��ǥ�ϼ���!!")
//	
////	shl_1.visible = true
//else
////	shl_1.visible = false	
//	
//end if
end event

event close;call super::close;IF isvalid(iuo_platformwin32) THEN 
   DESTROY iuo_platformwin32
END IF
end event

type dw_2 from datawindow within w_main01
boolean visible = false
integer x = 1723
integer y = 248
integer width = 480
integer height = 840
integer taborder = 20
string title = "none"
string dataobject = "d_shop_menu_m"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_main01
boolean visible = false
integer x = 1504
integer y = 1096
integer width = 1152
integer height = 600
integer taborder = 20
string title = "none"
string dataobject = "d_vote_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type shl_board from statichyperlink within w_main01
integer x = 3049
integer y = 1616
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 80269528
string text = "�Խ���"
boolean focusrectangle = false
end type

event clicked;//string   ls_url
//
//if gs_brand_1 = 'X' then
//	//���ּ�
//	//ls_url = "http://km.ibeaucre.co.kr/board/loginchk.asp?logid="+gs_shop_cd_1+"&logpswd="+gs_shop_pwd
//
//	//���ּ�
//	ls_url = "http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid="+gs_shop_cd_1+"&upw="+gs_shop_pwd+"&cm=mg&pg=brd"
//else
//	//���ּ�
//	//ls_url = "http://km.ibeaucre.co.kr/board/loginchk.asp?logid="+gs_shop_cd+"&logpswd="+gs_shop_pwd
//	
//	//���ּ�
//	ls_url = "http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid="+gs_shop_cd+"&upw="+gs_shop_pwd+"&cm=mg&pg=brd"
//end if
//
////shl_board.url = ls_url
//


Ulong lul_handle
long  ll_cnt


String ls_Command = "open"
String ls_Dir = ""
String ls_Args ="" //"toolbar=no,status=no,scrollbars=no,resizable=no,menubar=no,width=800,height=600"
String ls_URL = "" // "https://membership.ibeaucre.co.kr:450/member/join.asp?simple=Y&shop_cd="+gs_shop_cd

if gs_brand_1 = 'X' then
	//���ּ�
	//ls_url = "http://km.ibeaucre.co.kr/board/loginchk.asp?logid="+gs_shop_cd_1+"&logpswd="+gs_shop_pwd

	//���ּ�
	ls_url = "http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid="+gs_shop_cd_1+"&upw="+gs_shop_pwd+"&cm=mg&pg=brd"
else
	//���ּ�
	//ls_url = "http://km.ibeaucre.co.kr/board/loginchk.asp?logid="+gs_shop_cd+"&logpswd="+gs_shop_pwd
	
	//���ּ�
	ls_url = "http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid="+gs_shop_cd+"&upw="+gs_shop_pwd+"&cm=mg&pg=brd"
end if

ll_cnt = ShellExecuteA( 0, ls_Command, ls_URL, ls_Args, ls_Dir, 5 )
end event

type shl_3 from statichyperlink within w_main01
integer x = 2990
integer y = 2040
integer width = 288
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 80269528
string text = "�޿�����"
alignment alignment = center!
boolean focusrectangle = false
string url = "http://company.ibeaucre.co.kr/pay/default.asp"
end type

event clicked;string   pass_wd2




//shl_3.url = ls_url


Ulong lul_handle
long  ll_cnt


String ls_Command = "open"
String ls_Dir = ""
String ls_Args ="" //"toolbar=no,status=no,scrollbars=no,resizable=no,menubar=no,width=800,height=600"
String ls_URL = "" // "https://membership.ibeaucre.co.kr:450/member/join.asp?simple=Y&shop_cd="+gs_shop_cd


if gs_brand_1 = 'X' then
	//���ּ�
	//ls_url = "company.ibeaucre.co.kr/pds/photo/loginchk.asp?logid="+gs_shop_cd_1+"&logpswd="+gs_shop_pwd
	
	//���ּ�
	ls_url = "http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid="+gs_shop_cd_1+"&upw="+gs_shop_pwd+"&cm=mg&pg=pay"
else
	//���ּ�
	//ls_url = "company.ibeaucre.co.kr/pds/photo/loginchk.asp?logid="+gs_shop_cd+"&logpswd="+gs_shop_pwd
	
	//���ּ�
	ls_url = "http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid="+gs_shop_cd+"&upw="+gs_shop_pwd+"&cm=mg&pg=pay"
end if


ll_cnt = ShellExecuteA( 0, ls_Command, ls_URL, ls_Args, ls_Dir, 5 )
end event

type shl_km from statichyperlink within w_main01
integer x = 2971
integer y = 1980
integer width = 315
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 80269528
string text = "ȫ���� KM"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;string   ls_url



if gs_brand_1 = 'X' then
	ls_url = 	"http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid=" +gs_shop_cd_1+ "&upw="  +gs_shop_pwd + "&cm=mg&pg=km"

else
	ls_url = 	"http://with.ibeaucre.co.kr/include/proc/loginProc.asp?uid=" +gs_shop_cd + "&upw="  +gs_shop_pwd + "&cm=mg&pg=km"
end if

shl_km.url = ls_url

end event

type shl_2 from statichyperlink within w_main01
boolean visible = false
integer x = 2990
integer y = 1916
integer width = 283
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 80269528
boolean enabled = false
string text = "Home Page"
alignment alignment = center!
boolean focusrectangle = false
string url = "www.ibeaucre.co.kr"
end type

event clicked;string   ls_url

ls_url = "company.ibeaucre.co.kr/pds/photo/loginchk.asp?logid="+gs_shop_cd+"&logpswd="+gs_shop_pwd
shl_1.url = ls_url

end event

type st_1 from statictext within w_main01
integer x = 3045
integer y = 1700
integer width = 288
integer height = 112
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type

type shl_1 from statichyperlink within w_main01
integer x = 3305
integer y = 1976
integer width = 315
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 80269528
string text = "�α⵵����"
boolean focusrectangle = false
end type

event clicked;string   ls_url



if gs_brand_1 = 'X' then
	ls_url = "company.ibeaucre.co.kr/pds/photo/loginchk.asp?logid="+gs_shop_cd_1+"&logpswd="+gs_shop_pwd
else
	ls_url = "company.ibeaucre.co.kr/pds/photo/loginchk.asp?logid="+gs_shop_cd+"&logpswd="+gs_shop_pwd
end if

shl_1.url = ls_url

end event

type p_email from picture within w_main01
integer x = 2688
integer y = 1608
integer width = 320
integer height = 280
boolean originalsize = true
string picturename = "C:\bnc_shop\bmp\email-off.gif"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;/*===========================================================================*/
/* �ۼ���      : (��)�������� (�����ƺ�)                                     */	
/* �ۼ���      : 2002.01.31                                                  */	
/* ������      : 2002.05.20  (�� �¹�)                                       */
/*===========================================================================*/

String ls_win_id, ls_win_nm, ls_pgm_stat
Window lw_window
Long   ll_Top 

IF isnull(is_mail_pgm) or Trim(is_mail_pgm) = "" THEN 
   ls_win_id = "W_SH303_E" 
ELSE
   ls_win_id = is_mail_pgm
END IF

SELECT pgm_nm,     pgm_stat 
  INTO :ls_win_nm, :ls_pgm_stat  
  FROM TB_93020_M 
 WHERE PGM_ID = :ls_win_id;

IF gl_user_level = 999 OR ls_pgm_stat = 'B' THEN 
	p_email.PictureName = 'email-off.gif'
	st_1.text = ""
   lw_window = Parent
   gf_open_sheet(lw_window, ls_win_id, ls_win_nm) 
END IF

end event

event constructor;/*===========================================================================*/
/* �ۼ���      : (��)�������� (�����ƺ�)                                     */	
/* �ۼ���      : 2002.01.31                                                  */	
/* ������      : 2002.01.31                                                  */
/*===========================================================================*/
addToolTipItem(handle(this), "�� �޽����� ��ȸ�մϴ�!!!")
end event

type dw_menu from uo_menubar within w_main01
integer x = 2679
integer y = 4
integer width = 901
integer height = 1584
integer taborder = 10
boolean vscrollbar = true
end type

event rbuttondown;call super::rbuttondown;/*===========================================================================*/
/* �ۼ���      : ��������(�� �¹�)														  */	
/* �ۼ���      : 2001.11.27																  */	
/* Description : ������ ���콺 Popup Menu                                    */
/*===========================================================================*/
string	ls_parentid, ls_WinID

window		lw_parent
m_3_0000    lm_view

if not IsValid (lm_view) then
	lm_view = create m_3_0000
end if

/* ����� 999�� �޴� ���, ����, ������ ������ */
if gl_user_level <> 999 then return 1

lw_parent = Parent

lm_view.m_viewitem.PopMenu (lw_parent.PointerX(), lw_parent.PointerY())

If IsValid(lm_View) Then Destroy lm_View

return 1


end event

type gb_1 from groupbox within w_main01
integer x = 2674
integer y = 1572
integer width = 901
integer height = 336
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711935
long backcolor = 80269528
end type

type shl_online from statichyperlink within w_main01
boolean visible = false
integer x = 3296
integer y = 1976
integer width = 315
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 80269528
string text = "�¶���ǰ��"
boolean focusrectangle = false
end type

event clicked;string   ls_url

ls_url = "online.ibeaucre.co.kr/" //pds/photo/loginchk.asp?logid="+gs_shop_cd+"&logpswd="+gs_shop_pwd
shl_online.url = ls_url

end event

