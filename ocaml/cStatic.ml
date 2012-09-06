(* Ohm is © 2012 Victor Nicollet *) 

open Ohm
open Ohm.Universal
open BatPervasives

let render _ ?css ?js ?head ?favicon ?body_classes ~title writer =
  let! writer = ohm $ Asset_Static_Page.render writer in
  return $ O.page ?css ?js ?head ?favicon ?body_classes ~title writer

let () = OhmStatic.export ~render ~server:O.server ~title:"Ohm Framework" Static.site
