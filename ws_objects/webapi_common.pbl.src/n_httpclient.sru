$PBExportHeader$n_httpclient.sru
forward
global type n_httpclient from httpclient
end type
end forward

global type n_httpclient from httpclient
end type
global n_httpclient n_httpclient

type variables
n_log   inv_log
end variables

on n_httpclient.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_httpclient.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_log = create n_log
inv_log.of_setparent( this)



end event

event destructor;destroy inv_log
end event

