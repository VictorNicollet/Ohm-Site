(* Ohm is © 2012 Victor Nicollet *) 

open Ohm
open Ohm.Universal
open BatPervasives

let render = 
  OhmStatic.wrap Asset_Static_Page.render |> OhmStatic.with_context (O.ctx `EN)

let () = OhmStatic.export ~render ~server:O.server ~title:"Ohm Framework" Static.site
