```mermaid
 flowchart TD
 idI([INICIO]) --> idPar1[/ReciboPrecios/]    
 idI --> idPar2[/ReciboVector/]
 idPar1 & idPar2 --> proceso[AlmacenoPrecios]
 proceso --> idF([FIN])
```