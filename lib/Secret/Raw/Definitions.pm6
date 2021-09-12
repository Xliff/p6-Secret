use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package Secret::Raw::Definitions;

constant secret is export = 'secret-1',v0;

#class SecretService is repr<CPointer> is export does GLib::Roles::Pointers { }
class SecretValue       is repr<CPointer> is export does GLib::Roles::Pointers { }
#class SecretSchema      is repr<CPointer> is export does GLib::Roles::Pointers { }
class SecretRetrievable is repr<CPointer> is export does GLib::Roles::Pointers { }
