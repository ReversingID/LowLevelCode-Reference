/*
    Arithmetic

    Operasi aritmetik pada .NET CIL

Assembling:
    $ ilasm arithmetic.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'arithmetic' { }
.module   'program.exe'


/*
    Arithmetic 
    Operasi aritmetika adalah operasi perhitungan yang melibatkan bilangan dasar.

    Operasi pada aritmetika terdiri atas beberapa kategori:
        - penjumlahan (addition)
        - pengurangan (subtraction)
        - perkalian (multiplication)
        - pembagian (divsion)
        - sisa bagi / modulus
    
    Operasi pada .NET CIL melibatkan evaluation stack.
    Ketika instruksi aritmetik dieksekusi, sejumlah Operan yang sesuai akan diambil
    dari Stack dan nilai yang dihasilkan akan diletakkan kembali ke Stack.

    Konsumsi operan akan dimulai dari puncak Stack, dengan pengisian operan dimulai
    dari posisi paling kanan.        

*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        .method public static 
                void Main () cil managed 
        {
            .entrypoint
            .maxstack 8
            ret
        }

        // operasi aritmetik pada kedua operan sama (integer)
        .method public instance 
                void _int_arithmetic () cil managed 
        {
        // ADD (penjumlahan)
            ldc.i4      2
            ldc.i4      1   // [2, 1]
            add             // [1 + 2]

            // penjumlahan dua nilai signed integer dengan pemeriksaan overflow
            ldc.i4      4
            ldc.i4      3   // [3, 4]
            add.ovf         // [4 + 3]
            
            // penjumlahan dua nilai unsigned integer dengan pemeriksaan overflow
            ldc.i4      6
            ldc.i4      5   // [5, 6]
            add.ovf.un      // [6 + 5]

        // SUB (pengurangan)
            ldc.i4      8
            ldc.i4      7   // [7, 8]
            sub             // [8 - 7]

            // pengurangan dua nilai signed
            ldc.i4      10
            ldc.i4      9   // [9, 10]
            sub.ovf         // [10 - 9]

            // pengurangan dua nilai unsigned 
            ldc.i4      12
            ldc.i4      11  // [11, 12]
            sub.ovf.un      // [12 - 11]

        // MUL (perkalian)
            ldc.i4      14
            ldc.i4      13  // [2, 1]
            mul             // [14 * 13 = 182]

            // perkalian dua nilai signed
            ldc.i4      16
            ldc.i4      15  // [15, 16]
            mul.ovf         // [16 * 15 = 240]

            // perkalian dua nilai unsigned 
            ldc.i4      18
            ldc.i4      17  // [17, 18]
            mul.ovf.un      // [18 * 17 = 306]

        // DIV (pembagian)
            // pembagian dengan mengembalikan hasil bagi
            ldc.i4      20
            ldc.i4      2   // [2, 20]
            div             // [20 / 2 = 10]

            // pembagian dua nilai unsigned dan mengembalikan hasil bagi
            ldc.i4      22
            ldc.i4      11  // [11, 22]
            div.un          // [22 / 11 = 2]

        // REM (sisa bagi)
            ldc.i4      24
            ldc.i4      21  // [21, 24]
            rem             // [24 % 21 = 3]  

            ldc.i4      26
            ldc.i4      22  // [22, 26]
            rem.un          // [26 % 22 = 4]

            ret 
        }

        // operasi aritmetik pada kedua operan sama (float)
        .method public instance 
                void _fp_arithmetic () cil managed 
        {
        // ADD (penjumlahan)
            ldc.r4      2
            ldc.r4      1   // [2, 1]
            add             // [1 + 2]

            // penjumlahan dua nilai signed integer dengan pemeriksaan overflow
            ldc.r4      4
            ldc.r4      3   // [3, 4]
            add.ovf         // [4 + 3]
            
            // penjumlahan dua nilai unsigned integer dengan pemeriksaan overflow
            ldc.r4      6
            ldc.r4      5   // [5, 6]
            add.ovf.un      // [6 + 5]

        // SUB (pengurangan)
            ldc.r4      8
            ldc.r4      7   // [7, 8]
            sub             // [8 - 7]

            // pengurangan dua nilai signed
            ldc.r4      10
            ldc.r4      9   // [9, 10]
            sub.ovf         // [10 - 9]

            // pengurangan dua nilai unsigned 
            ldc.r4      12
            ldc.r4      11  // [11, 12]
            sub.ovf.un      // [12 - 11]

        // MUL (perkalian)
            ldc.r4      14
            ldc.r4      13  // [2, 1]
            mul             // [14 * 13 = 182]

            // perkalian dua nilai signed
            ldc.r4      16
            ldc.r4      15  // [15, 16]
            mul.ovf         // [16 * 15 = 240]

            // perkalian dua nilai unsigned 
            ldc.r4      18
            ldc.r4      17  // [17, 18]
            mul.ovf.un      // [18 * 17 = 306]

        // DIV (pembagian)
            // pembagian dengan mengembalikan hasil bagi
            ldc.r4      20
            ldc.r4      2   // [2, 20]
            div             // [20 / 2 = 10]

            // pembagian dua nilai unsigned dan mengembalikan hasil bagi
            ldc.r4      22
            ldc.r4      11  // [11, 22]
            div.un          // [22 / 11 = 2]

        // REM (sisa bagi)
            ldc.r4      24
            ldc.r4      21  // [21, 24]
            rem             // [24 % 21 = 3]  

            ldc.r4      26
            ldc.r4      22  // [22, 26]
            rem.un          // [26 % 22 = 4]

            ret
        }

        // operasi aritmetik pada operan yang berbeda (integer dan float)
        .method public instance 
                void _mix_arithmetic () cil managed 
        {
            /*
                Operasi aritmetik dilakukan terhadap kedua operan yang memiliki
                tipe data yang sama. Apabila kedua operan berbeda tipe, maka 
                salah satu operan akan harus dikonversi terlebih dahulu ke tipe 
                yang sesuai. Jika tidak, operasi akan menghasilkan nilai yang 
                tidak sesuai harapan.
            */

        // ADD (penjumlahan)
            ldc.i4      2
            conv.r4 
            ldc.r4      1   // [2, 1]
            add             // [1 + 2]

            // penjumlahan dua nilai signed integer dengan pemeriksaan overflow
            ldc.r4      4
            ldc.i4      3   // [3, 4]
            conv.r4 
            add.ovf         // [4 + 3]
            
            // penjumlahan dua nilai unsigned integer dengan pemeriksaan overflow
            ldc.i4      6
            conv.r4 
            ldc.r4      5   // [5, 6]
            add.ovf.un      // [6 + 5]

        // SUB (pengurangan)
            ldc.i4      8
            conv.r4 
            ldc.r4      7   // [7, 8]
            sub             // [8 - 7]

            // pengurangan dua nilai signed
            ldc.r4      10
            ldc.i4      9   // [9, 10]
            conv.r4 
            sub.ovf         // [10 - 9]

            // pengurangan dua nilai unsigned 
            ldc.i4      12
            conv.r4 
            ldc.r4      11  // [11, 12]
            sub.ovf.un      // [12 - 11]

        // MUL (perkalian)
            ldc.i4      14
            conv.r4 
            ldc.r4      13  // [2, 1]
            mul             // [14 * 13 = 182]

            // perkalian dua nilai signed
            ldc.r4      16
            ldc.i4      15  // [15, 16]
            conv.r4 
            mul.ovf         // [16 * 15 = 240]

            // perkalian dua nilai unsigned 
            ldc.i4      18
            conv.r4 
            ldc.r4      17  // [17, 18]
            mul.ovf.un      // [18 * 17 = 306]

        // DIV (pembagian)
            // pembagian dengan mengembalikan hasil bagi
            ldc.i4      20
            conv.r4 
            ldc.r4      2   // [2, 20]
            div             // [20 / 2 = 10]

            // pembagian dua nilai unsigned dan mengembalikan hasil bagi
            ldc.r4      22
            ldc.i4      11  // [11, 22]
            conv.r4 
            div.un          // [22 / 11 = 2]

        // REM (sisa bagi)
            ldc.i4      24
            conv.r4 
            ldc.r4      21  // [21, 24]
            rem             // [24 % 21 = 3]  

            ldc.r4      26
            ldc.i4      22  // [22, 26]
            conv.r4 
            rem.un          // [26 % 22 = 4]

            ret
        }
    }
}