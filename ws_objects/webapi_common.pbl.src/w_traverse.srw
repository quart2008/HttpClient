$PBExportHeader$w_traverse.srw
forward
global type w_traverse from window
end type
type mle_target1 from multilineedit within w_traverse
end type
type cb_3 from commandbutton within w_traverse
end type
type sle_handle from singlelineedit within w_traverse
end type
type cb_2 from commandbutton within w_traverse
end type
type cb_1 from commandbutton within w_traverse
end type
type mle_target from multilineedit within w_traverse
end type
type mle_source from multilineedit within w_traverse
end type
end forward

global type w_traverse from window
integer width = 4919
integer height = 2392
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_target1 mle_target1
cb_3 cb_3
sle_handle sle_handle
cb_2 cb_2
cb_1 cb_1
mle_target mle_target
mle_source mle_source
end type
global w_traverse w_traverse

type variables
n_jsonparser inv_parser

end variables

on w_traverse.create
this.mle_target1=create mle_target1
this.cb_3=create cb_3
this.sle_handle=create sle_handle
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_target=create mle_target
this.mle_source=create mle_source
this.Control[]={this.mle_target1,&
this.cb_3,&
this.sle_handle,&
this.cb_2,&
this.cb_1,&
this.mle_target,&
this.mle_source}
end on

on w_traverse.destroy
destroy(this.mle_target1)
destroy(this.cb_3)
destroy(this.sle_handle)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_target)
destroy(this.mle_source)
end on

event open;inv_parser = create n_jsonparser
end event

type mle_target1 from multilineedit within w_traverse
integer x = 1984
integer width = 2862
integer height = 1060
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_traverse
integer x = 3781
integer y = 1076
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "tostring"
end type

event clicked;long ll_root
string ls_output

ll_root = long(sle_handle.text)

ls_output = inv_parser.of_tostring( ll_root)

mle_target.text = ls_output
end event

type sle_handle from singlelineedit within w_traverse
integer x = 2894
integer y = 1076
integer width = 878
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_traverse
integer x = 4448
integer y = 1076
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "tostring"
end type

event clicked;long ll_root
string ls_output

ll_root = inv_parser.getrootitem( )
inv_parser.ib_refreshnodes = true
ls_output = inv_parser.of_tostring( ll_root)
inv_parser.ib_refreshnodes = false
mle_target1.text = ls_output
end event

type cb_1 from commandbutton within w_traverse
integer x = 5
integer y = 1076
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "load"
end type

event clicked;inv_parser.loadstring( mle_source.text)
end event

type mle_target from multilineedit within w_traverse
integer x = 5
integer y = 1200
integer width = 4224
integer height = 1056
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_source from multilineedit within w_traverse
integer width = 1938
integer height = 1060
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

