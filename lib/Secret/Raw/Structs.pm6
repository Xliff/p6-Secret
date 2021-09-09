use v6.c;

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
