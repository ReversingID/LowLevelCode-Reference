/*
    User-Defined Exception

Assembling:
    $ ilasm defined.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'defined' { }
.module 'program.exe'


/*
    .NET CIL telah menyertakan beragam Class yang dapat digunakan untuk 
    merepresentasikan kondisi Exception. Namun, terkadang perlu didefinisikan 
    Exception baru untuk merepresentasikan event yang belum ada. 
    
    Sebuah Exception haruslah bertipe Class Exception. Dengan demikian, untuk 
    membuat tipe Exception baru, Exception harus diturunkan dari Class Exception. 
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        /*
            Exception baru dapat didefinisikan di dalam atau di luar namespace.
        */

        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8

            .locals init (
                class   RevIDException      ex
            )

            // Idealnya, semua kode yang dapat memicu Exception harus
            // diletakkan di dalam try agar dapat diteruskan ke handler sesuai
            .try {

                // Exception yang dilempar harus dibangun atau diturunkan dari 
                // System.Exception
                ldstr   "Raise (User-Defined) Exception"
                newobj  instance void class RevIDException::'.ctor' (string)
                throw 
            }
            // Daftar penanganan Exception.
            catch class RevIDException {
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

// Exception yang didefinisikan di luar namespace RevID
.class  public 
        RevIDException extends [mscorlib]System.Exception
{
    .method public specialname rtspecialname instance 
            void '.ctor' (string msg) cil managed 
    {
        .maxstack 8

        ldarg.0
        ldarg.1
        call        instance void class [mscorlib]System.Exception::'.ctor' (string)

        ret
    }
}