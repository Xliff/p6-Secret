use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;
use Secret::Raw::Structs;

unit package Secret::Raw::Service;

### /usr/include/libsecret-1/libsecret/secret-service.h

sub secret_service_clear (
  SecretService $service,
  SecretSchema  $schema,
  GHashTable    $attributes,
  GCancellable  $cancellable,
                &callback (SecretService, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_clear_finish (
  SecretService           $service,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_clear_sync (
  SecretService           $service,
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_disconnect ()
  is native(secret)
  is export
{ * }

sub secret_service_ensure_session (
  SecretService $self,
  GCancellable $cancellable,
  GAsyncReadyCallback &callback (SecretService, GAsyncResult, gpointer),
  gpointer $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_ensure_session_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_ensure_session_sync (
  SecretService           $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_get (
  SecretServiceFlags $flags,
  GCancellable       $cancellable,
                     &callback (SecretService, GAsyncResult, gpointer),
  gpointer           $user_data)

  is native(secret)
  is export
{ * }

sub secret_service_get_collection_gtype (SecretService $self)
  returns GType
  is native(secret)
  is export
{ * }

sub secret_service_get_collections (SecretService $self)
  returns GList
  is native(secret)
  is export
{ * }

sub secret_service_get_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretService
  is native(secret)
  is export
{ * }

sub secret_service_get_flags (SecretService $self)
  returns SecretServiceFlags
  is native(secret)
  is export
{ * }

sub secret_service_get_item_gtype (SecretService $self)
  returns GType
  is native(secret)
  is export
{ * }

sub secret_service_get_session_algorithms (SecretService $self)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_get_sync (
  SecretServiceFlags      $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretService
  is native(secret)
  is export
{ * }

sub secret_service_get_type ()
  returns GType
  is native(secret)
  is export
{ * }

sub secret_service_load_collections (
  SecretService $self,
  GCancellable  $cancellable,
                &callback (SecretService, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_load_collections_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_load_collections_sync (
  SecretService           $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_lock (
  SecretService $service,
  GList         $objects,
  GCancellable  $cancellable,
                &callback (SecretService, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_lock_finish (
  SecretService           $service,
  GAsyncResult            $result,
  GList                   $locked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }

sub secret_service_lock_sync (
  SecretService           $service,
  GList                   $objects,
  GCancellable            $cancellable,
  GList                   $locked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }

sub secret_service_lookup (
  SecretService       $service,
  SecretSchema        $schema,
  GHashTable          $attributes,
  GCancellable        $cancellable,
                      &callback (SecretService, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_lookup_finish (
  SecretService           $service,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_service_lookup_sync (
  SecretService           $service,
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_service_open (
  GType               $service_gtype,
  Str                 $service_bus_name,
  SecretServiceFlags  $flags,
  GCancellable        $cancellable,
                      &callback (SecretService, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_open_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretService
  is native(secret)
  is export
{ * }

sub secret_service_open_sync (
  GType                   $service_gtype,
  Str                     $service_bus_name,
  SecretServiceFlags      $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretService
  is native(secret)
  is export
{ * }

sub secret_service_prompt (
  SecretService $self,
  SecretPrompt  $prompt,
  GVariantType  $return_type,
  GCancellable  $cancellable,
                &callback (SecretService, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_prompt_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_service_prompt_sync (
  SecretService           $self,
  SecretPrompt            $prompt,
  GCancellable            $cancellable,
  GVariantType            $return_type,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_service_search (
  SecretService     $service,
  SecretSchema      $schema,
  GHashTable        $attributes,
  SecretSearchFlags $flags,
  GCancellable      $cancellable,
                    &callback (SecretService, GAsyncResult, gpointer),
  gpointer          $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_search_finish (
  SecretService           $service,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(secret)
  is export
{ * }

sub secret_service_search_sync (
  SecretService           $service,
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

sub secret_service_set_alias (
  SecretService    $service,
  Str              $alias,
  SecretCollection $collection,
  GCancellable     $cancellable,
                   &callback (SecretService, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_set_alias_finish (
  SecretService           $service,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_set_alias_sync (
  SecretService           $service,
  Str                     $alias,
  SecretCollection        $collection,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_store (
  SecretService $service,
  SecretSchema  $schema,
  GHashTable    $attributes,
  Str           $collection,
  Str           $label,
  SecretValue   $value,
  GCancellable  $cancellable,
                &callback (SecretService, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_store_finish (
  SecretService           $service,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_store_sync (
  SecretService           $service,
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

sub secret_service_unlock (
  SecretService $service,
  GList         $objects,
  GCancellable  $cancellable,
                &callback (SecretService, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_unlock_finish (
  SecretService           $service,
  GAsyncResult            $result,
  GList                   $unlocked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }

sub secret_service_unlock_sync (
  SecretService           $service,
  GList                   $objects,
  GCancellable            $cancellable,
  GList                   $unlocked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }
