/*
    String
    .NET CIL Data Type

    String dan operasinya.

Assembling:
    $ ilasm string.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'string' { }
.module   'program.exe'


/*
    String
    String adalah object berisi deretan huruf, angka, dan simbol-simbol teks 
    yang tersimpan secara read-only. Mekanisme string di CIL tidak menggunakan 
    NULL atau karakter spesial lain sebagai batas akhir dari string.

    String bersifat immutable, tidak dapat berubah setelah diciptakan.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {

        // -- Deklarasi variabel global --
        .field  public string   g_str


        .method public static
                void Main () cil managed
        {
            .entrypoint
            .maxstack 8
            ret
        }


        .method public instance 
                void _algorithm () cil managed 
        {
            .maxstack 8

            // alokasi local variable
            .locals init (
                string  var_str
            )

            ldstr       "Reversing.ID"

        /*
            Store (simpan) nilai ke variabel akan mengambil nilai di puncak Stack.
            Load (muat) nilai dari variabel akan menaruh nilai ke puncak Stack.

            Sebuah variabel dapat diidentifikasi berdasarkan indeks deklarasi dan nama.
            Akses melalui indeks hanya berlaku untuk variabel dengan indeks 0 hingga 3.
        */
        // simpan nilai ke variabel
            stloc.0
            stloc       var_str

        // memuat nilai dari variabel
            ldloc.0
            ldloc       var_str
        
        // memuat alamat dari variabel
            ldloca      var_str


        // mendapatkan panjang string
            ldloc.0
            callvirt    instance int32 string::get_Length()
        
        // penggabungan (concatenation)
            ldstr       "Reversing"
            ldstr       "ID"
            call        string string::Concat(string, string)
            stloc       var_str


            ret 
        }
    }
}