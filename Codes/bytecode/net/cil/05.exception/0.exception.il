/*
    Exception Handling

Assembling:
    $ ilasm exception.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'exception' { }
.module 'program.exe'


/*
    Exception Handling 
    Exception adalah event (masalah), yang muncul selama eksekusi program, sehingga
    mengganggu alur eksekusi normal aplikasi. Exception memberikan cara untuk 
    transfer kendali alur program dari satu bagian ke bagian lain.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        /*
            Exception dapat dipicu oleh peristiwa-peristiwa yang terjadi secara 
            alamiah dalam runtime. Salah satu contohnya adalah pembagian dengan 0
            dimana hasil pembagian ini tidak terdefinisi dalam matematika.

            Exception dapat juga dipicu secara manual menggunakan mekanisme
            pelemparan (throw) ke handler yang sesuai. Exception yang dilempar 
            haruslah 
        */

        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8

            .locals init (
                int32       lhs,
                int32       rhs,
                int32       result,
                class   [mscorlib]System.DivideByZeroException  ex
            )

            // picu DivideByZeroException akibat pembagian 0
            ldc.i4      135
            stloc       lhs         // lhs = 135
            ldc.i4.0
            stloc       rhs         // rhs = 0
            ldc.i4.1
            stloc       result      // result = 1


            // Idealnya, semua kode yang dapat memicu Exception harus
            // diletakkan di dalam try agar dapat diteruskan ke handler sesuai
            .try {
                // pembagian dengan 0 akan menghasilkan Exception
                ldloc       lhs 
                ldloc       rhs 
                div 
                stloc       result      // result = lhs / rhs

                // keluar dari bagian kode yang terproteksi (protected region)
                leave       Exit
            }
            // Daftar penanganan Exception.
            catch class [mscorlib]System.DivideByZeroException {
                // simpan exception ke variabel lokal
                stloc       ex 

                ldloc       ex 
                callvirt    instance string class [mscorlib]System.Exception::get_Message ()
                call        void class [mscorlib]System.Console::WriteLine (string)

                // keluar dari bagian kode yang terproteksi (protected region)
                leave       Exit
            }

        Exit:
            ret 
        }
    }
}