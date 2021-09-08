use v6.c;

use GLib::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;

unit package Secret::Raw::Structs;

class SecretCollection is repr<CStruct> is export {
  has GDBusProxy              $.parent;
  has SecretCollectionPrivate $!pv    ;
}

class SecretCollectionClass is repr<CStruct> is export {
  has GDBusProxyClass         $.parent_class;
  has gpointer                $!padding     ;
}

class SecretItem is repr<CStruct> is export {
  has GDBusProxy              $.parent_instance;
  has SecretItemPrivate       $!pv             ;
}

class SecretItemClass is repr<CStruct> is export {
  has GDBusProxyClass         $.parent_class;
  has gpointer                $!padding     ;
}

class SecretPrompt is repr<CStruct> is export {
  has GDBusProxy              $.parent_instance;
  has SecretPromptPrivate     $!pv             ;
}

class SecretPromptClass is repr<CStruct> is export {
  has GDBusProxyClass         $.parent_class;
  has gpointer                $!padding     ;
}

class SecretService is repr<CStruct> is export {
  has GDBusProxy              $.parent;
  has SecretServicePrivate    $!pv    ;
}
