$PBExportHeader$bnc_shop.sra
$PBExportComments$������ ������� �ý���
forward
global type bnc_shop from application
end type
global u_n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
/* ���� �������� */
n_cst_appmanager    gnv_app
u_changekorea       gu_auto_koram       /* �ѿ� �ڵ���ȯ */
gs_cd_search        gst_cd              /* �˻�â Structure */
gs_vari_cd          gsv_cd              /* �ڵ� Structure */

string    gs_home_dir   = "C:\BNC_SHOP"     /* HOME DIR        */
string    gs_sessionid  = "ssn-id"          /* sessionID       */
string    gs_ip_addr    = '999.999.999.999' /* IP ADDRESS      */
string    gs_menu_id    = "W_SHOP100"       /* menuID          */
integer   gi_menu_pos   = 2                 /* �޴��� â��ġ   */
string    gs_brand      = 'N'               /* �귣��          */
string    gs_brand_nm   = '�귣���'        /* �귣���        */
string    gs_brand_grp                       /* �ǸŰ��� ǰ�� �귣�� �׷�     */
string    gs_shop_cd    = 'NG0000'          /* ���� �ڵ�       */
string    gs_shop_pwd   = '000000'          /* �����й�ȣ    */
string    gs_shop_nm    = '������'          /* ���� ��Ī       */
string	 gs_shop_div	= 'G'					  /* �����			   */
Long      gl_user_level                     /* ����� ���     */
string    gs_user_grp                       /* ����� �׷�     */
string    gs_user_id                        /* ����� id       */

String	 gs_jumin		= ""					  /* ���ֹι�ȣ    */
String	 gs_card_no		= ""					  /* ��ī���ȣ    */
String	 gs_age_grp		= ""					  /* ������          */
decimal   gdc_sale_rate  = 0 
String	 gs_version		= "20200401-0001"					  /* ����          */

string	 gs_shop_cd_1								/* ���ո��� ���� �α��� �����ڵ� */
string	 gs_brand_1									/* ���ո��� ���� �α��� �귣��*/

string	 gs_shop_cd_2								/* �и��� ��� �����ڵ� */

end variables

global type bnc_shop from application
string appname = "bnc_shop"
end type
global bnc_shop bnc_shop

type prototypes
FUNCTION ulong SetCapture(UINT hWnd )      LIBRARY "user32.dll"
FUNCTION ulong GetCapture( )               LIBRARY "user32.dll"
SUBROUTINE     ReleaseCapture ()           LIBRARY "user32.dll"
FUNCTION ulong CreateMutexA (ulong lpMutexAttributes, int bInitialOwner, ref string lpName) library "kernel32.dll"
FUNCTION ulong GetLastError () library "kernel32.dll" 

//����� ������
Function long CreateEllipticRgn( long lX1, long lY1, long lX2, long lY2 ) Library "gdi32.dll" 
Function long SetWindowRgn( long lHandle, long lRgn, boolean bIsRedraw ) Library "user32.dll" 

//ǳ������
function ulong addToolTipItem(ulong hWndTool, string text) library "PBSupports.dll"
function ulong releaseToolTipItem(ulong hWndTool) library "PBSupports.dll"

// ��ǻ���̸� ��������
FUNCTION BOOLEAN GetComputerNameA(REF STRING cname,REF LONG nbuf) LIBRARY "kernel32.dll"

// �ܺ� ����ȭ�� 
FUNCTION uint WinExec(ref string filename, uint wstyle) LIBRARY "kernel32.dll"

FUNCTION long ShellExecuteA( long hWnd, REF String ls_Operation, REF String ls_File, REF String ls_Parameters, REF String  ls_Directory, INT nShowCmd ) library 'shell32'

end prototypes
on bnc_shop.create
appname="bnc_shop"
message=create message
sqlca=create u_n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on bnc_shop.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gnv_app = CREATE n_cst_appmanager
gu_auto_koram = CREATE u_changekorea

///* ���� ��� ������ ���� START */
///* Program �ߺ����� üũ (���� Program ������ �ʿ�) */
//ulong ll_mutex, ll_err
//string ls_mutex_name
//
//if handle (GetApplication (), false) <> 0 then
//   ls_mutex_name = this.AppName + char (0)
//   ll_mutex = CreateMutexA (0, 0, ls_mutex_name)
//   ll_err = GetLastError ()
//   if ll_err = 183 then    // ���α׷� ������
//      MessageBox ("���",  "������ ������� �ý��� �̹� ������ �Դϴ�.")     
//      halt close
//   end if
//end if
///* Program �ߺ����� üũ END */
//IF commandline <> "" THEN 
//   // *** MAIN FRAME Window�� Open�Ѵ�.
//   Open (w_main)
//END IF
///* ���� ��� ������ ���� END */

/* ���� ��� ������ REMARK START */
/* MAIN FRAME Window�� Open�Ѵ�. */
Open (w_main01)
/* ���� ��� ������ REMARK END */

end event

event close;DESTROY gnv_app
DESTROY gu_auto_koram
Disconnect;
end event

event systemerror;/*------------------------------------------------------------*/
/* Name          : Application; systemerror                   */
/* ��        ��  : Application Run���� RunTime Error Message  */
/*------------------------------------------------------------*/

// Open(w_0_0005)
return
end event

