/*
    Interface
    
    Memodelkan turunan dalam IL 
    Implementing Interface.

Assembling:
    $ ilasm interface.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'interface' { }
.module 'program.exe'


/*
    Inheritance
    Salah satu konsep penting dalam Object-Oriented Programming.
    Inheritance (warisan) adalah konsep dimana sebuah Class yang didefinisikan dapat 
    memiliki segala property dari Class lain.

    Class dapat diturunkan dari Class atau Interface lain, dengan aturan tertentu.
    Class yang diturunkan dari Class lain disebut sebagai Derived Class (Class anak).
    Sementara Class yang menjadi orang tua disebut sebagai Base Class.

    Sebuah Class hanya dapat mewarisi (extend) satu Base Class namun diperbolehkan 
    mengimplementasikan (implement) method dari beragam Interface.

    
    Interface 
    Interface didefinisikan sebagai sebuah kontrak dimana semua Class yang mewarisi
    interface harus mengimplementasikan method yang diberikan. Interface hanya
    mendeklarasikan method tanpa memberikan definisi kode. Interface tidak dapat
    diinstansiasi menjadi objek, hanya dapat diimplementasi oleh Class lain.
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

            .locals init (
                class RevID.Concrete    concrete
            )

            // instansiasi objek
            newobj      instance void class RevID.Concrete::'.ctor' ()
            stloc       concrete 

            // -- Method Call --

            /*
                Concrete Class mewarisi method yang dideklarasikan oleh Interface Class.
                Concrete akan mendefinisikan method yang sesuai.

                Setiap method yang berjenis instance method harus menyertakan object.
            */
            
            ldloc       concrete 
            callvirt    instance void class RevID.Concrete::mtd_iface ()


            ret 
        }
    }

//-----------------------------------------------------------------------------

    /*
        Deklarasi Interface
        Method yang dideklarasikan di Interface akan didefinisikan di Class 
        yang mengimplementasikan.

        Semua method adalah abstract, tidak ada badan method.
    */
    .class  interface public abstract
            Interface 
    {
        .method public virtual newslot abstract instance 
                void mtd_iface () cil managed 
        { }
    }

//-----------------------------------------------------------------------------

    /*
        Deklarasi Derived Class
        Class yang diturunkan dari Base.
    */
    .class  public 
            Concrete 
            extends    [mscorlib]System.Object 
            implements RevID.Interface
    {
        .method public specialname rtspecialname instance 
                void '.ctor' () cil managed 
        {
            .maxstack 8
            
            ldarg.0
            call        instance void object::'.ctor' ()

            ret 
        }

        // Override virtual method
        .method public final virtual instance 
                void mtd_iface () cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void RevID.Concrete::mtd_iface ()
    }
}