``` mermaid
 flowchart TD
 I([INICIO]) --> 
    Par[/ReciboListaCliente/]
 Par --> Proce[DescompongoDNICliente]
 Proce --> If1{Tiene dos nueves en DNI?}
     If1 -.no .-> Par
     If1 -.si.-> Informar{{Informo nombre}}
 Informar --> If2{Es el ultimo cliente ?}
     If2 -.no .-> Par
     If2 -.si.-> F([FIN])
```