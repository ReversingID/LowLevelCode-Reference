/*
    Throw Exception

Assembling:
    $ ilasm throw.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'throw' { }
.module 'program.exe'


/*
    Exception Handling 
    Exception adalah event (masalah), yang muncul selama eksekusi program, sehingga
    mengganggu alur eksekusi normal aplikasi. Exception memberikan cara untuk 
    transfer kendali alur program dari satu bagian ke bagian lain.

    Ketika error muncul di dalam method, sebuah objek akan dibangun untuk 
    merepresentasikan event tersebut kemudian dilempar ke runtime system (CLR), 
    berharap terdapat penanganan yang sesuai. Object yang dibangun disebut sebagai
    Exception Object, berisi informasi tentang error atau event, termasuk tipe 
    dan keadaan dari program ketika event terjadi.
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
                class   [mscorlib]System.Exception  ex
            )

            // Idealnya, semua kode yang dapat memicu Exception harus
            // diletakkan di dalam try agar dapat diteruskan ke handler sesuai
            .try {

                // Exception yang dilempar harus dibangun atau diturunkan dari 
                // System.Exception
                ldstr       "Raise Exception"
                newobj      instance void class [mscorlib]System.Exception::'.ctor' (string)
                throw

                // keluar dari bagian kode yang terproteksi (protected region)
                leave       Exit
            }
            // Daftar penanganan Exception.
            catch class [mscorlib]System.Exception {
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

/*
Beberapa Exception umum:
    - System.IO.IOException
    - System.IndexOutOfRangeException
    - System.ArrayTypeMismatchException
    - System.NullReferenceException
    - System.DivideByZeroException
    - System.InvalidCastException
    - System.OutOfMemoryException
    - System.StackOverflowException

*/