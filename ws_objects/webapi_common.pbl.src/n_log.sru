$PBExportHeader$n_log.sru
forward
global type n_log from nonvisualobject
end type
end forward

global type n_log from nonvisualobject
end type
global n_log n_log

type variables
string is_log
integer ii_count
string is_wrap="~r~n"

powerobject ipo_parent
end variables

forward prototypes
public subroutine of_clear ()
public function integer of_log (string as_log)
public function integer of_log (string as_log, boolean ab_addid)
public function string of_getlog ()
public function integer of_showlog ()
public subroutine of_setparent (powerobject lpo_parent)
end prototypes

public subroutine of_clear ();ii_count = 0
is_log = ""
end subroutine

public function integer of_log (string as_log);
return of_log(as_log,true)
	
	



end function

public function integer of_log (string as_log, boolean ab_addid);string ls_log


if ab_addid = true then
	ii_count ++
	ls_log = string(ii_count)+"."
end if

ls_log += "~t"+as_log

is_log += ls_log + is_wrap

return ii_count
	
	



end function

public function string of_getlog ();return is_log
end function

public function integer of_showlog ();string ls_title, ls_message

if isvalid(ipo_parent) then
	ls_title = ipo_parent.classname()
end if

ls_message = "log count:"+string(ii_count)+ is_wrap 
ls_message += is_log

Messagebox(ls_title,ls_message)

return ii_count
end function

public subroutine of_setparent (powerobject lpo_parent);ipo_parent = lpo_parent
end subroutine

on n_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

