/*
    Class Casting

    Typecast objek menjadi tipe lain yang berhubungan.

Assembling:
    $ ilasm classcast.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'classcast' { }
.module 'program.exe' 


/*
    Sebuah objek merupakan instansiasi dari sebuah Class.
    
    Instruksi castclass akan mengubah tipe suatu objek di puncak Stack menjadi 
    tipe lain yang disebutkan.
    
    Instruksi ini hanya berhasil jika objek memiliki hubungan warisan dengan tipe 
    tujuan. Apabila proses casting gagal dilakukan maka CLR akan melempar Exception
    System.InvalidCastException.
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
                class RevID.Derived derived 
            )

            // instansiasi objek
            newobj      instance void class RevID.Derived::'.ctor' ()
            stloc       derived
        
        // -- Cast Class --
            ldloc       derived  
            castclass   class RevID.Base

            ldnull 
            ceq 
            brtrue      Exit

            ldstr       "All Checks!"
            call        void class [mscorlib]System.Console::WriteLine(string)

        Exit:
            ret
        }
    }

//-----------------------------------------------------------------------------

    // Deklarasi Class induk
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
    }

    // Deklarasi Class turunan
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
    }
}
