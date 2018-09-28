$PBExportHeader$n_restclient.sru
forward
global type n_restclient from restclient
end type
end forward

global type n_restclient from restclient
end type
global n_restclient n_restclient

type variables
n_log   inv_log
end variables

on n_restclient.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_restclient.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_log = create n_log
inv_log.of_setparent( this)
end event

event destructor;destroy inv_log
end event

