/*
    Nested Class

    Deklarasi Class di dalam Class lain

Assembling:
    $ ilasm nested.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'nested' { }
.module 'program.exe' 


/*
    Nested Class  
    Nested Class (Class bersarang) adalah Class bertipe khusus yang didefinisikan
    di dalam scope Class lain, alih-alih didefinisikan di sebuah namespace. Tidak
    ada batasan level dari sebuah Class, namun secara praktik jarang ditemukan 
    Class didefinisikan lebih dari 2 tingkat. 

    Secara teknis, Nested Class tidak berbeda dengan Class lain. Sedikit penyesuaian
    harus dilakukan untuk melakukan instansisasi dimana semua scope yang berada di 
    atas Nested Class harus turut serta disebutkan.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        .method public static 
                void Main (string [] args) cil managed 
        {
            .entrypoint
            .maxstack 8

            .locals init(
                class RevID.Outer           outer,
                class RevID.Outer/Inner     inner 
            )

        // -- Instansiasi Object --
            // Instansiasi Class Outer
            newobj      instance void class RevID.Outer::'.ctor' ()
            stloc       outer 

            // Instansiasi Class Inner
            newobj      instance void class RevID.Outer/Inner::'.ctor' ()
            stloc       inner 


        // -- Pemanggilan Method --
            // Method di Class Outer
            ldloc       outer 
            callvirt    instance void class RevID.Outer::mtd_outer () 

            // Method di Class Inner
            ldloc       inner 
            callvirt    instance void class RevID.Outer/Inner::mtd_inner ()


            ret
        }
    }

//-----------------------------------------------------------------------------

    // Deklarasi Class luar yang menaungi Nested Class.
    .class  public 
            Outer extends [mscorlib]System.Object 
    {
        .method public specialname rtspecialname instance 
                void '.ctor' () cil managed 
        {
            .maxstack 8
            
            ldarg.0
            call        instance void object::'.ctor' ()

            ret 
        }

        .method public instance 
                void mtd_outer () cil managed 
        {
            .maxstack 8
            ret 
        }



        // Deklarasi Class dalam atau Nested Class
        .class  nested public 
                Inner extends [mscorlib]System.Object
        {
            .method public specialname rtspecialname instance 
                    void '.ctor' () cil managed 
            {
                .maxstack 8
                
                ldarg.0
                call        instance void object::'.ctor' ()

                ret 
            }

            // Method di dalam Nested Class
            .method public instance 
                    void mtd_inner () cil managed 
            {
                .maxstack 8
                ret
            }
        }
    }
}
