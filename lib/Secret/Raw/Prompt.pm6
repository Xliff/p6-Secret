use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Secret::Raw::Definitions;
use Secret::Raw::Structs;

### /usr/include/libsecret-1/libsecret/secret-prompt.h

sub secret_prompt_get_type ()
  returns GType
  is native(secret)
  is export
{ * }

sub secret_prompt_perform (
  SecretPrompt $self,
  Str          $window_id,
  GVariantType $return_type,
  GCancellable $cancellable,
               &callback (SecretPrompt, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(secret)
  is export
{ * }

sub secret_prompt_perform_finish (
  SecretPrompt            $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_prompt_perform_sync (
  SecretPrompt            $self,
  Str                     $window_id,
  GCancellable            $cancellable,
  GVariantType            $return_type,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }

sub secret_prompt_run (
  SecretPrompt            $self,
  Str                     $window_id,
  GCancellable            $cancellable,
  GVariantType            $return_type,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(secret)
  is export
{ * }
