$PBExportHeader$n_trp.sru
$PBExportComments$Extension Transport class
forward
global type n_trp from pfc_n_trp
end type
end forward

global type n_trp from pfc_n_trp
end type
global n_trp n_trp

on n_trp.create
call transport::create
TriggerEvent( this, "constructor" )
end on

on n_trp.destroy
call transport::destroy
TriggerEvent( this, "destructor" )
end on

