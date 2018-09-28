$PBExportHeader$n_jsonparser.sru
forward
global type n_jsonparser from jsonparser
end type
end forward

global type n_jsonparser from jsonparser
end type
global n_jsonparser n_jsonparser

type variables
n_log   inv_log
str_jsonnode   istr_nodes[]
boolean ib_refreshnodes
end variables

forward prototypes
public function integer of_todata ()
public function string of_tostring (long ll_handle)
public function n_jsongenerator of_traverseitem (long ll_handle)
public function n_jsongenerator of_traverseitem (long ll_handle, ref n_jsongenerator anv_jsongenerator, long al_parenthandle_generator)
public subroutine of_resetnodes ()
public function str_jsonnode of_getnode (longptr al_itemhandle)
public function long of_addnode (longptr al_parentitemhandle, longptr al_childindex, longptr al_itemhandle, string as_key)
public function string of_getnodekey (longptr al_itemhandle)
end prototypes

public function integer of_todata ();integer li_re, li_type
long ll_root, ll_childcount, ll_index, ll_item
string ls_itemtype
string ls_value, ls_type
ll_root = this.getrootitem( )

ll_childcount = this.getchildcount(ll_root)

ls_type = string(center!)

	choose case GetItemType(ll_root)
			case JsonStringItem!

				ls_type = "JsonStringItem!"
			case JsonNumberItem!

				ls_type = "JsonNumberItem!"
			case JsonBooleanItem!

				ls_type = "JsonBooleanItem!"
			case JsonNullItem!
				ls_type = "JsonNullItem!"
			case jsonobjectitem!
				//ls_value = this.getitemobject( /*longptr itemhandle*/, /*string key */)
				ls_type = "jsonobjectitem!"
			case jsonarrayitem!
				ls_type = "jsonarrayitem!"
	end choose



ls_itemtype = ls_type

//
//	choose case lnv_JsonParser.GetItemType(llp_item)
//		case JsonStringItem!
//			ls_value = lnv_JsonParser.GetItemString(llp_RootObject, ls_key)
//		case JsonNumberItem!
//			ls_value = string(lnv_JsonParser.GetItemNumber(llp_RootObject, ls_key))
//		case JsonBooleanItem!
//			ls_value = string(lnv_JsonParser.GetItemBoolean(llp_RootObject, ls_key))
//		case JsonNullItem!
//			ls_value = 'Null'
//	end choose
//

inv_log.of_clear( )
inv_log.of_log( "handle="+string(ll_root))
inv_log.of_log( "childcount="+string(ll_childcount),false)
inv_log.of_log( "ItemType="+ls_itemtype,false)

for ll_index = 1 to ll_childcount
	
	inv_log.of_log( "name="+ this.getchildkey(ll_root,ll_index ) )
	ll_item =  this.getchilditem( ll_root,ll_index)	
	choose case GetItemType(ll_item)
			case JsonStringItem!
				ls_value = GetItemString(ll_item)
				ls_type = "JsonStringItem!"
			case JsonNumberItem!
				ls_value = string(GetItemNumber(ll_item))
				ls_type = "JsonNumberItem!"
			case JsonBooleanItem!
				ls_value = string(GetItemBoolean(ll_item))
				ls_type = "JsonBooleanItem!"
			case JsonNullItem!
				ls_value = "null"
				ls_type = "JsonNullItem!"
			case jsonobjectitem!
				//ls_value = this.getitemobject( /*longptr itemhandle*/, /*string key */)
				ls_type = "jsonobjectitem!"
			case jsonarrayitem!
				ls_type = "jsonarrayitem!"
	end choose
	inv_log.of_log( "value= "+ ls_value,false  )
	inv_log.of_log( "type= "+ ls_type,false  )
	
next

inv_log.of_showlog( )

return li_re
end function

public function string of_tostring (long ll_handle);string ls_json
n_jsongenerator lnv_jsongenerator

lnv_jsongenerator = of_traverseitem(ll_handle)
ls_json = lnv_jsongenerator.getjsonstring( )

destroy lnv_jsongenerator

return ls_json
end function

public function n_jsongenerator of_traverseitem (long ll_handle);n_jsongenerator lnv_jsongenerator
long ll_index, ll_count, ll_childitem,ll_parenthandle
jsonitemtype ljsonit_item
str_jsonnode   lstr_note

ljsonit_item = this.getitemtype(ll_handle)
lstr_note = this.of_getnode(ll_handle)

lnv_jsongenerator = create n_jsongenerator
	

//if lstr_note.l_parentitemhandle = 0 then
	if ljsonit_item  =  jsonarrayitem! and lstr_note.l_parentitemhandle = 0  then
			ll_parenthandle = lnv_jsongenerator.createjsonarray( )
	else
			ll_parenthandle = lnv_jsongenerator.createjsonobject( )
	end if
//else
//	ll_parenthandle = lnv_jsongenerator.createjsonobject( )
//end if

