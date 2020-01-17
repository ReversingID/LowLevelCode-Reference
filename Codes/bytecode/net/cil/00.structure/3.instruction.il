/*
    Instruction

    .NET IL terdiri atas beberapa komponen yang tersusun secara terstruktur
    dengan berorientasi objek.

Assembling:
    $ ilasm instruction.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'instruction' { }
.module 'program.exe'


/*
    Instruction
    Instruction adalah statement dalam satu baris tunggal.
    .NET CIL merupakan sebuah Process VM berbasis Stack.

    Setiap instruksi dapat membutuhkan operan dan menghasilkan nilai.
    Operan dan hasil akan menggunakan Stack sebagai penyimpanan sementara.

    Setiap instruksi memiliki format umum sebagai berikut:

        [label:] instruction [parameter]
    
    Jumlah operan suatu instruksi dapat bervariasi.
    Eksekusi instruksi tertentu akan mengambil sekian elemen yang 
    dibutuhkan dari Stack.
    Jika instruksi menghasilkan nilai, maka otomatis nilai tersebut akan 
    disimpan ke Stack.

    Parameter adalah informasi tambahan selain operan yang digunakan oleh 
    beberapa instruksi.
*/

// -- Namespace Declaration --
.namespace RevID
{
    // -- Class Declaration --
    .class  public auto ansi beforefieldinit 
            Program extends [mscorlib]System.Object
    {
        .method public static hidebysig 
                void Main () cil managed 
        {
            .entrypoint
            .maxstack 8
        
        // Contoh Instruction dengan parameter
            // panggil (call) sebuah method static bernama doSomething() di Class Program 
            // pada namespace RevID
            // dalam hal ini, operan adalah nama method dan instruksi adalah "call"
            call        void class RevID.Program::doSomething ()
        
        // Contoh Instruction dengan dua Operand
            // kalikan 15 dan 9
            // dalam hal ini, operan adalah dua bilangan yang tersimpan di stack.
            ldc.i4.s    0x09
            ldc.i4.s    0x0f
            mul
        
        // Contoh Instruction tanpa Operand dan parameter
            // mengeluarkan nilai di puncak Stack.
            pop

            ret 
        }


        .method public static hidebysig default 
                void doSomething () cil managed 
        {
            .maxstack 8
            ret
        }
    } 
}