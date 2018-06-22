// BEGIN: DisplayFrag
module LowStar.Ex1

/// Programming with machine integers
// END: DisplayFrag

open FStar.Integers

(***** Machine integers *)
/// First exercise, related to machine integers. Complete the definition below
/// for the absolute value. This is, of course, tricky, since with fixed-width
/// integers, one cannot always compute the absolute value (why?). You will need
/// to craft a suitable pre-condition to make the function go through.
/// We first define the pure specification.
let abs (x: int): Tot int = if x > 0 then x else -x

/// In order to move forward, you will need the definition of the smallest
/// representable signed 32-bit integer.
let min_int32 = -0x7fffffffl - 1l

/// Then show that our function that operates on machine integers performs that
/// operation properly.
let abs1 (x: int_32): Pure int_32
  (requires True) // enhance this pre-condition
  (ensures (fun _ -> True)) // enhance this post-condition to use abs above
= admit ()

/// A second variant: this one will take True as a precondition, but will return
/// an option type for those inputs whose absolute value cannot be computed.
let abs2 (x: int_32): Pure (option int_32)
  (requires True) // must leave True here
  (ensures (fun _ -> True))
=
  admit ()

/// Summing three numbers
let sum3 (x y z:int_32) : Pure int_32
  (requires False) //weaken the precondition to something more reasonable
  (ensures  (fun res -> v res = v x + v y + v z))
= admit()
