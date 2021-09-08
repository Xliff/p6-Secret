use v6.c;

use GLib::Raw::Definitions;
use Secret::Raw::Definitions;

unit package Secret::Raw::Value;

### /usr/include/libsecret-1/libsecret/secret-value.h

sub secret_value_get (SecretValue $value, gsize $length)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_value_get_content_type (SecretValue $value)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_value_get_text (SecretValue $value)
  returns Str
  is native(secret)
  is export
{ * }

sub secret_value_get_type ()
  returns GType
  is native(secret)
  is export
{ * }

sub secret_value_new (Str $secret, gssize $length, Str $content_type)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_value_new_full (
  Str    $secret,
  gssize $length,
  Str    $content_type,
         &destroy (gpointer)
)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_value_ref (SecretValue $value)
  returns SecretValue
  is native(secret)
  is export
{ * }

sub secret_value_unref (gpointer $value)
  is native(secret)
  is export
{ * }

sub secret_value_unref_to_password (SecretValue $value, gsize $length)
  returns Str
  is native(secret)
  is export
{ * }
