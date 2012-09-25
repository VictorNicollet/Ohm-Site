(* Ohm is © 2012 Victor Nicollet *) 

open Ohm
open Ohm.Universal
open BatPervasives

let render = 

  let page body = Asset_Static_Page.render (object
    method body = body
    method head = ()
  end) in

  OhmStatic.wrap page |> OhmStatic.with_context (O.ctx `EN)

let () = OhmStatic.export ~render ~server:O.server ~title:"Ohm Framework" Static.site
