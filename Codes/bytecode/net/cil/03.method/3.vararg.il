/*
    Vararg & Variadic Method

    Deklarasi dan penggunaan method dengan argumen dinamis.

Assembling:
    $ ilasm vararg.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'param' { }
.module 'program.exe'


/*
    Vararg 
    Varable Argument (vararg) adalah argumen sebuah method yang dapat menerima 
    sembarang jumlah argumen yang diberikan. Method yang mengimplementasikan vararg 
    disebut sebagai Variadic Method atau method yang memiliki arity yang tak tentu.
    
    Normalnya sebuah method dideklarasikan dengan jumlah dan tipe argumen yang pasti.
    Setiap method memiliki signature berdasarkan tipe kembalian dan tipe tiap argumen 
    yang dimiliki.

    Variadic Method tidak mendeklarasikan jumlah argumen yang pasti. Tidak pula tipe 
    argumen yang diterima.
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

            // -- Method Call --
            // pemanggilan dengan 4 argumen
            ldc.i4.1
            ldc.i4.2
            ldc.i4.3
            ldc.i4.4
            call        vararg void class RevID.Program::_variadic(..., int32, int32, int32, int32)

            // pemanggilan dengan 2 argumen
            ldc.i4      9
            ldc.i4      8
            call        vararg void class RevID.Program::_variadic(..., int32, int32)

            ret 
        }
        
        /*
            Iterasi terhadap vararg membutuhkan bantuan dari Runtime. 
            Eksekusi instruksi "arglist" akan memberikan sebuah opaque handle yang 
            merepresentasikan argument list untuk method saat ini. Handle ini hanya valid
            dalam lifetime method tersebut.
        */
        .method public static vararg 
                void _variadic () cil managed 
        {
            .maxstack 8

            .locals init (
                valuetype   [mscorlib]System.ArgIterator  iter,
                int32       n
            )

            // instansiasi ArgIterator
            //      ArgIterator iter = new ArgIterator(__arglist)
            ldloca      iter 
            arglist 
            call        instance void valuetype [mscorlib]System.ArgIterator::'.ctor'(valuetype [mscorlib]System.RuntimeArgumentHandle)

            // -- iterasi arglist --

            // dapatkan jumlah arglist yang tersisa
            //      n = iter.GetRemainingCount()
            ldloca      iter 
            call        instance int32 valuetype [mscorlib]System.ArgIterator::GetRemainingCount()
            stloc       n 

            br          loop_check

            // iterasi selama n bernilai positif
        loop_body:
            // dapatkan instance object dari elemen saat ini
            ldloca      iter 
            call        instance typedref valuetype [mscorlib]System.ArgIterator::GetNextArg()
            call        object typedref::ToObject(typedref)

            // cetak objek
            call        void class [mscorlib]System.Console::WriteLine(object)

            // kurangi counter n
            ldloc       n 
            ldc.i4.1
            sub 
            stloc       n 

        loop_check:
            ldloc       n 
            ldc.i4      0
            bgt         loop_body

            ret
        }
    }
}