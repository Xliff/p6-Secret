use v6.c;

use GLib::Raw::Memory;
use Secret::Raw::Types;
use Secret::Raw::Value;

use GLib::Roles::Object;

# BOXED

class Secret::Value {
  has SecretValue %!sv;

  submethod BUILD (:$secret-value) {
    $!sv = $secret-value;
  }

  method Secret::Raw::Definitions::SecretValue
  { $!sv }

  method new (Int() $length, Str() $content_type) {
    my gsize $l = $length;

    my $secret-value = secret_value_new($!sv, $length, $content_type);
  }

  method new_full (
    Str() $secret,
    Int() $length,
    Str() $content_type,
          &destroy       = &g_free
  ) {
    secret_value_new_full($!sv, $secret, $length, $content_type, $destroy);
  }

  method get (Int() $length) {
    my gsize $l = $length;

    secret_value_get($!sv, $length);
  }

  method get_content_type {
    secret_value_get_content_type($!sv);
  }

  method get_text {
    secret_value_get_text($!sv);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_value_get_type, $n, $t );
  }

  method ref {
    secret_value_ref($!sv);
    self;
  }

  method unref {
    secret_value_unref($!sv);
  }

  method unref_to_password (Int() $length) {
    my gsize $l = $length;

    secret_value_unref_to_password($!sv, $length);
  }

}
