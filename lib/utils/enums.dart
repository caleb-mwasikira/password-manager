enum RecordType {
  AUTH,
  FILES,
}

enum EncryptionType {
  AES_256,
  RSA,
  NONE, // For cases where data is in plaintext
}

enum FileType {
  IMAGE,
  AUDIO,
  VIDEO,
  CODE,
  DOCUMENT,
}

enum InputType {
  TEXT,
  EMAIL,
  PASSWORD,
  URL,
}
