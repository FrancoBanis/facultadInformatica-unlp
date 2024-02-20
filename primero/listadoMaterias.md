
``` mermaid
    flowchart TB
     subgraph "`*Primer Año*`"
        subgraph Primer Semestre
            A(CADP):::clasePrimer
            B(Organización de Computadoras):::clasePrimer
            C(Matemática 1):::clasePrimer
        end
        subgraph Segundo Semestre
            D{{Taller de programacion}}:::claseSegundo
            E{{Arquitectura de computadoras}}:::claseSegundo
            F{{Matemática 2}}:::claseSegundo
        end
    end
    %% Conectores %%
    A ----o D
    B ---o E
    C ---o F 
    

    %% Estilo %%
    linkStyle default stroke-width:0.5px,stroke:black
    classDef clasePrimer fill:#332B47,stroke:#000,stroke-width:0.5px,color:#fff
    classDef claseSegundo fill:#2B2E47,stroke:#000,stroke-width:0.5px,color:#fff
    
```
------------------------------------------------------------------  PRIMER AÑO  ------------------------------------------------------------------------------------------------
------------------------------------------------------------------PRIMER SEMESTRE-----------------------------------------------------------------------------------------------
--SI106--                                            Conceptos de Algoritmos, Datos y Programas                                                                                -
--SI104--                                                    Organización de Computadoras                                                                                      -
--SI101--                                                          Matemática 1                                                                                                -
 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------SEGUNDO SEMESTRE----------------------------------------------------------------------------------------------
--SI107--                                                      Taller de programacion                                                                                          -
--SI105--                                                    Arquitectura de computadoras                                                                                      -
--SI102--                                                          Matemática 2                                                                                                -
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------