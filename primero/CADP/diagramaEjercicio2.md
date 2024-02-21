
``` mermaid
    flowchart TD
    A([Inicio]) --> B[/Recibo datos leidos/]
    B --> D[Agrego los datos a una lista]
    D ---> C{¿Era 3555444?}
    C -. Si .-> D
    D ----> F([Fin])
    
    
    C-.->|No| B
    
    1([inicio]) --> 2[/Recibo datos leidos/]
    2 --> 3
    3[/Agregar a lista/] --> 4{¿3555444?}
    4 -.->|No|2
    4 -.Si.-> 5[/Agregar a lista/]
    5 --> 6([FIN])

```