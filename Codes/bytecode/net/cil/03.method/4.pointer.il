/*
    Method Pointer

    Pemanggilan berbagai jenis method secara tak langsung 

Assembling:
    $ ilasm pointer.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'pointer' { }
.module 'program.exe'


/*
    Pemanggilan method merupakan sebuah aksi untuk memindahkan alur eksekusi sehingga
    instruksi di dalam method dapat dieksekusi.
    Pemanggilan jenis method yang berbeda akan membutuhkan instruksi dan tata cara 
    yang berbeda pula.

    Setidaknya terdapat dua jenis method:
        - instance method 
        - class method (static)
    
    Pemanggilan secara tak langsung (indirect call) terhadap method adalah pemanggilan 
    method, baik instance method maupun class method, melalui objek perantara. Alamat
    method yang akan dipanggil disimpan ke dalam sebuah variabel.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        // -- Instance Method --
        .method public instance
                void mtd_inst (int32 arg) cil managed 
        {
            .maxstack 8
            ret   
        }
        // Signature: void RevID.Program::mtd_inst (int32)

        // -- Static Method --
        .method public static
                void mtd_static (int32 arg) cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void class RevID.Program::mtd_static (int32)

        // -- Virtual Method --
        .method public virtual newslot instance 
                void mtd_virt (int32 arg) cil managed 
        {
            .maxstack 8

            ldstr       "Reversing.ID"
            call        void class [mscorlib]System.Console::WriteLine(string)

            ret
        }
        // Signature: void class RevID.Program::mtd_virt (int32)


        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8
            ret 
        }

        // pemanggilan method secara tak langsung
        .method public instance 
                void _algorithm () cil managed 
        { 
            .maxstack 8

            .locals init (
                // memory disimpan sebagai native integer
                native  int             fptr,
                class   RevID.Program   obj
            )

            // pemanggilan terhadap method instance mengharuskan adanya instance.
            newobj      instance void class RevID.Program::'.ctor' ()
            stloc       obj

        // Instance Method
            // simpan alamat method yang ingin dipanggil
            ldftn       instance void class RevID.Program::mtd_inst (int32)
            stloc       fptr 

            // panggil fungsi secara tak langsung
            ldloc       obj
            ldc.i4      135         // push argumen sebelum method pointer
            ldloc       fptr 
            calli       instance void (int32)


        // Static Method
            // simpan alamat method yang ingin dipanggil
            ldftn       void class RevID.Program::mtd_static (int32)
            stloc       fptr

            // panggil fungsi secara tak langsung
            ldc.i4      135         // push argumen sebelum method pointer
            ldloc       fptr 
            calli       void (int32)


        // Virtual Method
            // load method yang tepat berdasarkan instance
            ldloc       obj
            ldvirtftn   instance void class RevID.Program::mtd_virt (int32)
            stloc       fptr 

            // panggil fungsi secara tak langsung
            ldloc       obj 
            ldc.i4      135         // push argumen sebelum method pointer
            ldloc       fptr 
            calli       instance void (int32)

            ret 
        }
    }
}