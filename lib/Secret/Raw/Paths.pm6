use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;
use Secret::Raw::Structs;

unit package Secret::Raw::Paths;

### /usr/include/libsecret-1/libsecret/secret-paths.h

sub secret_collection_new_for_dbus_path (
  SecretService         $service,
  Str                   $collection_path,
  SecretCollectionFlags $flags,
  GCancellable          $cancellable,
                        &callback (SecretService, GAsyncResult, gpointer),
  gpointer              $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_new_for_dbus_path_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretCollection
  is native(secret)
  is export
{ * }

sub secret_collection_new_for_dbus_path_sync (
  SecretService           $service,
  Str                     $collection_path,
  SecretCollectionFlags   $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretCollection
  is native(secret)
  is export
{ * }

sub secret_collection_search_for_dbus_paths (
  SecretCollection $collection,
  SecretSchema     $schema,
  GHashTable       $attributes,
  GCancellable     $cancellable,
                   &callback,
  gpointer         $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_search_for_dbus_paths_finish (
  SecretCollection        $collection,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_collection_search_for_dbus_paths_sync (
  SecretCollection        $collection,
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_item_new_for_dbus_path (
  SecretService   $service,
  Str             $item_path,
  SecretItemFlags $flags,
  GCancellable    $cancellable,
                  &callback,
  gpointer        $user_data
)
  is native(secret)
  is export
{ * }

sub secret_item_new_for_dbus_path_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretItem
  is native(secret)
  is export
{ * }

sub secret_item_new_for_dbus_path_sync (
  SecretService           $service,
  Str                     $item_path,
  SecretItemFlags         $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretItem
  is native(secret)
  is export
{ * }

sub secret_service_create_collection_dbus_path (
  SecretService               $self,
  GHashTable                  $properties,
  Str                         $alias,
  SecretCollectionCreateFlags $flags,
  GCancellable                $cancellable,
                              &callback,
  gpointer                    $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_create_collection_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_create_collection_dbus_path_sync (
  SecretService $self,
  GHashTable $properties,
  Str $alias,
  SecretCollectionCreateFlags $flags,
  GCancellable                $cancellable,
  CArray[Pointer[GError]]     $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_create_item_dbus_path (
  SecretService         $self,
  Str                   $collection_path,
  GHashTable            $properties,
  SecretValue           $value,
  SecretItemCreateFlags $flags,
  GCancellable          $cancellable,
                        &callback,
  gpointer              $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_create_item_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_create_item_dbus_path_sync (
  SecretService           $self,
  Str                     $collection_path,
  GHashTable              $properties,
  SecretValue             $value,
  SecretItemCreateFlags   $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_decode_dbus_secret (
  SecretService $service,
  GVariant      $value
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_service_delete_item_dbus_path (
  SecretService $self,
  Str           $item_path,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_delete_item_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_delete_item_dbus_path_sync (
  SecretService           $self,
  Str                     $item_path,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_encode_dbus_secret (
  SecretService $service,
  SecretValue   $value
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_service_get_secret_for_dbus_path (
  SecretService $self,
  Str           $item_path,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_get_secret_for_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_service_get_secret_for_dbus_path_sync (
  SecretService           $self,
  Str                     $item_path,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_service_get_secrets_for_dbus_paths (
  SecretService $self,
  Str           $item_paths,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_get_secrets_for_dbus_paths_finish (
  SecretService $self,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GHashTable
  is native(secret)
  is export
{ * }

sub secret_service_get_secrets_for_dbus_paths_sync (
  SecretService           $self,
  Str                     $item_paths,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GHashTable
  is native(secret)
  is export
{ * }

sub secret_service_get_session_dbus_path (SecretService $self)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_lock_dbus_paths (
  SecretService $self,
  CArray[Str]   $paths,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_lock_dbus_paths_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[CArray[Str]]     $locked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }

sub secret_service_lock_dbus_paths_sync (
  SecretService           $self,
  CArray[Str]             $paths,
  GCancellable            $cancellable,
  CArray[CArray[Str]]     $locked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }

sub secret_service_prompt_at_dbus_path (
  SecretService $self,
  Str           $prompt_path,
  GVariantType  $return_type,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_prompt_at_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_service_prompt_at_dbus_path_sync (
  SecretService           $self,
  Str                     $prompt_path,
  GCancellable            $cancellable,
  GVariantType            $return_type,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_service_read_alias_dbus_path (
  SecretService $self,
  Str           $alias,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_read_alias_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_read_alias_dbus_path_sync (
  SecretService           $self,
  Str                     $alias,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_service_search_for_dbus_paths (
  SecretService $self,
  SecretSchema  $schema,
  GHashTable    $attributes,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_search_for_dbus_paths_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[CArray[Str]]     $unlocked,
  CArray[CArray[Str]]     $locked,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_search_for_dbus_paths_sync (
  SecretService           $self,
  SecretSchema            $schema,
  GHashTable              $attributes,
  GCancellable            $cancellable,
  CArray[CArray[Str]]     $unlocked,
  CArray[CArray[Str]]     $locked,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_set_alias_to_dbus_path (
  SecretService $self,
  Str           $alias,
  Str           $collection_path,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_set_alias_to_dbus_path_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_set_alias_to_dbus_path_sync (
  SecretService           $self,
  Str                     $alias,
  Str                     $collection_path,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_service_unlock_dbus_paths (
  SecretService $self,
  Str           $paths,
  GCancellable  $cancellable,
                &callback,
  gpointer      $user_data
)
  is native(secret)
  is export
{ * }

sub secret_service_unlock_dbus_paths_finish (
  SecretService           $self,
  GAsyncResult            $result,
  CArray[CArray[Str]]     $unlocked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }

sub secret_service_unlock_dbus_paths_sync (
  SecretService           $self,
  Str                     $paths,
  GCancellable            $cancellable,
  CArray[CArray[Str]]     $unlocked,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(secret)
  is export
{ * }
