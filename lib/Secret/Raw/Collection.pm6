use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Enums;
use Secret::Raw::Structs;

unit package Secret::Raw::Collection;

### /usr/include/libsecret-1/libsecret/secret-collection.h

sub secret_collection_create (
  SecretService               $service,
  Str                         $label,
  Str                         $alias,
  SecretCollectionCreateFlags $flags,
  GCancellable                $cancellable,
                              &callback (
                                SecretCollection,
                                GAsyncResult,
                                gpointer
                              ),
  gpointer                    $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_create_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretCollection
  is native(secret)
  is export
{ * }

sub secret_collection_create_sync (
  SecretService               $service,
  Str                         $label,
  Str                         $alias,
  SecretCollectionCreateFlags $flags,
  GCancellable                $cancellable,
  CArray[Pointer[GError]]     $error
)
  returns SecretCollection
  is native(secret)
  is export
{ * }

sub secret_collection_delete (
  SecretCollection $self,
  GCancellable     $cancellable,
                   &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_delete_finish (
  SecretCollection        $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_collection_delete_sync (
  SecretCollection        $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_collection_for_alias (
  SecretService         $service,
  Str                   $alias,
  SecretCollectionFlags $flags,
  GCancellable          $cancellable,
                        &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer              $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_for_alias_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretCollection
  is native(secret)
  is export
{ * }

sub secret_collection_for_alias_sync (
  SecretService           $service,
  Str                     $alias,
  SecretCollectionFlags   $flags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretCollection
  is native(secret)
  is export
{ * }

sub secret_collection_get_created (SecretCollection $self)
  returns guint64
  is native(secret)
  is export
{ * }

sub secret_collection_get_flags (SecretCollection $self)
  returns SecretCollectionFlags
  is native(secret)
  is export
{ * }

sub secret_collection_get_items (SecretCollection $self)
  returns GList
  is native(secret)
  is export
{ * }

sub secret_collection_get_label (SecretCollection $self)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_collection_get_locked (SecretCollection $self)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_collection_get_modified (SecretCollection $self)
  returns guint64
  is native(secret)
  is export
{ * }

sub secret_collection_get_service (SecretCollection $self)
  returns SecretService
  is native(secret)
  is export
{ * }

sub secret_collection_get_type ()
  returns GType
  is native(secret)
  is export
{ * }

sub secret_collection_load_items (
  SecretCollection $self,
  GCancellable     $cancellable,
                   &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_load_items_finish (
  SecretCollection        $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_collection_load_items_sync (
  SecretCollection        $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_collection_refresh (SecretCollection $self)
  is native(secret)
  is export
{ * }

sub secret_collection_search (
  SecretCollection  $self,
  SecretSchema      $schema,
  GHashTable        $attributes,
  SecretSearchFlags $flags,
  GCancellable      $cancellable,
                    &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer          $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_search_finish (
  SecretCollection        $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(secret)
  is export
{ * }

sub secret_collection_search_sync (
  SecretCollection        $self,
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

sub secret_collection_set_label (
  SecretCollection $self,
  Str              $label,
  GCancellable     $cancellable,
                   &callback (SecretCollection, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(secret)
  is export
{ * }

sub secret_collection_set_label_finish (
  SecretCollection        $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }

sub secret_collection_set_label_sync (
  SecretCollection        $self,
  Str                     $label,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(secret)
  is export
{ * }
