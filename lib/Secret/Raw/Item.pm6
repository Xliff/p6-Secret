use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;
use Secret::Raw::Structs;

unit package Secret::Raw::Item;
;
### /usr/include/libsecret-1/libsecret/secret-item.h

sub secret_item_create (
  SecretCollection      $collection,
  SecretSchema          $schema,
  GHashTable            $attributes,
  Str                   $label,
  SecretValue           $value,
  SecretItemCreateFlags $flags,
  GCancellable          $cancellable,
                        &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer              $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_create_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretItem
  is native(secret)
  is export
{ * }

sub secret_item_create_sync (
  SecretCollection        $collection,
  SecretSchema            $schema,
  GHashTable              $attributes,
  Str                     $label,
  SecretValue             $value,
  SecretItemCreateFlags   $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretItem
  is native(secret)
  is export
{ * }

sub secret_item_delete (
  SecretItem   $self,
  GCancellable $cancellable,
               &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_delete_finish (
  SecretItem              $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_delete_sync (
  SecretItem              $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_get_attributes (SecretItem $self)
  returns GHashTable
  is native(secret)
  is export
{ * }

sub secret_item_get_created (SecretItem $self)
  returns guint64
  is native(secret)
  is export
{ * }

sub secret_item_get_flags (SecretItem $self)
  returns SecretItemFlags
  is native(secret)
  is export
{ * }

sub secret_item_get_label (SecretItem $self)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_item_get_locked (SecretItem $self)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_get_modified (SecretItem $self)
  returns guint64
  is native(secret)
  is export
{ * }

sub secret_item_get_schema_name (SecretItem $self)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_item_get_secret (SecretItem $self)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_item_get_service (SecretItem $self)
  returns SecretService
  is native(secret)
  is export
{ * }

sub secret_item_get_type ()
  returns GType
  is native(secret)
  is export
{ * }

sub secret_item_load_secret (
  SecretItem   $self,
  GCancellable $cancellable,
               &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_load_secret_finish (
  SecretItem              $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_load_secret_sync (
  SecretItem              $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_load_secrets (
  GList        $items,
  GCancellable $cancellable,
               &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_load_secrets_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_load_secrets_sync (
  GList                   $items,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_refresh (SecretItem $self)
  is native(secret)
  is export
{ * }

sub secret_item_set_attributes (
  SecretItem   $self,
  SecretSchema $schema,
  GHashTable   $attributes,
  GCancellable $cancellable,
               &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_set_attributes_finish (
  SecretItem              $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_set_attributes_sync (
  SecretItem              $self,
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_set_label (
  SecretItem   $self,
  Str          $label,
  GCancellable $cancellable,
               &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_set_label_finish (
  SecretItem              $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_set_label_sync (
  SecretItem              $self,
  Str                     $label,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_set_secret (
  SecretItem   $self,
  SecretValue  $value,
  GCancellable $cancellable,
               &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_set_secret_finish (
  SecretItem              $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_item_set_secret_sync (
  SecretItem              $self,
  SecretValue             $value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }
