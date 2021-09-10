use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;

unit package Secret::Raw::Retrievable;

### /usr/include/libsecret-1/libsecret/secret-retrievable.h

sub secret_retrievable_get_attributes (SecretRetrievable $self)
  returns GHashTable
  is native(secret)
  is export
{ * }

sub secret_retrievable_get_created (SecretRetrievable $self)
  returns guint64
  is native(secret)
  is export
{ * }

sub secret_retrievable_get_label (SecretRetrievable $self)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_retrievable_get_modified (SecretRetrievable $self)
  returns guint64
  is native(secret)
  is export
{ * }

sub secret_retrievable_retrieve_secret (
  SecretRetrievable $self,
  GCancellable      $cancellable,
                    &callback (SecretRetrievable, GAsyncResult, gpointer),
  gpointer          $user_data
)
  is native(secret)
  is export
{ * }

sub secret_retrievable_retrieve_secret_finish (
  SecretRetrievable       $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_retrievable_retrieve_secret_sync (
  SecretRetrievable       $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns SecretValue
  is native(secret)
  is export
{ * }
