use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;
use Secret::Raw::Structs;

unit package Secret::Raw::Password;

### /usr/include/libsecret-1/libsecret/secret-password.h

sub secret_password_clear (
  SecretSchema $schema,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_clear_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_clear_sync (
  SecretSchema            $schema,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_clearv (
  SecretSchema $schema,
  GHashTable   $attributes,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_clearv_sync (
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_free (Str $password)
  is native(secret)
  is export
{ * }

sub secret_password_lookup (
  SecretSchema $schema,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_lookup_binary_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_password_lookup_binary_sync (
  SecretSchema            $schema,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_password_lookup_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_password_lookup_nonpageable_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_password_lookup_nonpageable_sync (
  SecretSchema            $schema,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_password_lookup_sync (
  SecretSchema            $schema,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_password_lookupv (
  SecretSchema $schema,
  GHashTable   $attributes,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_lookupv_binary_sync (
  SecretSchema $schema,
  GHashTable $attributes,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_password_lookupv_nonpageable_sync (
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_password_lookupv_sync (
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

multi sub secret_password_search (
  SecretSchema      $schema,
  SecretSearchFlags $flags,
  GCancellable      $cancellable,
                    &callback (GObject, GAsyncResult, gpointer),
  gpointer          $user_data,
  Str               $attribute,
  Str               $value,
  Str
)
  is native(secret)
  is export
{ * }

multi sub secret_password_search (
  SecretSchema      $schema,
  SecretSearchFlags $flags,
  GCancellable      $cancellable,
                    &callback (GObject, GAsyncResult, gpointer),
  gpointer          $user_data,
  Str               $attribute,
  uint64            $value,
  Str
)
  is native(secret)
  is export
{ * }

multi sub secret_password_search (
  SecretSchema      $schema,
  SecretSearchFlags $flags,
  GCancellable      $cancellable,
                    &callback (GObject, GAsyncResult, gpointer),
  gpointer          $user_data,
  Str               $attribute,
  int64             $value,
  Str
)
  is native(secret)
  is export
{ * }


sub secret_password_search_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(secret)
  is export
{ * }

multi sub secret_password_search_sync (
  SecretSchema            $schema,
  SecretSearchFlags       $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  Str                     $value
)
  returns GList
  is native(secret)
  is export
{ * }

multi sub secret_password_search_sync (
  SecretSchema            $schema,
  SecretSearchFlags       $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  uint64                  $value,
  Str
)
  returns GList
  is native(secret)
  is export
{ * }

multi sub secret_password_search_sync (
  SecretSchema            $schema,
  SecretSearchFlags       $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  int64                   $value,
  Str
)
  returns GList
  is native(secret)
  is export
{ * }

sub secret_password_searchv (
  SecretSchema      $schema,
  GHashTable        $attributes,
  SecretSearchFlags $flags,
  GCancellable      $cancellable,
                    &callback (GObject, GAsyncResult, gpointer),
  gpointer          $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_searchv_sync (
  SecretSchema            $schema,
  GHashTable              $attributes,
  SecretSearchFlags       $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(secret)
  is export
{ * }

multi sub secret_password_store (
  SecretSchema $schema,
  Str          $collection,
  Str          $label,
  Str          $password,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data,
  Str          $attribute,
  Str          $value,
  Str
)
  is native(secret)
  is export
{ * }
multi sub secret_password_store (
  SecretSchema $schema,
  Str          $collection,
  Str          $label,
  Str          $password,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data,
  Str          $attribute,
  uint64       $value,
  Str
)
  is native(secret)
  is export
{ * }
multi sub secret_password_store (
  SecretSchema $schema,
  Str          $collection,
  Str          $label,
  Str          $password,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data,
  Str          $attribute,
  int64        $value,
  Str
)
  is native(secret)
  is export
{ * }

multi sub secret_password_store_binary (
  SecretSchema $schema,
  Str          $collection,
  Str          $label,
  SecretValue  $value,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data,
  Str          $attribute,
  Str          $attr-value,
  Str
)
  is native(secret)
  is export
{ * }
multi sub secret_password_store_binary (
  SecretSchema $schema,
  Str          $collection,
  Str          $label,
  SecretValue  $value,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data,
  Str          $attribute,
  uint64       $attr-value,
  Str
)
  is native(secret)
  is export
{ * }
multi sub secret_password_store_binary (
  SecretSchema $schema,
  Str          $collection,
  Str          $label,
  SecretValue  $value,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data,
  Str          $attribute,
  int64        $attr-value,
  Str
)
  is native(secret)
  is export
{ * }


multi sub secret_password_store_binary_sync (
  SecretSchema            $schema,
  Str                     $collection,
  Str                     $label,
  SecretValue             $value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  Str                     $attr-value,
  Str
)
  returns uint32
  is native(secret)
  is export
{ * }
multi sub secret_password_store_binary_sync (
  SecretSchema            $schema,
  Str                     $collection,
  Str                     $label,
  SecretValue             $value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  uint64                  $attr-value,
  Str
)
  returns uint32
  is native(secret)
  is export
{ * }
multi sub secret_password_store_binary_sync (
  SecretSchema            $schema,
  Str                     $collection,
  Str                     $label,
  SecretValue             $value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  int64                   $attr-value,
  Str
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_store_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

multi sub secret_password_store_sync (
  SecretSchema            $schema,
  Str                     $collection,
  Str                     $label,
  Str                     $password,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  Str                     $attr,
  Str
)
  returns uint32
  is native(secret)
  is export
{ * }
multi sub secret_password_store_sync (
  SecretSchema            $schema,
  Str                     $collection,
  Str                     $label,
  Str                     $password,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  uint64                  $value,
  Str
)
  returns uint32
  is native(secret)
  is export
{ * }
multi sub secret_password_store_sync (
  SecretSchema            $schema,
  Str                     $collection,
  Str                     $label,
  Str                     $password,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error,
  Str                     $attribute,
  int64                   $value,
  Str
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_storev (
  SecretSchema $schema,
  GHashTable   $attributes,
  Str          $collection,
  Str          $label,
  Str          $password,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_storev_binary (
  SecretSchema $schema,
  GHashTable   $attributes,
  Str          $collection,
  Str          $label,
  SecretValue  $value,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_password_storev_binary_sync (
  SecretSchema            $schema,
  GHashTable              $attributes,
  Str                     $collection,
  Str                     $label,
  SecretValue             $value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_storev_sync (
  SecretSchema            $schema,
  GHashTable              $attributes,
  Str                     $collection,
  Str                     $label,
  Str                     $password,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_password_wipe (Str $password)
  is native(secret)
  is export
{ * }
