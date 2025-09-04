This is my Computer Organization & Assembly Language Course project
# 🔐 File Encryption & Decryption in Assembly Language

[![Assembly](https://img.shields.io/badge/Assembly-x86-blue)](https://en.wikipedia.org/wiki/X86_assembly_language)
[![Platform](https://img.shields.io/badge/Platform-DOS%20%7C%20MASM%20%7C%20TASM-orange)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success)](#)

---

## 📖 Overview

This project is a simple **file encryption and decryption program** written in **x86 Assembly (MASM/TASM, DOS interrupts)**.
It demonstrates how **XOR encryption** can be used to secure and restore text files at the **low-level system programming** layer.

---

## ✨ Features

✔ Encrypts a text file using a user-provided XOR key
✔ Decrypts the encrypted file back to its original form
✔ Uses **DOS interrupts (int 21h)** for file operations and I/O
✔ Processes data in **512-byte chunks** for efficiency
✔ Lightweight, educational, and works in **DOSBox**

---

## ⚙️ How It Works

1️⃣ User enters a **single-character XOR key**.
2️⃣ Program encrypts `input.txt` ➝ `output.txt`.
3️⃣ Program decrypts `output.txt` ➝ `decrypted.txt`.
4️⃣ Displays success/error messages during execution.

---

## 📂 Project Files

| File              | Description                                    |
| ----------------- | ---------------------------------------------- |
| **P.ASM**         | Assembly source code                           |
| **input.txt**     | File to be encrypted (must exist in directory) |
| **output.txt**    | Encrypted file                                 |
| **decrypted.txt** | Decrypted file (should match original input)   |

---

## ▶️ Usage

### 1. Assemble & Link

**Using MASM**

```bash
masm P.ASM;
link P.OBJ;
```

**Using TASM**

```bash
tasm P.ASM
tlink P.OBJ
```

### 2. Run the Program

```bash
P.EXE
```

### 3. Provide Input

* Enter a single-character XOR key when prompted
* Ensure `input.txt` exists in the same folder

---

## 📊 Example

**input.txt**

```
Hello, World!
```

**Key:** `A`

**output.txt** (encrypted, non-readable text)

```
ÈÊËÍÌþ...
```

**decrypted.txt**

```
Hello, World!
```

---

## 📦 Requirements

* MASM / TASM assembler
* DOS environment (or **DOSBox** for modern systems)
