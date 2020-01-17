/*
    Instance Check

Assembling:
    $ ilasm check.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'check' { }
.module 'program.exe' 


/*
    Sebuah objek merupakan instansiasi dari sebuah Class.
    Selama runtime, interogasi terhadap tipe Class dapat dilakukan.
    
    Instruksi isinst akan menguji apakah item di puncak Stack merupakan instance 
    dari Class yang diberikan. 
    
    Instruksi ini akan menghasilkan nilai benar apabila:

        - objek merupakan instance dari Class tersebut .
        - objek merupakan instance dari turunan Class tersebut.
    
    Jika terbukti benar, maka instruksi akan mengembalikan instance ke Stack. 
    Sebaliknya, nilai NULL akan diberikan.
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
                class RevID.Base    base,
                class RevID.Derived derived 
            )

            // instansiasi objek
            newobj      instance void class RevID.Base::'.ctor' ()
            stloc       base 
            newobj      instance void class RevID.Derived::'.ctor' ()
            stloc       derived
        
        // -- Instance Check --
            // bandingkan dengan Class sendiri
            // base adalah Base?
            ldloc       base 
            isinst      class RevID.Base 

            ldnull      // NULL jika bukan instance dari Base
            ceq
            brtrue      Exit

            // derived adalah Derived?
            ldloc       derived  
            isinst      class RevID.Derived

            ldnull 
            ceq 
            brtrue      Exit 
        

            // bandingkan dengan Class induk
            // derived adalah Base?
            ldloc       derived 
            isinst      class RevID.Base 

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
