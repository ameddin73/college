(val-rec (bool -> bool) flip (lambda ([b : bool]) (if b (flip #f) #t)))
