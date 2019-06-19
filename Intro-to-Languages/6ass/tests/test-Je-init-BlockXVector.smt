(val bxv01 unit)
(begin (set bxv01 (withN:withBlock: BlockXVector 100 (new BlockFn1))) (add: xvs bxv01) (add: ns #bxv01) unit)
(val bxv02 unit)
(begin (set bxv02 (withN:withBlock: BlockXVector 100 (new BlockFn2))) (add: xvs bxv02) (add: ns #bxv02) unit)
