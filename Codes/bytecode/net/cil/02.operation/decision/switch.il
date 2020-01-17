/*
    Switch 
    Decision-Making 

    Percabangan ke beragam alternatif berbeda berdasarkan Jump Table.

Assembling:
    $ ilasm switch.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'branching' { }
.module 'program.exe'


/*
    Branching (percabangan) adalah perpindahan eksekusi ke sekumpulan instruksi
    menggunakan satu atau lebih instruksi branching.

Tujuan:
    implementasi statement "Switch" atau "Jump Table".
    Percabangan dengan beragam kondisi alternatif berdasarkan nilai.

Bentuk umum (3 case):
    switch (variable)
    {
        case val_1: do_action_1; break;
        case val_2: do_action_2; break;
        ...
        default: do_alternative_action;
    }

    switch:   tes nilai variabel 
    case:     label lokasi dari target, bergantung kepada nilai variabel
    break:    lompat ke akhir blok "switch"
    default:  aksi alternatif secara umum ketika tidak ada nilai terpenuhi

Padanan:
    - untuk setiap statement break sepadan dengan Unconditional Branching ke akhir struktur
    - instruksi switch menyimpan tabel label dengan indeks tertentu.

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
            ret 
        }


/*-----------------------------------------------------------------------------
    One Layer Jump Table 

Karakteristik:
    label merupakan rangkaian nilai yang terurut atau memiliki gap yang minimum.

            switch (variable)
            {
                case 1: do_action_1; break;
                case 2: do_action_2; break;
                default: do_alternative_action;
            }
    
Catatan:
    apabila terdapat beberapa cluster case yang memiliki nilai berurutan, maka dapat
    dibentuk lebih dari 1 "switch" untuk menangani masing-masing cluster.
*/
        .method public instance 
                void _one_layer_jumptable () cil managed 
        {
            .maxstack 8

            .locals init (
                int32   var
            )

            ldc.i4      0
            stloc       var 

            // untuk efisiensi, tabel dimulai dari 0 sehingga
            //   - indeks 0 akan mengarah ke alternatif pertama
            //   - indeks 1 akan mengarah ke alternatif kedua
            //   - dst

            ldloc       var 
            ldc.i4      1
            sub 

            // periksa nilai var dan gunakan sebagai index untuk melompat ke label
            // yang disebutkan secara berurutan di instruksi switch
            switch (
                action_1,
                action_2
            )

            // jika tidak ada kondisi terpenuhi, lakukan Unconditional Branch ke 
            // case "default"
            br          action_default
        
        action_1:
            // eksekusi aksi action_1

            // lompat ke akhir switch
            br          end 
        
        action_2:
            // eksekusi aksi action_2

            // lompat ke akhir switch
            br          end 
        
        action_default:
            // eksekusi action_default ketika tidak ada kondisi terpenuhi
            br          end 

        end:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.

            ret 
        }


//-----------------------------------------------------------------------------

/*
   Jump Table with Gap

Karakteristik:
    label merupakan rangkaian nilai yang terurut namun terdapat beberapa case 
    yang memiliki kesenjangan dengan nilai sebelum atau sesudahnya.

            switch (variable)
            {
                case 1: do_action_1; break;
                case 2: do_action_2; break;
                case 5: do_action_5; break;
                default: do_alternative_action;
            }

    case yang tidak nampak akan diarahkan menuju case "default" jika ada, atau menuju end
*/
        .method public instance 
                void _gap_jumptable () cil managed 
        {
            .maxstack 8

            .locals init (
                int32   var
            )

            ldc.i4      0
            stloc       var 

            // untuk efisiensi, tabel dimulai dari 0 sehingga
            //   - indeks 0 akan mengarah ke alternatif pertama
            //   - indeks 1 akan mengarah ke alternatif kedua

            ldloc       var 
            ldc.i4      1
            sub 

            // periksa nilai var dan gunakan sebagai index untuk melompat ke label
            // yang disebutkan secara berurutan di instruksi switch
            switch (
                action_1,
                action_2,
                action_default,       // lompat ke case "default"
                action_default,       // lompat ke case "default"
                action_5
            )

            // jika tidak ada kondisi terpenuhi, lakukan Unconditional Branch ke 
            // case "default"
            br          action_default
        
        action_1:
            // eksekusi aksi 1

            // lompat ke akhir switch
            br          end 
        
        action_2:
            // eksekusi aksi 2

            // lompat ke akhir switch
            br          end 
        
        action_5:
            // eksekusi aksi 5

            // lompat ke akhir switch
            br          end 
        
        action_default:
            // eksekusi do_default_action ketika tidak ada kondisi terpenuhi
            br          end 

        end:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.


            ret 
        }
    }
}