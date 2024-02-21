
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
    
    A1([INICIO]) --> B1[/Recibo lista/]
    B1 --> C1[Recorro lista]
    C1 --> D1{Es el ultimo nodo nil?}
    -.->|Si|E1([FIN])
    D1-.->|No|E2((Envio DNI))
    E2 --> A
    E2 --> A2
    subgraph Punto A
    A([INICIO]) --> B[/Recibo DNI/]
    B --> C[Lo descompongo] 
    C --> D{Mas pares que impares?}
    D -.->|no|B
    D -.->|si|F[Sumo contador+1]
    F --> G[\Informo contador/]
    G --> H([FIN])
    H --> E1
    end
    subgraph Punto C
    A2([INICIO]) --> B2[/Recibo DNI a buscar/]
    A2 --> C3[/Recibo DNI del nodo/]
    B2 & C3 --> D3{Son el mismo?}
    D3 -.->|Si|E3[Borro el dni de la lista]
    E3 ---> E1
    D3 -.->|No|C3
    end
    subgraph Punto B
    J1([INICIO]) --> J2[Recibo Vector de genero de actuacion]
    J2 ---> J3[Recorro el vector]
    J3 ---> J4{VectorPos > max?}
    J4 -.->|Si| J5[Remplazo max por VectorPos]
    J4-.->|No| J6{VectorPos > max2}
    J6-.->|Si| J7[Remplazo max2 por VectorPos]
    J6 -->|No| J8[\Informo los dos maximos/]
    J5 --> J3
    J7 --> J3
    J8 --> J9([FIN])
    end
```