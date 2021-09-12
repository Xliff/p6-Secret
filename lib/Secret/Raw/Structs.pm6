use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;

unit package Secret::Raw::Structs;

class SecretCollection is repr<CStruct> is export {
  has GDBusProxy              $.parent;
  has gpointer                $!pv    ; #= SecretCollectionPrivate
}

class SecretCollectionClass is repr<CStruct> is export {
  has gpointer                $.parent_class; #= GDBusProxyClass
  has gpointer                $!padding     ;
}

class SecretItem is repr<CStruct> is export {
  has GDBusProxy              $.parent_instance;
  has gpointer                $!pv             ; #= SecretItem
}

class SecretItemClass is repr<CStruct> is export {
  has gpointer                $.parent_class; #= GDBusProxyClass
  has gpointer                $!padding     ;
}

class SecretPrompt is repr<CStruct> is export {
  has GDBusProxy              $.parent_instance;
  has gpointer                $!pv             ; #= SecretPrompt
}

class SecretPromptClass is repr<CStruct> is export {
  has gpointer                $.parent_class; #= GDBusProxyClass
  has gpointer                $!padding     ;
}

class SecretService is repr<CStruct> is export {
  has GDBusProxy              $.parent;
  has gpointer                $!pv    ; #= SecretService
}

class SecretSchemaAttribute is repr<CStruct> is export {
  has Str                       $.name is rw;
  has SecretSchemaAttributeType $.type is rw;
}

class SecretSchema is repr<CStruct> is export {
  has Str                   $.name           is rw;
  has SecretSchemaFlags     $.flags          is rw;
  HAS SecretSchemaAttribute @.attributes[32] is CArray;

  # Private
  has gint     $!reserved;
  has gpointer $!reserved1;
  has gpointer $!reserved2;
  has gpointer $!reserved3;
  has gpointer $!reserved4;
  has gpointer $!reserved5;
  has gpointer $!reserved6;
  has gpointer $!reserved7;
}
