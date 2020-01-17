/*
    Branching 

    Percabangan dan perubahan alur kontrol program.

Assembling:
    $ ilasm branching.il 

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'branching' { }
.module 'program.exe'


/*
    Branching 
    Branching (percabangan) adalah perpindahan alur eksekusi (execution flow) ke 
    alamat lain ditandai dengan label.
    Terdapat dua tipe branching: unconditional dan conditional.

    Unconditional branch adalah percabangan dimana eksekusi akan dipaksa untuk
    berpindah ke alamat tertentu, apapun state atau kondisi dari eksekusi saat ini.

    Conditional branch adalah percabangan dimana perpindahan hanya terjadi apabila
    kondisi tertentu terpenuhi. Kondisi ini secara spesifik melihat nilai dari dua
    item tertinggi yang ada di Stack.
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

        // -- Unconditionl Branch --
        // BR (Branch)
            // lakukan percabangan 
            br          branch_target

        // -- Conditional Branch --
        // BEQ (Branch if equal)
            // lakukan percabangan bila kedua nilai sama
            ldc.i4      4
            ldc.i4      3
            beq         branch_target       // 4 == 3 ?

        // BNE (Branch if not equal)
            // lakukan percabangan bila kedua nilai tak sama
            ldc.i4      4
            ldc.i4      3
            bne.un      branch_target       // 4 != 3 ?
        
        // BGE (Branch if greater or equal)
            // lakukan percabangan bila kedua operan bernilai sama atau
            // operan pertama lebih besar daripada operan kedua
            ldc.i4      4
            ldc.i4      3
            bge         branch_target       // 4 >= 3 ?

            // memeriksa kedua bilangan yang unsigned
            ldc.i4      4
            ldc.i4      3
            bge.un      branch_target       // 4 >= 3 ?

        // BLE (Branch if less or equal)
            // lakukan percabangan bila kedua operan bernilai sama atau
            // operan pertama lebih kecil daripada operan kedua
            ldc.i4      4
            ldc.i4      3
            ble         branch_target       // 4 <= 3 ?

            // memeriksa kedua bilangan yang unsigned
            ldc.i4      4
            ldc.i4      3
            ble.un      branch_target       // 4 <= 3 ?
        
        // BGT (Branch if greater)
            // lakukan percabangan bila operan pertama lebih besar daripada operan kedua
            ldc.i4      4
            ldc.i4      3
            bgt         branch_target       // 4 > 3 ?

            // memeriksa kedua bilangan yang unsigned
            ldc.i4      4
            ldc.i4      3
            bgt.un      branch_target       // 4 > 3 ?
        
        // BLT (Branch if less)
            // lakukan percabangan bila operan pertama lebih kecil daripada operan kedua
            ldc.i4      4
            ldc.i4      3
            blt         branch_target       // 4 < 3 ?

            // memeriksa kedua bilangan yang unsigned
            ldc.i4      4
            ldc.i4      3
            blt.un      branch_target       // 4 < 3 ?


        // BRTRUE (Branch if True)
            // lakukan percabangan bila operan bernilai tak nol
            ldc.i4      1
            brtrue      branch_target 

        // BRFALSE (Branch if False)
            // lakukan percabangan bila operan bernilai nol
            ldc.i4      0
            brfalse     branch_target 

        // BRZERO (Branch if zero)
            // lakukan percabangan bila operan bernilai nol
            ldc.i4      0
            brzero      branch_target
        

        // BRINST (Branch if Instance)
            // lakukan percabangan jika operan tidak Null atau menunjuk ke reference
            // yang valid
            newobj      instance void class RevID.Program::'.ctor' ()
            brinst      branch_target
        
        // BRNULL (Branch if Null)
            // lakukan percabangan jika operan bernilai Null
            ldnull 
            brnull      branch_target
        
            
        branch_target:
            ret 
        }
    }
}