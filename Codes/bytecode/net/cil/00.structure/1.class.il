/*
    Class

    .NET IL terdiri atas beberapa komponen yang tersusun secara terstruktur
    dengan berorientasi objek.

Assembling:
    $ ilasm class.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'class' { }
.module 'program.exe'

/* 
    Namespace
    Ruang identitas (nama) untuk menghimpun menghimpun dan mengorganisir beragam
    objek secara terstruktur. Namespace dapat terdiri dari class, enum, struct, dan 
    deklarasi lain yang kemudian diidentifikasi dalam nama yang unik.

    Namespace digunakan untuk memisahkan definisi berdasarkan kesamaan penggunaan
    sehingga tidak menciptakan polusi nama. Masing-masing nama tidak saling 
    memengaruhi satu sama lain.
*/

.namespace RevID
{
    /* 
        Class
        Class adalah sebuah template yang memodelkan sebuah entitas dan perilakunya.
        
        Class terdiri atas beberapa komponen:
            - Field / variable 
            - Method / function 
        
        Instansiasi Class akan menghasilkan objek dengan data masing-masing.

        Sebuah Class dapat diturunkan dari maksimal satu Class lain.

        Sebuah Class dapat didefinisikan dengan access modifier tertentu 
        (public, private, internal) dan memengaruhi aksesibilitas Class tersebut.
    */
    .class  public auto ansi beforefieldinit 
            Program extends [mscorlib]System.Object
    {
        /*
            Notasi yang digunakan untuk mereferensi Parent Class mengikuti format TypeRef:

                [AssemblyRef] Namespace.ClassName 
            
            ClassName 
                menyatakan nama Class yang menjadi Parent.
            Namespace 
                menyatakan namespace dimana ClassName dideklarasikan, namespace dapat bersarang.
            [AssemblyRef] 
                menyatakan assembly dimana Namespace.ClassName dideklarasikan.
        */

        // Deklarasi Field.
        // Inisialisasi Field akan dilakukan di constructor, bukan saat deklarasi.
        .field  public  int32   var_i;
        .field  public  string  var_s;

        // Constructor (.ctor)
        // method khusus yang dipanggil di awal instansisasi objek.
        // digunakan untuk menginisialisasi field di Class.
        .method public hidebysig specialname rtspecialname instance default 
                void '.ctor' () cil managed
        {
            // ukuran stack maksimal dari sebuah method
            .maxstack 8

            // - inisialisasi Field terlebih jika diperlukan -

            // pemanggilan constructor Parent Class
            ldarg.0
            call    instance void [mscorlib]System.Object::'.ctor'()
            ret 
        }

        // Class Constructor (.cctor)
        // method khusus yang dipanggil untuk menginisialisasi Class sebelum
        // instansiasi pertama dilakukan.
        // digunakan untuk inisialisasi static member dari Class. 
        .method private static hidebysig specialname rtspecialname default 
                void '.cctor' () cil managed 
        {
            .maxstack 8

            // - inisialisasi static Field terlebih jika diperlukan -

            ret
        }


        // Main() adalah method khusus yang menjadi entrypoint bagi aplikasi.
        .method public static hidebysig 
                void Main (string [] args) cil managed 
        {
            // entrypoint adalah user-defined method yang dieksekusi pertama kali
            .entrypoint
            .maxstack 8
            ret 
        }
    }


    /*
        Interface 
        Class khusus yang hanya mendeklarasikan sekumpulan method tanpa memberikan definisi
        kode. Interface tidak dapat diinstansiasi, hanya dapat diimplementasi sebagai bagian 
        dari Class lain.

        Method yang dideklarasikan di Interface akan didefinisikan di Class yang mengimplementasikan.
    */
    .class  interface public auto ansi abstract 
            RevInterface
    {
        .method public virtual hidebysig newslot abstract instance default 
                void doSomething() cil managed 
        {

        }
    }
}