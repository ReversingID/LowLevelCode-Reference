/*
    Float
    .NET CIL Data Type 

    Bilangan pecahan dan operasinya.

Assembling:
    $ ilasm float.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'float' { }
.module   'program.exe'


/*
    Floating-Point Number
    Floating Point atau bilangan pecahan adalah bilangan yang memiliki komponen pecahan
    atau nilai di belakang koma. Definisi bilangan Floating Point untuk sistem 
    komputer didefinisikan melalui beberapa ketentuan seperti IEEE 7544.

    Dalam sistem komputer atau mesin digital, bilangan pecahan direpresentasikan dalam
    rentang yang terbatas. Umumnya, terdapat N kemungkinan nilai untuk floating point:
      - bilangan positif: F > 0.0
      - bilangan negatif: F < 0.0
      - nol: 0.0
      - inifinity positif: ∞
      - infinity negatif: -∞
      - NaN (Not a Number)
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        /*
            Sebuah floating-point number dideklarasikan dengna tipe yang sesuai.

            Beberapa tipe yang umum: float32, float64

            Tidak seperti integer, float mendefinisikan bentuk signed dan unsigned.
        */

        // -- Deklarasi variabel global --
        .field  public  float32     g_r4
        .field  public  float64     g_r8

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
                float32     var_0,
                float64     var_1
            )

            ldc.r4      1.0
        
        /*
            Store (simpan) nilai ke variabel akan mengambil nilai di puncak Stack.
            Load (muat) nilai dari variabel akan menaruh nilai ke puncak Stack.

            Sebuah variabel dapat diidentifikasi berdasarkan indeks deklarasi dan nama.
            Akses melalui indeks hanya berlaku untuk variabel dengan indeks 0 hingga 3.
        */
        // simpan nilai ke variabel
            stloc.0
            stloc       var_1

        // memuat nilai dari variabel
            ldloc.0
            ldloc       var_1
        
        // memuat alamat dari variabel
            ldloca      var_1
            
        // load nilai konstan float (float32)
            ldc.r4      135
            

            ret 
        }
    }
}