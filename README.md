# DramaSocmed Smart Contract

DramaSocmed adalah Smart Contract Ethereum yang memungkinkan pengguna untuk menambahkan dan mengelola drama serta topik terkait. Contract ini menggunakan `Ownable` untuk menentukan kepemilikan contract dan mengizinkan pemilik untuk melakukan tindakan tertentu seperti menghancurkan contract.

## Fitur

-  **Menambah Drama Baru**: Pengguna dapat menambahkan drama baru dengan kode dan deskripsi.
-  **Menambah Topik pada Drama**: Pengguna dapat menambahkan topik terkait pada drama yang ada dengan tautan.
-  **Menghapus Topik**: Pengguna dapat menghapus topik yang mereka buat.
-  **Menghancurkan Contract**: Pemilik contract dapat menghancurkan contract dan mengirim sisa ether kembali kepada pemilik.

### Functions

-  `tambahDramaBaru(string memory kode, string memory deskripsi) external returns (uint256)`: Menambahkan drama baru dan mengembalikan ID drama baru.
-  `tambahTopikDrama(string memory link, uint256 idDrama) external returns (uint256)`: Menambahkan topik baru ke drama yang ada dan mengembalikan ID topik baru.
-  `hapusTopikDrama(uint256 idDrama, uint256 idTopik) external returns (bool)`: Menghapus topik dari drama jika pemanggil adalah pembuat topik.
-  `destroyContract() public onlyOwner`: Menghancurkan contract dan mengirim sisa ether ke pemilik contract.

## Instalasi dan Penggunaan

### Requirement

-  Node.js
-  Truffle
-  Ganache

### Langkah-langkah

1. Clone repository ini

2. Install dependencies:

   ```sh
   npm install
   ```

3. Compile contract:

   ```sh
   npx truffle compile
   ```

4. Deploy contract:

   ```sh
   npx truffle migrate
   ```

### Interaksi dengan Contract

Kamu dapat berinteraksi dengan Contract menggunakan Truffle console atau script yang kamu buat sendiri. Berikut adalah beberapa contoh perintah:

Masuk ke Truffle console

```sh
truffle console
```

```js
// Tambah drama baru
DramaSocmed.deployed().then((instance) =>
   instance.tambahDramaBaru("Kode123", "Deskripsi drama")
);

// Tambah topik baru ke drama dengan ID 1
DramaSocmed.deployed().then((instance) =>
   instance.tambahTopikDrama("http://linktopik.com", 1)
);

// Hapus topik dengan ID 0 dari drama dengan ID 1
DramaSocmed.deployed().then((instance) => instance.hapusTopikDrama(1, 0));

// Hancurkan contract (hanya pemilik yang dapat melakukan ini)
DramaSocmed.deployed().then((instance) => instance.destroyContract());
```

## Lisensi

Project ini dilisensikan di bawah lisensi MIT.
