/*
    Bitwise 

    Operasi bitwise pada .NET CL

Assembling:
    $ ilasm bitwise.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'bitwise' { }
.module 'program.exe'


/*
    Bitwise
    Operasi bitwise adalah operasi logik yang dilakukan pada level bit secara
    individual, bit demi bit. Operasi bitwise dilakukan terhadap integer.

    Beberapa operasi bitwise:
        - AND
        - OR
        - XOR (exclusive or)
        - NOT
        - SHL (shift left)
        - SHR (shift right)
    
    Pada operasi shift, operan 2 menunjukkan pergeseran dalam bit yang memiliki
    nilai maksimum sebanyak jumlah bit dalam operan 1.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object 
    {
        .method public static 
                void Main() cil managed
        {
            .entrypoint
            .maxstack 8
            ret 
        }

        .method public instance 
                void _algorithm () cil managed 
        {
            .maxstack 8

        // AND
            ldc.i4      9
            ldc.i4      15
            and                 // 9 AND 15

        // OR
            ldc.i4      9
            ldc.i4      15
            or                  // 9 OR 15

        // XOR
            ldc.i4      9
            ldc.i4      15
            xor                 // 9 XOR 15

        // NOT
            ldc.i4      135
            not                 // NOT 135

        // SHL
            ldc.i4      9
            ldc.i4      15
            shl                 // 9 << 15

            // terkadang, operan 2 yang menunjukkan jumlah bit shift 
            //

        // SHR
            ldc.i4      9
            ldc.i4      15
            shr                 // 9 >> 15

            ldc.i4      9
            ldc.i4      15
            shr.un              // 9 >> 15

            ret 
        }
    }
}