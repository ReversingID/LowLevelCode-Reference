/*
    Class
    
    Memodelkan turunan dalam IL 
    Extending Base Class.

Assembling:
    $ ilasm class.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'class' { }
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
                class RevID.Base    base,
                class RevID.Derived derived
            )

            // instansiasi objek
            newobj      instance void class RevID.Base::'.ctor' ()
            stloc       base
            newobj      instance void class RevID.Derived::'.ctor' ()
            stloc       derived 

            // -- Method Call --

            /*
                Derived Class mewarisi method yang didefinisikan oleh Base Class.
                Dengan demikian Derived dapat melakukan pemanggilan method yang sama 
                sebagaimana didefinisikan oleh Base Class.

                Setiap method yang berjenis instance method harus menyertakan object.
                Apabila method bersifat virtual, maka resolusi akan dilakukan secara
                otomatis untuk menentukan method mana yang dipanggil.
            */
        
            //  b.mtd_inst()
            ldloc       base 
            callvirt    instance void class RevID.Base::mtd_inst ()

            // b.mtd_virt()
            ldloc       base 
            callvirt    instance void class RevID.Base::mtd_virt ()

            // d.mtd_inst()
            ldloc       derived 
            callvirt    instance void class RevID.Base::mtd_inst () 

            // d.mtd_virt()
            ldloc       derived
            callvirt    instance void class RevID.Base::mtd_virt ()


            ret 
        }
    }

//-----------------------------------------------------------------------------

    /*
        Deklarasi Base Class 
        Class yang menjadi induk dari Class lain tetap diturunkan dari System.Object.
    */
    .class  public 
            Base extends [mscorlib]System.Object 
    {
        .method public specialname rtspecialname instance 
                void '.ctor' () cil managed 
        {
            .maxstack 8
            
            ldarg.0
            call        instance void object::'.ctor' ()

            ret 
        }

        // Deklarasikan sebuah method
        .method public instance 
                void mtd_inst () cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void RevID.Base::mtd_inst ()

        // Deklarasikan sebuah method virtual
        .method public virtual newslot instance 
                void mtd_virt () cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void RevID.Base::mtd_virt ()
    }

//-----------------------------------------------------------------------------

    /*
        Deklarasi Derived Class
        Class yang diturunkan dari Base.
    */
    .class  public 
            Derived extends RevID.Base
    {
        .method public specialname rtspecialname instance 
                void '.ctor' () cil managed 
        {
            .maxstack 8
            
            ldarg.0
            call        instance void RevID.Base::'.ctor' ()

            ret 
        }

        // Override virtual method
        .method public virtual instance 
                void mtd_virt () cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void RevID.Base::mtd_virt ()
    }
}