/*
    Variables
    .NET CIL Data Type 

    .NET IL terdiri atas beberapa komponen yang tersusun secara terstruktur
    dengan berorientasi objek.
    
    Deklarasi variabel dalam scope berbeda

Assembling:
    $ ilasm vars.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'vars' { }
.module   'program.exe'


/*    
    Variable & Constant
    Variabel dan konstanta adalah unit penyimpanan nilai saat program berjalan.
    Sebuah variabel atau konstanta dapat dideklarasikan di dua scope: Global dan Local

    Variabel global adalah variabel yang dideklarasikan di dalam Class namun di luar
    method, constructor, atau block apapun. Sementara variabel lokal adalah variabel 
    yang dideklarasikan di dalam scope tertentu (method, constructor, atau block).

    Ukuran ruang memory bergantung kepada tipe data yang digunakan. 

    Modifikasi nilai di variabel saat runtime diperbolehkan, sementara nilai di 
    konstanta tidak dapat dimodifikasi.
*/

.namespace RevID
{
    .class  public auto ansi beforefieldinit 
            Program extends [mscorlib]System.Object
    {
        /*
            Sebuah variabel global dapat berupa:
                - instance variable
                - static/class variable

            Instance variable adalah variabel yang dimiliki oleh setiap instance. Sementara 
            Static (class) variable adalah variabel yang dimiliki oleh sebuah Class.

            Instansiasi sebuah objek akan mendapatkan salinan semua instance variable yang
            dideklarasikan. Instance variable bersifat unik, dan perubahan nilai berlaku secara lokal 
            terhadap objek tersebut.

            Class variable bersifat global terhadap semua objek yang diinstansiasi dari Class yang sama.
            Hanya ada satu salinan Class variable yang diijinkan untuk semua objek yang serupa.
        */

        // deklarasi instance variable
        //  C#: public int g_var1 = 1; 
        .field  public  int32           g_var1

        // deklarasi static variable
        //  C#: public static int g_var2 = 2; 
        .field  public  static int32    g_var2

        // deklarasi konstanta dengan literal
        //  C#: public const int g_const1 = 3; 
        .field  public  static literal  int32   g_const1 = int32(0x3) 

        // deklarasi konstanta dengan initonly
        //  C#: public readonly int g_const2 = 4; 
        .field  public  static initonly int32   g_const2


        .method public hidebysig specialname rtspecialname instance default 
                void '.ctor' () cil managed
        {
            .maxstack 8

            // inisialisasi instance field akan dilakukan di .ctor
            ldc.i4.1
            stfld       int32 RevID.Program::g_var1 

            // g_const2 = 6
            ldc.i4.6
            stfld       int32 RevID.Program::g_const2

            // pemanggilan constructor Parent class
            ldarg.0
            call        instance void object::'.ctor'()

            ret 
        }

        .method public static hidebysig specialname rtspecialname default 
                void '.cctor' () cil managed 
        {
            .maxstack 8

            // inisialisasi static field dilakukan di .cctor
            ldc.i4.2
            stsfld      int32   RevID.Program::g_var2

            ret
        }


        .method public static hidebysig
                void Main () cil managed
        {
            .entrypoint
            .maxstack 8

            // deklarasi local variable 
            //  C#: int a = 5, b;
            .locals init (
                int32   var_a,      // valuetype
                int32   var_b,

                int32[] v_arr,      // variabel tipe array
                int32*  v_ptr,      // variabel tipe pointer
                int32&  v_ref       // variabel tipe reference
            )

            // inisialisasi maupun operasi terhadap local variable dilakukan
            // setelah deklarasi terjadi.
            ldc.i4.5
            stloc.0             // akses variabel melalui indeks

            ldc.i4.6
            stloc       var_b   // akses variabel melalui identifier

            ret 
        }
    }
}