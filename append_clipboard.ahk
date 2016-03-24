^g::
   topclip := clipboard
   clipboard =  ;clear clipboard so you can use clipwait
   send ^c
   clipwait	;erratic results without this
   clipboard := topclip "`r`n" clipboard
   return