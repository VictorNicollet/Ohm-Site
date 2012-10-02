(* Ohm is © 2012 Victor Nicollet *) 

open Ohm
open Ohm.Universal
open BatPervasives

type sections = [`Download|`Tutorials|`Docs|`Other]

let books = OhmPaging.Book.([
  make [
    "tutorials/install.htm", "Installing Ohm" ;
    "tutorials/build.htm", "The build process" ; 
    "tutorials/run.htm", "Module Ohm.Run" ;
    "tutorials/action.htm", "Adding new pages" ;
    "tutorials/html.htm", "HTML templates" ;
    "tutorials/couch.htm", "Database storage" ;
  ] 
])

let render = 

  let page (section:sections) page =

    let body = page # body in 

    let url = OhmStatic.Exported.url (page # site) (page # req # server) in

    let list = 
      try Some (BatList.find_map (OhmPaging.Book.list ~url (page # key)) books) 
      with Not_found -> None 
    in

    let navig = 
      try Some (BatList.find_map (OhmPaging.Book.prev_next ~url (page # key)) books) 
      with Not_found -> None
    in

    Asset_Static_Page.render (object
      method body = body
      method list = list 
      method navig = navig
      method head = object
	method download  = section = `Download
	method tutorials = section = `Tutorials 
	method docs      = section = `Docs
      end
    end)

  in

  let render section = OhmStatic.with_context O.ctx `EN (OhmStatic.extend (page section)) in

  OhmStatic.prefixed_render
    ~default:(render `Other)
    [ "tutorials/" , render `Tutorials ;
      "download/"  , render `Download  ;
      "docs/"      , render `Docs      ]

let _ = OhmStatic.export ~render ~server:O.server ~title:"Ohm Framework" Static.site