if lstr_note.l_parentitemhandle > 0  and  lstr_note.s_key <> "" and (ljsonit_item  =  jsonarrayitem!  or ljsonit_item  =  jsonobjectitem!)then
		
	if ljsonit_item  =  jsonarrayitem!  then
			ll_parenthandle = lnv_jsongenerator.additemarray(ll_parenthandle,lstr_note.s_key)
	else
			ll_parenthandle = lnv_jsongenerator.additemobject(ll_parenthandle,lstr_note.s_key)
	end if
	
end if

if ib_refreshnodes = true then	
	of_resetnodes()
end if


of_traverseitem(ll_handle,lnv_jsongenerator,ll_parenthandle)



return lnv_jsongenerator
end function

public function n_jsongenerator of_traverseitem (long ll_handle, ref n_jsongenerator anv_jsongenerator, long al_parenthandle_generator);
long ll_index, ll_count, ll_childitem
jsonitemtype ljsonit_item
string ls_key
string ls_value
datetime ldt_value
boolean  lb_value
blob		lblb_value
double    ld_value
str_jsonnode lstr_node
str_jsonnode   lstr_nodes[]

ljsonit_item = this.getitemtype(ll_handle)

if ljsonit_item  =  jsonarrayitem! or  ljsonit_item = jsonobjectitem! then
	
    ll_count = this.getchildcount(ll_handle)
	for ll_index = 1 to ll_count
		ll_childitem = this.getchilditem(ll_handle, ll_index)
		ljsonit_item = this.getitemtype(ll_childitem)
		ls_key = this.getchildkey(ll_handle,ll_index)
		
		// node
		if ib_refreshnodes = true then	
			of_addnode(ll_handle,ll_index,ll_childitem,ls_key)	
		end if
		
		if ls_key<> "" then
		  ls_key +=string(ll_childitem)
		end if
	    choose case ljsonit_item					
			case jsonbooleanitem!
				 lb_value = this.getitemboolean(ll_childitem)
			      anv_jsongenerator.of_additemboolean( al_parenthandle_generator, ls_key,lb_value)
			case jsonnullitem!
			      anv_jsongenerator.of_additemnull(  al_parenthandle_generator, ls_key)
			case jsonnumberitem!
				 ld_value = this.getitemnumber(ll_childitem)
			     anv_jsongenerator.of_additemnumber( al_parenthandle_generator, ls_key,ld_value)
			case jsonstringitem!
				 ls_value = this.getitemstring( ll_childitem)
			     anv_jsongenerator.of_additemstring( al_parenthandle_generator, ls_key,ls_value)
			case else//jsonarrayitem!,jsonobjectitem!
				 long ll_newparent
				  if ljsonit_item  =  jsonarrayitem!  then					
						ll_newparent = anv_jsongenerator.of_AddItemArray(al_parenthandle_generator,ls_key)
				  else					
					     ll_newparent = anv_jsongenerator.of_AddItemObject(al_parenthandle_generator,ls_key)
				end if
				of_traverseitem(ll_childitem,anv_jsongenerator,ll_newparent)
		end choose
	
	next
else    	
   ls_key = of_getnodekey(ll_handle)	
   choose case ljsonit_item					
		case jsonbooleanitem!
		     lb_value = this.getitemboolean(ll_handle)
			anv_jsongenerator.of_additemboolean( al_parenthandle_generator, ls_key,lb_value)
		case jsonnullitem!
			anv_jsongenerator.of_additemnull(  al_parenthandle_generator, ls_key)
		case jsonnumberitem!
			 ld_value = this.getitemnumber(ll_handle)
			  anv_jsongenerator.of_additemnumber( al_parenthandle_generator, ls_key,ld_value)
		case jsonstringitem!
			 ls_value = this.getitemstring( ll_handle)
			  anv_jsongenerator.of_additemstring( al_parenthandle_generator, ls_key,ls_value)
	end choose
end if


return anv_jsongenerator
end function

public subroutine of_resetnodes ();str_jsonnode   lstr_nodes[]

istr_nodes = lstr_nodes
end subroutine

public function str_jsonnode of_getnode (longptr al_itemhandle);str_jsonnode  lstr_node
longptr   ll_index, ll_count, ll_childindex

ll_count =  upperbound(istr_nodes)

for ll_index  =1 to ll_count
 	if 	istr_nodes[ll_index].l_itemhandle = al_itemhandle then
		lstr_node = istr_nodes[ll_index]
		exit
	end if	
next

return lstr_node
end function

public function long of_addnode (longptr al_parentitemhandle, longptr al_childindex, longptr al_itemhandle, string as_key);long ll_count
str_jsonnode   lstr_node

ll_count = upperbound(istr_nodes) + 1


lstr_node.l_parentitemhandle = al_parentitemhandle
lstr_node.l_childindex = al_childindex
lstr_node.l_itemhandle = al_itemhandle
lstr_node.s_key = as_key

istr_nodes[ll_count] = lstr_node


return ll_count
end function

public function string of_getnodekey (longptr al_itemhandle);string ls_key
str_jsonnode lstr_node

lstr_node = of_getnode(al_itemhandle)
ls_key = lstr_node.s_key

return ls_key
end function

on n_jsonparser.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_jsonparser.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_log = create n_log
inv_log.of_setparent( this)
end event

event destructor;destroy inv_log
end event

