/*
    Method Overload

Assembling:
    $ ilasm method-overload.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'method-overload' { }
.module 'program.exe' 


/*
    Method Overload 
    C# dan .NET CL mendukung pendefinisian ulang (overload) method sehingga
    beberapa method dapat berbagi nama yang sama selama memiliki signature yang 
    berbeda.


    Type Signature
    Type Signature atau Type Annotation menyatakan tipe yang menjadi penanda
    suatu method, identifikasi unik suatu method.
    Terdiri atas dua komponen utama:
        - tipe return value 
        - method reference 
        - tipe dan jenis (value, reference, output) tiap argumen
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

        // -- Pemanggilan Method --
            // method tanpa argument
            call        void class RevID.Program::mtd_overloaded ()

            // method dengan argument int32
            ldc.i4      135
            call        void class RevID.Program::mtd_overloaded (int32)

            // method dengan argument string
            ldstr       "Reversing.ID"
            call        void class RevID.Program::mtd_overloaded (string)
        
            ret
        }

        // Method tanpa argument
        .method public static 
                void mtd_overloaded () cil managed 
        {
            .maxstack 8
            ret 
        }

        // Method dengan argument int32
        .method public static 
                void mtd_overloaded (int32 arg) cil managed 
        {
            .maxstack 8
            ret 
        }

        // Method dengan argument string
        .method public static 
                void mtd_overloaded (string arg) cil managed 
        {
            .maxstack 8
            ret 
        }
    }    
}
