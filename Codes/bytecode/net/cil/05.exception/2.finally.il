/*
    Finally-Clause

Assembling:
    $ ilasm finally.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'finally' { }
.module 'program.exe'


/*
    Exception Handling 
    Exception adalah event (masalah), yang muncul selama eksekusi program, sehingga
    mengganggu alur eksekusi normal aplikasi. Exception memberikan cara untuk 
    transfer kendali alur program dari satu bagian ke bagian lain.

    Dalam mekanisme Exception Handling, terdapat empat komponen utama:

    - try: block berisi kode yang berpotensi menimbulkan Exception.
    - catch: block yang menangkap Exception tertentu, kasus demi kasus, dan akan
            memberikan penanganan yang sesuai (user-defined).
    - throw: memicu sebuah Exception atau melempar objek Exception, secara 
            user defined.
    - finally: blok kode yang mendapat jaminan akan dieksekusi terlepas dari
            kemunculan Exception.
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
                class   [mscorlib]System.Exception  ex
            )

            /*
                Konstruksi Try hanya dapat muncul secara berpasangan baik dengan 
                Catch maupun Finally namun tidak dengan keduanya sekaligus.
                Apabila dibutuhkan lebih dari satu komponen, maka konstruksi Try
                dapat dituliskan dalam bentuk bersarang.
            */

            // Try-Finally
            .try {
                // Try-Catch
                .try {
                    // lempar Exception
                    ldstr       "Raise Exception"
                    newobj      instance void class [mscorlib]System.Exception::'.ctor' (string)
                    throw

                    // keluar dari bagian kode yang terproteksi (protected region)
                    leave       Exit_Catch
                }
                // Daftar penanganan Exception.
                catch class [mscorlib]System.Exception {
                    // simpan exception ke variabel lokal
                    stloc       ex 

                    ldloc       ex 
                    callvirt    instance string class [mscorlib]System.Exception::get_Message ()
                    call        void class [mscorlib]System.Console::WriteLine (string)

                    // keluar dari bagian kode yang terproteksi (protected region)
                    leave       Exit_Catch
                }
        Exit_Catch:
                leave       Exit 
            }
            // Kode ini dijamin akan dieksekusi meskipun Exception muncul.
            finally {
                ldstr       "Execute on Finally"
                call        void class [mscorlib]System.Console::WriteLine (string)

                // tandai akhir block
                endfinally       
            }

        Exit:
            ret 
        }
    }
}