(* Ohm is © 2012 Victor Nicollet *) 

open Ohm
open BatPervasives

module Controllers = struct
  open CErrorPage
  open CStatic
end

module Main = Ohm.Main.Make(O.Reset)
let _ = Main.run ~async:O.run_async O.role


