$PBExportHeader$n_jsongenerator.sru
forward
global type n_jsongenerator from jsongenerator
end type
end forward

global type n_jsongenerator from jsongenerator
end type
global n_jsongenerator n_jsongenerator

type variables
n_log   inv_log
end variables

forward prototypes
public function integer of_test (integer ai_flag)
public function long of_additemarray (long al_parenthandle, string as_key)
public function long of_additemboolean (long al_parenthandle, string as_key, boolean ab_value)
public function long of_additemnull (long al_parenthandle, string as_key)
public function long of_additemnumber (long al_parenthandle, string as_key, double ld_value)
public function long of_additemobject (long al_parenthandle, string as_key)
public function long of_additemstring (long al_parenthandle, string as_key, string as_value)
end prototypes

public function integer of_test (integer ai_flag);integer li_re


return li_re
end function

public function long of_additemarray (long al_parenthandle, string as_key);long ll_handle

if as_key = "" then
	ll_handle = AddItemArray(al_parenthandle)
else
	ll_handle = AddItemArray(al_parenthandle,as_key)
end if

return ll_handle
end function

public function long of_additemboolean (long al_parenthandle, string as_key, boolean ab_value);long ll_handle

if as_key = "" then
	ll_handle = additemboolean(al_parenthandle,ab_value)
else
	ll_handle = additemboolean(al_parenthandle, as_key,ab_value)
end if

return ll_handle
end function

public function long of_additemnull (long al_parenthandle, string as_key);long ll_handle

if as_key = "" then
	ll_handle = additemnull(al_parenthandle)
else
	ll_handle = additemnull(al_parenthandle, as_key)
end if
 
return ll_handle
end function

public function long of_additemnumber (long al_parenthandle, string as_key, double ld_value);long ll_handle

if as_key = "" then
	ll_handle = additemnumber(al_parenthandle,ld_value)
else
	ll_handle = additemnumber(al_parenthandle,as_key,ld_value)
end if

 return ll_handle
end function

public function long of_additemobject (long al_parenthandle, string as_key);long ll_handle

if as_key = "" then
	ll_handle = AddItemObject(al_parenthandle)
else
	ll_handle = AddItemObject(al_parenthandle,as_key)
end if

return ll_handle
end function

public function long of_additemstring (long al_parenthandle, string as_key, string as_value);long ll_handle

if as_key = "" then
	ll_handle = additemstring(al_parenthandle,as_value)
else
	ll_handle = additemstring(al_parenthandle, as_key,as_value)
end if

return ll_handle
end function

on n_jsongenerator.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_jsongenerator.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_log = create n_log
inv_log.of_setparent( this)
end event

event destructor;destroy inv_log
end event

