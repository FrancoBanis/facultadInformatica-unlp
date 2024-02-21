
``` mermaid
    flowchart TD
    subgraph Punto 1
    1([INICIO]) --> 2[/Recibo datos leidos/]
    2 --> 3
    3[/Agregar a lista/] --> 4{¿3555444?}
    4 -.->|No|2
    4 -.Si.-> 5[/Agregar a lista/]
    5 --> 6([FIN])
    end
    subgraph Punto A
    
    A([INICIO]) --> B[/Recibo DNI/]
    B --> C[Lo descompongo] 
    C --> D{Mas pares?}
    D -.->|no|E([FIN])
    D -.->|si|E([FIN])
    end

```