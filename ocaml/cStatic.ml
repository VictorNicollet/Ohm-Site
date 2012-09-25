(* Ohm is © 2012 Victor Nicollet *) 

open Ohm
open Ohm.Universal
open BatPervasives

type sections = [`Download|`Tutorials|`Docs|`Other]

let render = 

  let page (section:sections) body = Asset_Static_Page.render (object
    method body = body
    method head = object
      method download  = section = `Download
      method tutorials = section = `Tutorials 
      method docs      = section = `Docs
    end
  end) in

  let render section = OhmStatic.with_context O.ctx `EN (OhmStatic.wrap (page section)) in

  OhmStatic.prefixed_render
    ~default:(render `Other)
    [ "tutorials/" , render `Tutorials ;
      "download/"  , render `Download  ;
      "docs/"      , render `Docs      ]

let () = OhmStatic.export ~render ~server:O.server ~title:"Ohm Framework" Static.site
