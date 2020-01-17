/*
    Direct Call

    Pemanggilan berbagai jenis method secara langsung 

Assembling:
    $ ilasm call.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'call' { }
.module 'program.exe'


/*
    Pemanggilan method merupakan sebuah aksi untuk memindahkan alur eksekusi sehingga
    instruksi di dalam method dapat dieksekusi.
    Pemanggilan jenis method yang berbeda akan membutuhkan instruksi dan tata cara 
    yang berbeda pula.

    Setidaknya terdapat dua jenis method:
        - instance method 
        - class method (static)
    
    Pemanggilan secara langsung (direct call) terhadap method adalah pemanggilan method, 
    baik instance method maupun class method, tanpa melalui pointer atau delegasi.

    Terdapat dua instruksi untuk melakukan pemanggilan method: call dan callvirt.
    Call adalah instruksi sederhana untuk memanggil method berdasarkan nama. 
    Sementara callvirt adalah instruksi untuk memanggil method yang berasosiasi dengan 
    objek saat runtime. Callvirt mengakomodasi kemungkinan bahwa method yang dipanggil 
    bersifat virtual dan mungkin memiliki implementasi yang beragam. Callvirt mendukung 
    polimorfisme, dapat digunakan untuk memanggil method yang virtual maupun bukan.

    Gunakan callvirt untuk memanggil method dari sebuah instance. 
    Gunakan call untuk memanggil method statis yang tidak terikat instance. 
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        // -- Instance Method --
        // Terikat pada objek.
        .method public instance
                void mtd_inst1 () cil managed 
        {
            .maxstack 8
            ret   
        }
        // Signature: void RevID.Program::mtd_inst1 ()

        .method public instance 
                void mtd_inst2 (int32 arg) cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void RevID.Program::mtd_inst2 (int32)


        // -- Static Method --
        // Terikat pada Class
        .method public static
                void mtd_static1 () cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void class RevID.Program::mtd_static1 ()

        .method public static 
                void mtd_static2 (int32 arg) cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void class RevID.Program::mtd_static1 (int32)


        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8
            ret 
        }


        // pemanggilan method secara langsung (tanpa abstraksi)
        .method public instance 
                void _algorithm () cil managed 
        { 
            .maxstack 8

            .locals init (
                class   RevID.Program   l_prg
            )

            // pemanggilan terhadap method instance mengharuskan adanya instance.
            newobj      instance void class RevID.Program::'.ctor' ()
            stloc.0

        // -- Instance Method -- 
            // pemanggilan method tanpa argumen
            ldloc.0 
            callvirt    instance void class RevID.Program::mtd_inst1 ()

            // pemanggilan method dengan argumen
            ldloc.0 
            ldc.i4      135         // int32
            callvirt    instance void class RevID.Program::mtd_inst2 (int32)


        // -- Static Method --
            // pemanggilan method tanpa argumen
            call        void class RevID.Program::mtd_static1 ()
            
            // pemanggilan method dengan argumen
            ldc.i4      135         // int32
            call        void class RevID.Program::mtd_static2 (int32)
            
            ret 
        }
    }
}